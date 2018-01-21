class User < ActiveRecord::Base
  #obfuscate_id :spin => 31415926
  ratyrate_rater

  has_many :enrollments
  has_many :group_enrollments
  has_many :gradings
  has_many :submission_infos
  has_many :courses, :through => :enrollments
  has_many :course_groups, :through => :group_enrollments
  accepts_nested_attributes_for :enrollments
  accepts_nested_attributes_for :group_enrollments

  mount_uploader :avatar, AvatarUploader

  
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable, :lockable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def subscribed?(course)
    courses.include?(course)
  end

  def admin
    true
  end
end
