class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
    validates :name, presence:  {message: "GIVE US YOUR NAME"}
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
    
    has_many :projects 
    has_many :milestones, through: :projects
    has_many :templates


  def self.from_google(google_token)
    validator = GoogleIDToken::Validator.new
    
    begin
      # Replace the hardcoded client ID with the actual environment variable
     
begin
      #binding.pry
      google_payload = validator.check(google_token,'494043831138-f2m2q99nb0if9m034el6vp645n9sffsn.apps.googleusercontent.com')

      # Check if the Google user with this email already exists in your database
      google_email = google_payload['email']
      user = User.find_by(email: google_email)
     # binding.pry
      if user
        return user
      else
        # If the user doesn't exist, create a new user based on Google data
        user = User.create(
          email: google_email,
          # Set other attributes as needed
        )
        return user
      end
    rescue GoogleIDToken::ValidationError => e
      #binding.pry
      return nil # Token is not valid
    end
    puts "Google Token Audience: #{google_payload['aud']}"
    puts "Expected Audience: #{ENV['GOOGLE_CLIENT_ID']}"
  end
  end

  # ... (other code)
end