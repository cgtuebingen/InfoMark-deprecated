module EnrollmentsHelper
  def has_enrollment_rating(user,course)
    GroupEnrollmentPreference.where(user: user, course_group_id: CourseGroup.find(course).map(&:id))
  end
end
