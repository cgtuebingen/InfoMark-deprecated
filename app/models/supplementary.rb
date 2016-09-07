class Supplementary < ActiveRecord::Base
  belongs_to :course

  enum visibility: [:student, :tutor, :supertutor, :admin]

  mount_uploader :file, SupplementaryUploader # Tells rails to use this uploader for this model.
end
