
class GradingGenerator

  @queue = :system_queue
  def self.perform(sheet_id)

    log = Logger.new 'log/grading.log'
    # log.debug "fire for generating gradings for sheet 3"


    @sheet  = ExerciseSheet.find(sheet_id)
    @course = @sheet.course
    @groups = @course.course_groups
    @tasks  = @sheet.exercise_tasks
    @tmp_dir = Rails.application.secrets.upload_dir + "/collection/course#{@course.id}/sheet#{@sheet.id}"
    txt = "keine Abgabe (bewertet mit 0 Punkten)" # etwas Text

    @unpack_dir = Rails.application.secrets.upload_dir + "/unpacked"

    system("rm -r #{@tmp_dir}")
    system("mkdir -p #{@tmp_dir}")

    system("mkdir -p #{@unpack_dir}")

    # get all groups
    if !@groups.blank?
      for group in @groups

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
                system("unzip  #{latest_submission.file.path} -d #{@unpack_dir}/#{latest_submission.id}")
                
                Grading.create!(
                  submission_id: latest_submission.id,
                  feedback: "",
                  points: 0,
                  course_group_id: group.id,
                  tutor_id: group.owner.id,
                  user_id: user.id,
                  exercise_sheet_id: @sheet.id
                )
              else
                s = Submission.new( 
                  user: user,
                  exercise_task: task,
                  file: Submission.first.file,
                  log: txt,
                  private_log: txt,
                  raw_log: txt,
                  status: 2
                )
                s.save!
                Grading.create!(
                  submission_id: s.id,
                  feedback: "automatisch erzeugte Bewertung, da keine Abgabe vorhanden -> 0 Punkte",
                  points: 0,
                  course_group_id: group.id,
                  tutor_id: group.owner.id,
                  user_id: user.id,
                  exercise_sheet_id: @sheet.id,
                  ready: true
                )
              end
            end
          end
        else
        end

        # zip dir per group
        system("tt=`pwd` && cd #{@tmp_dir}/group#{group.id} && zip -r #{@tmp_dir}/group#{group.id}.zip . && cd $tt")
      end
    else
    end
    
  end
end
