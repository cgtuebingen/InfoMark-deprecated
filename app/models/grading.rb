class Grading < ActiveRecord::Base

  #obfuscate_id :spin => 23872389

  belongs_to :tutor, class_name: "User"
  belongs_to :user
  belongs_to :submission
end
