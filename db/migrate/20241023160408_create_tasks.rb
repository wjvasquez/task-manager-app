class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
