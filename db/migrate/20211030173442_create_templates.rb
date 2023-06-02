class CreateTemplates < ActiveRecord::Migration[6.1]
 
  def change
    create_table :templates do |t|
      t.string :name
      t.json :milestones
      t.integer :user_id
      t.timestamps
    end
  end
end
