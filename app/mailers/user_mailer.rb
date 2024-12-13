class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  
  def confirmation_instructions(user, otp)
    @user = user
    @otp = otp
    
    message = "Your OTP for Incident Reporter is: #{otp}. Valid for 5 minutes. Do not share this code with anyone. Contact support if this wasn't you."
    uri = URI.parse("#{ENV['MNOTIFY_BASE_URL']}&to=#{@user.validated_phone}&msg=#{message}&sender_id=COCCU")
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
        data = JSON.parse(response.body)
        puts data
    else
        puts "Error: #{response.code} - #{response.message}"
    end
  end
end
