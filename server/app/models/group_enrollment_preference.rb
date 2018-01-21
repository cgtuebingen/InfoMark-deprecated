class GroupEnrollmentPreference < ActiveRecord::Base
  belongs_to :user
  belongs_to :course_group
end
