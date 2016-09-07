class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :title
      t.references :course, index: true, foreign_key: true
      t.datetime :date
      t.text :info

      t.timestamps null: false
    end
  end
end
