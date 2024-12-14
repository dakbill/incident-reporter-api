class Api::V1::UtilsController < ApplicationController
    OTP_EXPIRATION_TIME = 5.minutes.ago

    def send_otp
        validated_phone = params[:validated_phone]

        user = User.where(validated_phone: validated_phone).first

        if user.nil?
            return render json: { message: "No user with phone number #{validated_phone} found" }, status: 404
        end

        user.send_confirmation_instructions
        render json: { message: "OTP sent to #{validated_phone}" }
    end

    def validate_otp
        user = User.where(confirmation_token: params[:otp], validated_phone: params[:validated_phone]).first

        if user && user.confirmation_sent_at >= OTP_EXPIRATION_TIME
          #   user.confirm
          user.update(confirmation_token: nil)
          render json: { message: "OTP validated" }
        else
          render json: { message: "Invalid OTP" }, status: 401
        end
    end

    def options
        render json: Option.where(option_type: params[:option_type]).pluck(:name)
    end

    def suggestions
        suggestions = []

        case params[:inputName]
        when "suspects"
            suggestions = suspect_suggestions(params)
        when "items"
            suggestions = item_suggestions(params)
        when "implements"
            suggestions = implement_suggestions(params)
        end

        render json: suggestions
    end

    def search
        results = []

        case params[:entity]
        when "users"
            results = users_search(params)
        end

        render json: results
    end

    def message
        user = User.where(validated_phone: params[:validated_phone]).first
        user_text = params[:text]
        results = user.message_chat_gpt(
            [
                {
                "role": "system",
                "content": "You are a data analyst. Generate insightful SQL queries for a Postgres database based on user requests. Use appropriate table names and fields to extract useful information. When doing name searches, use contains."
                },
                {
                "role": "user",
                "content": "I have a database with the following schema:\n\n" +
                    "- `incidents`: id (integer), description (text), time_of_incident (timestamp), status (text)\n" +
                    "- `items`: id (integer), incident_id (integer), name (text) \n" +
                    "- `locations`: id (integer), incident_id (integer), description (text), lat (numeric), lng (numeric)\n" +
                    "- `actors`: id (integer), incident_id (integer), name (text)\n\n\n\n" +
                    "A victim is an actor with is_victim set to true\n" +
                    "A suspect is an actor with is_victim set to false\n" +
                    "A weapon or implement is an item with is_implement set to true\n" +
                    "A stolen or affected item is an item with is_implement set to false\n" +
                    user_text
                }
            ]
        )

        text = results["choices"][0]["message"]["content"]


        # Extract the SQL query between ```sql and ```
        sql_query = text.match(/```sql\s+(.*?)\s+```/m)[1]

        if sql_query
            puts sql_query
            result = ActiveRecord::Base.connection.select_all(sql_query)
            text = array_of_hashes_to_html_table(result.to_a)
        end

        render json: { sender: "bot", text: text }
    end

    private

    def implement_suggestions(params)
        Item.where(is_implement: true).where("name ILIKE ?", "%#{params[:q]}%").select(:name).distinct.limit(10).pluck(:name)
    end

    def suspect_suggestions(params)
        Actor.where(is_victim: false).where("name ILIKE ?", "%#{params[:q]}%").select(:name).distinct.limit(10).pluck(:name)
    end

    def item_suggestions(params)
        []
    end

    def users_search(params)
        User.all
    end

    def array_of_hashes_to_html_table(data)
        return "<p>No data available</p>" if data.empty?

        # Extract table headers from keys of the first hash
        headers = data.first.keys

        # Build the HTML table
        html = "<table border='1' class='table-auto'>"
        html << "<thead><tr>"

        # Add headers
        headers.each do |header|
          html << "<th>#{header}</th>"
        end
        html << "</tr></thead>"

        # Add rows
        html << "<tbody>"
        data.each do |row|
          html << "<tr>"
          headers.each do |header|
            html << "<td>#{row[header]}</td>"
          end
          html << "</tr>"
        end
        html << "</tbody></table>"

        html
    end
end
