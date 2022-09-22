class User < ApplicationRecord
    has_secure_password
    has_many :projects 
    has_many :milestones, through: :projects

    validates :email, uniqueness: true
end
