class User < ApplicationRecord
    has_many :projects 
    has_many :milestones, through: :projects

    validates :email, uniqueness: true
end
