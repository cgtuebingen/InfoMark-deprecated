
class CollectionGenerator

  @queue = :system_queue
  def self.perform(sheet_id, group_id)

    log = Logger.new 'log/grading.log'
    # log.debug "fire for generating gradings for sheet 3"


    @sheet  = ExerciseSheet.find(sheet_id)
    @course = @sheet.course
    group = CourseGroup.find(group_id)
    @tasks  = @sheet.exercise_tasks
    @tmp_dir = Rails.application.secrets.upload_dir + "/collection/course#{@course.id}/sheet#{@sheet.id}"

    @unpack_dir = Rails.application.secrets.upload_dir + "/unpacked"

    system("rm -r #{@tmp_dir}")
    system("mkdir -p #{@tmp_dir}")

    system("mkdir -p #{@unpack_dir}")

    # get all groups
  

    # get all students in group
    system("mkdir #{@tmp_dir}/group#{group.id}")
    if !group.users.blank?
      for user in group.users
        safe_username = "#{user.first_name}_#{user.last_name}-#{SecureRandom.hex(2)}"
        safe_username = safe_username.gsub!(/[^0-9A-Za-z.\-]/, '_')
        system("mkdir #{@tmp_dir}/group#{group.id}/#{safe_username}")

        for task in @tasks
          # get latest submission from current user for current task
          latest_submission = Submission.where(user_id: user.id, exercise_task_id: task.id).order(id: :desc).first
          if !latest_submission.nil?
            # log.debug "--> #{latest_submission.id} #{latest_submission.file.path} "
            new_file = "task#{task.order}.zip"
            system("cp #{latest_submission.file.path} #{@tmp_dir}/group#{group.id}/#{safe_username}/#{new_file}")
            system("mkdir #{@unpack_dir}/#{latest_submission.id}")
            system("unzip  -o #{latest_submission.file.path} -d #{@unpack_dir}/#{latest_submission.id}")
          else
          end
        end
      end
    else
    end

    # zip dir per group
    system("tt=`pwd` && cd #{@tmp_dir}/group#{group.id} && zip -r #{@tmp_dir}/group#{group.id}.zip . && cd $tt")
  
  end
end
