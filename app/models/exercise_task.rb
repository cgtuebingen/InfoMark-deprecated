class ExerciseTask < ActiveRecord::Base
  belongs_to :exercise_sheet
  has_many :exercise_subtasks

  mount_uploader :public_test, PublicTestFileUploader # Tells rails to use this uploader for this model.
  mount_uploader :private_test, PrivateTestFileUploader # Tells rails to use this uploader for this model.

  validates :order, presence: true
  validates :max_points, presence: true

  ratyrate_rateable "difficulty", "clearness"
end
