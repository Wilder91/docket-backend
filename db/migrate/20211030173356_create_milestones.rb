class CreateMilestones < ActiveRecord::Migration[6.1]
  def change
    create_table :milestones do |t|
      t.string :name
      t.text :description 
      t.date :due_date
      t.integer :lead_time
      t.boolean :complete, default: false
      t.integer :project_id
      t.timestamps
    end
  end
end
