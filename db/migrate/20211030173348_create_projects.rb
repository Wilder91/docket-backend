class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :kind 
      t.date :due_date
      t.boolean :complete, default: false
      t.boolean :template, default: false
      t.integer :user_id
      t.timestamps
    end
  end
end
