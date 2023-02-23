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

   
end
