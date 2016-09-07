class Globalnotification < ActiveRecord::Base
  enum visibility: [:student, :tutor, :supertutor, :admin]

  validates :start, presence: true
  validates :ends, presence: true
  validates :body, presence: true
end
