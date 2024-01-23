class AddGoogleIdToMilestones < ActiveRecord::Migration[6.1]
  def change
    add_column :milestones, :google_id, :string
  end
end
