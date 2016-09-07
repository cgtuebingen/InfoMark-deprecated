class Slide < ActiveRecord::Base
  belongs_to :course

  validates :lecture, presence: true

  mount_uploader :file, SlidesUploader # Tells rails to use this uploader for this model.
end
