module ProfilesHelper
  def gravatar_for(user, options = { size: 40, class: "" })
    size = options[:size]
    cls = options[:class].to_s

    unless user.avatar.blank?
      gravatar_url = user.avatar
      image_tag(gravatar_url, alt: user.first_name, class: "gravatar circ-img"+cls, height: size)
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = image_path("profil.png")
      image_tag(gravatar_url, alt: user.first_name, class: "gravatar circ-img"+cls, height: size)
    end
  end

  def visible_sheets(user, course)
      course.exercise_sheets.order(:order)
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

  def latest_submissions(user, course)
    tasks = course.active_sheet.exercise_tasks
    Submission.where(user_id: @user.id, exercise_task_id:tasks ).order(created_at:  :desc).limit(10)
  end

  def has_filled_out_data(user)
    if user.semester.blank? or user.student_number.blank? or user.subject.blank?
      false
    else
      true
    end
    #has_filled_out_data
  end

  def points_in_course(user, course)
    course.points_of(user)
  end
end
