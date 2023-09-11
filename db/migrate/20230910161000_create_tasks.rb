class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :assignedto
      t.string :submittedto
      t.boolean :completed
      t.datetime :submittedon
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
