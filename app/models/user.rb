require "uri"
require "json"
require "net/http"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  OTP_LENGTH = 6

  def send_confirmation_instructions
    token = SecureRandom.random_number(10**OTP_LENGTH).to_s.rjust(OTP_LENGTH, "0")
    self.confirmation_token = token
    self.confirmation_sent_at = Time.now.utc
    save(validate: false)
    UserMailer.confirmation_instructions(self, self.confirmation_token).deliver_now
  end

  def message_chat_gpt(messages)
    url = URI("https://api.openai.com/v1/chat/completions")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{ENV['OPENAI_API_KEY']}"
    request.body = JSON.dump({
      "model": "gpt-4o-mini",
      "messages": messages,
      "temperature": 0.7
    })

    response = https.request(request)
    body = response.read_body
    puts body
    JSON.parse(body)
  end
end
