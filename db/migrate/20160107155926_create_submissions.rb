class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :exercise_task, index: true, foreign_key: true
      t.string :file

      t.timestamps null: false
    end
  end
end
