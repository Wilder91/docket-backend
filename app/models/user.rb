class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: { message: 'GIVE US YOUR NAME' }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }, unless: -> { from_google_sign_in? }

  has_many :projects
  has_many :milestones, through: :projects
  has_many :templates

  attr_accessor :sign_in_source

  def self.from_google(google_token)
   
    validator = GoogleIDToken::Validator.new

    begin
      google_payload = validator.check(google_token, '494043831138-f2m2q99nb0if9m034el6vp645n9sffsn.apps.googleusercontent.com')

      google_email = google_payload['email']
      google_name = google_payload['name']

      user = User.find_by(email: google_email)
      #binding.pry
      if user
        user.sign_in_source = 'google'
        return user
      else
        user = User.create(
          email: google_email,
          name: google_name,
          password: 'asjasflk'
        )
        user.sign_in_source = 'google'
        return user
      end
    rescue GoogleIDToken::ValidationError => e
      return nil # Token is not valid
    end
  end

  def from_google_sign_in?
    sign_in_source == 'google'
  end
end
