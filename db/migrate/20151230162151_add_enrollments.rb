class AddEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.integer :course_id

      t.timestamps null: false
    end

    add_index :enrollments, [:user_id, :course_id]
  end
end