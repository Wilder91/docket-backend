class Project < ApplicationRecord
    belongs_to :user
    has_many :milestones
    accepts_nested_attributes_for :milestones
end
