class GroupEnrollmentPreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_data, only: [:index, :download]
  before_action :verify_permission, only: [:download]

  # GET /preferences
  def index

  end

  def download
    # @students = Enrollment.where(role: 0, course_id:1).order(:user_id).map(&:user_id)
    @students = Enrollment.where(course_id:@course).order(:user_id).map(&:user_id)
    @groups  = CourseGroup.where(course_id:@course).order(:id).map(&:id)
    @ratings = GroupEnrollmentPreference.where(course_group: @groups)

  end

  def update
    # get rating
    @rating = GroupEnrollmentPreference.find(params[:id])
    # if own rating
    if @rating.user_id == current_user.id
      @rating.update(rating_params)

      if @rating.save
        @course = CourseGroup.find(@rating.course_group_id)
        redirect_to course_group_enrollment_preferences_path(@course.course), notice: 'Group task was successfully created.'
      else
      end
    else
      redirect_to denied_path
    end
  end


  private

  def set_data
    @user = current_user
    @course = Course.find(params[:course_id])
    @groups = @course.course_groups.map(&:id)
  end

  def rating_params
    params.require(:group_enrollment_preference).permit(:rating, :id)
  end

  def verify_permission
    redirect_to denied_path unless can? current_user, :manage, @course
  end


end
