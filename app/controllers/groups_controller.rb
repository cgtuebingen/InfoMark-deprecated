class GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :init_course, only: [:show, :edit, :update, :destroy ]
  before_action :verify_permission, only: [:edit, :update, :destroy, :new]
  before_action :verify_permission2, only: [:show]

  def index
    redirect_to denied_path unless can? current_user, :open_tutor, CourseGroup.new
    @possible_course = Enrollment.where(user_id: current_user.id, role: [1,2,3,4] )
    @possible_groups = CourseGroup.where(course_id: @possible_course.map(&:course_id))
  end

  def new
    redirect_to denied_path unless can? current_user, :manage, CourseGroup.new
    @current_course = Course.find(params[:course_id])
    @current_group = CourseGroup.new
    @current_group.course = @current_course
  end

  def create
    @group = CourseGroup.new(groupparams)
    @group.course_id = params[:course_id]
    if @group.save
      redirect_to courses_path, notice: 'Group task was successfully created.' 
    else
    end
  end

  def show
    @assigned_students = @current_group.users
    s = @current_course.exercise_sheets.order(:order)
    @bl_id_to_pos   = Hash[*(s.map {|obj| [obj.id, obj.order]}).flatten]
  end

  def edit
  end

  def update
    @current_group.update(groupparams)
    redirect_to courses_path, notice: 'Group task was successfully updated.' 
  end

  def destroy

    
    @current_group.destroy
    redirect_to courses_path, notice: 'Group task was successfully destroyed.' 

  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def init_course
    @current_group = CourseGroup.find(params[:id])
    @current_course = @current_group.course
  end

  def verify_permission
    redirect_to denied_path unless can? current_user, :manage, @current_group
  end

  def verify_permission2
    redirect_to denied_path unless can? current_user, :open_tutor, @current_group
  end

  def groupparams
    params.require(:course_group).permit(:info, :user_id)
  end
end
