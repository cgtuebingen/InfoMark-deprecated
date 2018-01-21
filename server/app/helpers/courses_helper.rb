module CoursesHelper
  
  def team_of_course(course)
    User.where(id:Enrollment.where(course: course, role: [1,2,3]).map(&:user_id)).order(last_name: :asc)
  end

  def assigned_group(user, course)
    unless course.nil?
      @enrol = GroupEnrollment.where(user: user, course_group_id: course.course_groups.map(&:id))
      unless @enrol.empty?
        @enrol.first.course_group.info
      else
        "nicht zugewiesen"
      end
    end
  end
end
