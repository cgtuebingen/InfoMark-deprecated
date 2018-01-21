class AddGroupRefToGrading < ActiveRecord::Migration
  def change
    add_reference :gradings, :course_group, references: :course_groups, index: true
    add_foreign_key :gradings, :course_groups, column: :course_group_id
  end
end
