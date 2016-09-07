class Submission < ActiveRecord::Base

  obfuscate_id :spin => 92387238

  belongs_to :user
  belongs_to :exercise_task

  enum status: [ :queued, :failure, :finished ]

  validates :file, presence: true

  mount_uploader :file, StudentSubmissionUploader # Tells rails to use this uploader for this model.
  validates :exercise_task_id, presence: true # Make sure the owner's name is present.

  validates :file, file_size: { less_than: 4.megabytes }

  def obfuscated_id
    ScatterSwap.hash(id,92387238)
  end
  
end
