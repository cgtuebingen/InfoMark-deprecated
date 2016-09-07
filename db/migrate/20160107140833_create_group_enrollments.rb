class CreateGroupEnrollments < ActiveRecord::Migration
  def change
    create_table :group_enrollments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :course_group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
