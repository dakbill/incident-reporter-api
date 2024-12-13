class Api::V1::UtilsController < ApplicationController
    OTP_EXPIRATION_TIME = 5.minutes.ago

    def send_otp
        validated_phone = params[:validated_phone]

        user = User.where(validated_phone: validated_phone).first

        if user.nil?
            return render json: { message: "No user with phone number #{validated_phone} found" }, status: 404
        end
        
        user.send_confirmation_instructions
        render json: {message: "OTP sent to #{validated_phone}"}
    end

    def validate_otp
        user = User.where(confirmation_token: params[:otp], validated_phone: params[:validated_phone] ).first
    
        if user && user.confirmation_sent_at >= OTP_EXPIRATION_TIME
        #   user.confirm
          user.update(confirmation_token: nil)
          return render json: { message: "OTP validated" }
        else
          return render json: { message: "Invalid OTP" }, status: 401
        end
    end
    
    def options
        render json: Option.where(option_type: params[:option_type]).pluck(:name)
    end

    def suggestions
        suggestions = []

        case params[:inputName]
        when 'suspects'
            suggestions = suspect_suggestions(params)
        when 'items'
            suggestions = item_suggestions(params)
        when 'implements'
            suggestions = implement_suggestions(params)
        end
        
        render json: suggestions
    end

    # { id: v4(), label, name, type: inputName, nature: defaultNature[inputName] }
    private
    
    def implement_suggestions(params)
        Item.where(is_implement: true).where('name ILIKE ?', "%#{params[:q]}%").select(:name).distinct.limit(10).pluck(:name)
    end

    def suspect_suggestions(params)
        Actor.where(is_victim: false).where('name ILIKE ?', "%#{params[:q]}%").select(:name).distinct.limit(10).pluck(:name)
    end

    def item_suggestions(params)
        []
    end
end
