class CreateExerciseTasks < ActiveRecord::Migration
  def change
    create_table :exercise_tasks do |t|
      t.integer :order
      t.string :framework_file
      t.references :exercise_sheet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
