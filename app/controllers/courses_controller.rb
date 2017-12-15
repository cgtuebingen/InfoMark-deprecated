class CoursesController < ApplicationController


  before_action :set_course, only: [:show, :edit, :update, :destroy, :stats]
  before_action :auth, only: [ :edit, :update, :destroy, :stats]
  before_action :authenticate_user!


  #before_action :logged_in_admin,    only: [:edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @course = Course.new
    @courses = Course.all
  end

  def subscribe
    @c = Course.find_by(id: params[:id])
    @u = current_user
    unless @c.nil?
      @c.enrollments.create(:user_id => @u.id)
    end

    # and now change all preferences for groups to 3
    # get all enrollments
    # GroupEnrollmentPreference.where(user_id: 1, course_group_id: CourseGroup.where(course_id: 1).map(&:id))
    redirect_to(:back)
  end

  def stats
    
  end

  def unsubscribe
    @c = Course.find_by(id: params[:id])
    unless @c.nil?
      @enrollment = current_user.enrollments.find_by(course_id: @c.id)
      unless @enrollment.nil?
        flash[:success] = 'Du hast dich erfolgreich ausgetragen.'
        @enrollment.destroy
      end
    end
    redirect_to courses_path
  end


  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
    redirect_to denied_path unless can? current_user, :manage, @course
    #head(404) and return unless can?(current_user, :create_course, nil)
  end

  # GET /courses/1/edit
  def edit
  end


  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:title, :subtitle, :description, :begin, :termination, :min_points, :show_exam_approval)
  end

  def auth
      redirect_to denied_path unless can? current_user, :manage, @course
    end

  protected



end
