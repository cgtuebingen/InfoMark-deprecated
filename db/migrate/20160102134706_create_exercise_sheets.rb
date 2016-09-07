class CreateExerciseSheets < ActiveRecord::Migration
  def change
    create_table :exercise_sheets do |t|
      t.references :course, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :order
      t.text :file
      t.datetime :publish
      t.datetime :duedate
      t.text :description

      t.timestamps null: false
    end
  end
end
