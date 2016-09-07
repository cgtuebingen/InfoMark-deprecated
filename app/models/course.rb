class Course < ActiveRecord::Base
  has_many :enrollments
  has_many :exercise_sheets
  has_many :course_groups
  has_many :users, :through => :enrollments, class_name: "User"
  has_many :slides
  has_many :exams
  has_many :supplementaries

  accepts_nested_attributes_for :enrollments

  # first sheet within duedate (others are comming later)
  def active_sheet
    exercise_sheets.where("duedate > ?" , Time.now).order(duedate: :asc).first || ExerciseSheet.new
  end

  def active_sheets
    exercise_sheets.where("duedate > ?" , Time.now).order(duedate: :asc) || []
  end

  # find all task for active sheet
  def current_tasks
    ct = []
    ct = active_sheet.exercise_tasks unless active_sheet.nil?
  end

  def points_of(user)
    PointsCache.where(user: user, exercise_sheet_id: exercise_sheets.pluck(:id)).sum(:points)
  end


end
