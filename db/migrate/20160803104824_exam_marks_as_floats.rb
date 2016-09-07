class ExamMarksAsFloats < ActiveRecord::Migration
  def change
    change_column :exam_grades, :mark, :float
    change_column :exam_grades, :points, :float
  end
end
