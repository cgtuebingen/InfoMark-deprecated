class EnrollmentRoles < ActiveRecord::Migration
  def change
    add_column :enrollments, :role, :integer, default: 0
  end
end
