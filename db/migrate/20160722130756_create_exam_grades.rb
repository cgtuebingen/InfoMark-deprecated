class CreateExamGrades < ActiveRecord::Migration
  def change
    create_table :exam_grades do |t|
      t.integer :points
      t.integer :mark
      t.text :info
      t.references :user, index: true, foreign_key: true
      t.references :exam, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
