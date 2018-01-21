class CourseGroup < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :course

  has_many :group_enrollments
  has_many :users, :through => :group_enrollments
  accepts_nested_attributes_for :group_enrollments

  def tutor
    User.find(user_id)
  end
end
