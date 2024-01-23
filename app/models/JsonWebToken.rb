require 'jwt'

module JsonWebToken
  extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 24.hours.from_now)
   
    payload[:exp] = exp.to_i
    encoded_token = JWT.encode(payload, SECRET_KEY)
    puts "Encoded Token: #{encoded_token}" # Debugging line
    encoded_token
  end

  def self.decode(token)
    puts "Decoding Token: #{token}" # Debugging line
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  end
end