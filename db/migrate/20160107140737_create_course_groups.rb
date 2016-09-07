class CreateCourseGroups < ActiveRecord::Migration
  def change
    create_table :course_groups do |t|
      t.references :user, index: true, foreign_key: true
      t.string :info
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
