class GradingsController < ApplicationController

  before_action :authenticate_user!
  before_action :init_course, :except => [:update]
  before_action :auth, only:[:show, :index]

  # http://localhost:3000/groups/1/gradings
  def index
    @url_filter = ""
    @url_filter = params[:f] if params[:f].present?


  end

  def edit
    render json: {status: "edit call"}
  end

  def show

  end

  def update
    # Punkte-Check
    @current_grading = Grading.find(params[:grading][:id])
    max_points = @current_grading.submission.exercise_task.max_points

    if params[:grading][:points].to_i > max_points
      render json: {status: "failed", msg: "zu viele Punkte vergeben"}
      return
    end

    # Update BEwertung
    feedback = params[:grading][:feedback]
    points = params[:grading][:points]
    id = params[:grading][:id]
    ready = params[:grading][:ready]



    if Grading.update(id, :feedback => feedback, :points => points, :ready => ready, tutor_id: current_user.id)
      g = Grading.find(id)
      Resque.enqueue(PointsAccumulator, g.user_id, g.exercise_sheet_id)
      render json: {status: "ok", id: id, values: g}
    else
      render json: {status: "failed", msg: message}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def init_course
    # get info for current course_group (group of course)
    @current_group = CourseGroup.find(params[:group_id])
    # extract the course
    @current_course = @current_group.course
    # get sheet info
    @current_sheet = ExerciseSheet.find(params[:sheet_id])
    # basically
    # get all gradings that belongs to the current sheet and users of current group plus caching
    @current_grades = Grading.joins(:user).where(exercise_sheet_id: params[:sheet_id], user_id:  CourseGroup.find(@current_group.id).users.pluck(:id) ).order(:ready).includes(:user, submission: :exercise_task).order(:user_id)
    #old ----------=> Grading.where(exercise_sheet_id: params[:id]).includes(:user, submission_info: :exercise_subtask)
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def grading_params
    params.require(:grading).permit(:feedback, :points, :ready)
  end

  def auth
    redirect_to denied_path unless can? current_user, :grade, @current_course
  end


end


# CourseGroup.find(1).users.pluck(:id)

# Grading.joins(:user).where(exercise_sheet_id: 1, user_id:  CourseGroup.find(1).users.pluck(:id) ).includes(:user, submission_info: :exercise_subtask)
