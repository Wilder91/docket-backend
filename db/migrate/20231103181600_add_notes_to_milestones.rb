class AddNotesToMilestones < ActiveRecord::Migration[6.1]
  def change
    add_column :milestones, :notes, :text
  end
end
