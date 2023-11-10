class AddCompletionDateToMilestones < ActiveRecord::Migration[6.1]
  def change
    add_column :milestones, :completion_date, :date
  end
end
