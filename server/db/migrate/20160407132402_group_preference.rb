class GroupPreference < ActiveRecord::Migration
  def change
    create_table :group_enrollment_preferences do |t|
      t.references :user, index: true, foreign_key: true
      t.references :course_group, index: true, foreign_key: true
      t.integer :rating  # default 3, range 1...5

      t.timestamps null: false
    end
  end
end
