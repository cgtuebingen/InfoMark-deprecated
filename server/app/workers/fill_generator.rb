class FillGenerator

  @queue = :system_queue
  def self.perform(sheet_id)

    log = Logger.new 'log/fill.log'

    @sheet  = ExerciseSheet.find(sheet_id)
    @course = @sheet.course
    @groups = @course.course_groups
    @tasks  = @sheet.exercise_tasks
    txt = "keine Abgabe (bewertet mit 0 Punkten)" # etwas Text

    # get all groups
    if !@groups.blank?
      for group in @groups
        if !group.users.blank?
          for user in group.users
            for task in @tasks
              # get latest submission from current user for current task
              latest_submission = Submission.where(user_id: user.id, exercise_task_id: task.id).order(id: :desc).first
              if !latest_submission.nil?
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
      end
    else
    end
    
  end
end
