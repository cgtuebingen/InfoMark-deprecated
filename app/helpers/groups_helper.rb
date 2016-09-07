module GroupsHelper
  def tutorlist_for_course(course)
    # returns all users with subscription to current course but no students
    @col = Enrollment.where(course: course).where.not(role: 0).map{ |r| [r.user.name, r.user.id]}
  end
end
