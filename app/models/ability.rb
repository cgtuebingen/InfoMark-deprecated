class Ability
  class << self
    def allowed(user, target)
      # return anonymous_abilities(user, target) if user.nil?
      return [] unless user.is_a?(User)

      Rails.logger.info "classname #{target.class.name}"

      case target.class.name
      when "Course"               then course_abilities(user, target)
      when "User"                 then user_abilities(user, target)
      when "CourseGroup"          then coursegroup_abilities(user, target)
      when "Group"                then group_abilities(user, target)
      when "Submission"           then submission_abilities(user, target)
      when "ExerciseSheet"        then exercise_sheet_abilities(user, target)
      when "Slide"                then slide_abilities(user, target)
      when "Supplementary"        then supplementary_abilities(user, target)
      when "Enrollment"           then enrollment_abilities(user, target)
      when "Grading"              then grading_abilities(user, target)
      when "Message"              then message_abilities(user, target)
      when "Globalnotification"   then globalnotification_abilities(user, target)
      when "Linecomment"          then linecomment_abilities(user, target)
      else []
      end
    end

    def course_abilities(user, target)
      rules = []
      return rules unless target.instance_of?(Course)

      rules << :see
      enrollment = Enrollment.find_by(user: user, course: target);

      unless enrollment.nil?
        rules << :edit_course  if enrollment.admin?
        rules << :manage       if enrollment.admin?
        rules << :grade       if Enrollment.where(user: user,  role: [1,2,3], course:target).any?
      end
      rules
    end

    def exam_abilities(user, target)
      rules = []
      return rules unless target.instance_of?(Exam)

      enrollment = Enrollment.find_by(user: user, course: target.course);

      unless enrollment.nil?
        rules << :manage       if enrollment.admin?
      end
      rules
    end

    def user_abilities(user, target)
      rules = []
      rules << :edit_user     if target.id == user.id
      rules << :show_courses  if target.id == user.id
      rules << :see           if target.id == user.id or Enrollment.where(user: user,  role: [1,2,3]).any?
      #rules << :manage        if user.root
      rules
    end

    def coursegroup_abilities(user, target)
      rules = []
      # can open the turor page
      rules << :open_tutor   if Enrollment.where(user: user).where.not(role: 0).any?
      # admin = enum 3
      rules << :is_admin     if Enrollment.where(user: user, role: 3).any?
      rules << :see_tutor_info  if Enrollment.where(user: user,  role: [1,2,3]).any?
      rules << :manage     if Enrollment.where(user: user, role: 3).any?
      rules << :send_all     if Enrollment.where(user: user, role: 3).any?

      unless target.id.nil?
        # role = Enrollment.find_by(user: user, course: target.course)
        rules << :show_groups   if Enrollment.where(user: user).where.not(role: 0).any?
        # rules << :show_groups   if role.admin? or role.tutor? or role.supertutor?
      end
      rules
    end

    def group_abilities(user, target)
      rules = []
      # can open the tutor page
      rules << :open_tutor   if Enrollment.where(user: user).where.not(role: 0).any?
      rules
    end

    def submission_abilities(user, target)
      rules = []
      return rules unless target.instance_of?(Submission)
      course_id = target.exercise_task.exercise_sheet.course
      # open the submission page (only owner)
      rules << :see                if (target.user_id == user.id) or Enrollment.where(user: user, course_id: course_id, role: [1,2,3]).any?
      rules << :see_private        if Enrollment.where(user: user, course_id: course_id, role: [1,2,3]).any?
      rules << :see_docker_log     if Enrollment.where(user: user, course_id: course_id, role: [1,2,3]).any?
      rules << :download           if (target.user_id == user.id) or Enrollment.where(user: user, course_id: course_id, role: [1,2,3]).any?
      rules << :comment        if Enrollment.where(user: user, course_id: course_id, role: [1,2,3]).any?
      rules
    end

    def exercise_sheet_abilities(user, sheet)
      rules = []
      return rules unless sheet.instance_of?(ExerciseSheet)

      course_id = sheet.course_id
      published = sheet.publish.to_i < DateTime.now.to_i

      # open exercise sheet page
      rules << :see  if published or Enrollment.where(user: user, course_id: course_id).where.not(role: 0).any?
      # edit exercise sheet
      rules << :manage if Enrollment.where(user: user, course_id: course_id, role: [2,3]).any?
      rules << :submit if Enrollment.where(user: user, course_id: course_id, role: [1,2,3]).any? or ((sheet.duedate.to_i > DateTime.now.to_i) and published)

      rules
    end

    def slide_abilities(user, sld)
      rules = []
      return rules unless sld.instance_of?(Slide)
      rules << :manage if Enrollment.where(user: user, course_id: sld.course_id, role: [3]).any?
      rules << :see if Enrollment.where(user: user, course_id: sld.course_id, role: [1,2,3]).any? or ((sld.public == true) and (sld.publish.to_i < DateTime.now.to_i))
      rules
    end

    def supplementary_abilities(user, sld)
      rules = []
      return rules unless sld.instance_of?(Supplementary)
      course_id = sld.course_id
      current_role = role_in_course(user, sld.course)
      rules << :see if sld[:visibility] <= current_role
      rules << :manage if Enrollment.where(user: user, course_id: sld.course_id, role: [3]).any?
      rules
    end

    def enrollment_abilities(user, sld)
      rules = []
      rules
    end

    def grading_abilities(user, sld)
      rules = []
      return rules unless sld.instance_of?(Grading)
      rules << :see if sld[:visibility] <= current_role
      rules
    end

    def message_abilities(user, sld)
      rules = []
      return rules unless sld.instance_of?(Message)
      rules << :manage if highest_role(user) > 0
      rules
    end

    def globalnotification_abilities(user, sld)
      rules = []
      return rules unless sld.instance_of?(GlobalNotification)
      rules
    end

    def linecomment_abilities(user, sld)
      rules = []
      #cid = sld.submission.exercise_task.exercise_sheet.course
      return rules unless sld.instance_of?(Linecomment)
      rules << :manage if highest_role(user) > 0
      rules
    end


    def abilities
      @abilities ||= begin
        abilities = Six.new
        abilities << self
        abilities
      end
    end

    private
    def role_in_course(user, course)
      # in rails 5 this is "my_model.sale_info_before_type_cast"

      Enrollment.where(user: user, course: course).first[:role]
    end

    def highest_role(user)
      Enrollment.roles[Enrollment.where(user: user).order(role: :desc).first.role]
    end


  end
end
