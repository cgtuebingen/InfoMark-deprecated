class PointsCache < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise_sheet
end
