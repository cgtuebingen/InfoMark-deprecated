class ExerciseSheet < ActiveRecord::Base
  belongs_to :course
  belongs_to :user   # author-creator

  has_many :exercise_tasks
  has_many :exercise_subtasks, :through => :exercise_tasks

  mount_uploader :file, ExerciseSheetFileUploader # Tells rails to use this uploader for this model.

  validates :publish, presence: true
  validates :duedate, presence: true
  validates :order, presence: true

end
