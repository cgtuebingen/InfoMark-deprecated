class ExamApproval < ActiveRecord::Migration
  def change
    add_column :courses, :show_exam_approval, :boolean, :default => false
    add_column :courses, :min_points, :integer,  default: 0
  end
end
