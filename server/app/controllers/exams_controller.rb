class ExamsController < ApplicationController
  before_action :set_exam, only: [:show, :edit, :update, :destroy, :grade, :update_grades]
  before_action :set_course
  before_action :authenticate_user!
  before_action :auth, only: [:edit, :update, :destroy, :grade, :update_grades]

  def auth
    redirect_to denied_path unless can? current_user, :manage, @exam
  end

  # GET /exams
  # GET /exams.json
  def index
    @exams = Exam.all
  end

  def grade
    sheets = @course.exercise_sheets.pluck(:id)
    @allowed_user_ids = PointsCache.where(exercise_sheet_id: sheets).group(:user_id).sum(:points).select { |key, value| value >= @course.min_points}.map{ |k,v| k}
    @allowed_users = User.where(id: @allowed_user_ids).order(:last_name)
  end

  def update_grades

    params[:exams].each do |exam|
      g = ExamGrade.find_or_create_by(user_id: exam[1][:user_id], exam_id: @exam.id)
      g.points = exam[1][:points]
      g.mark = exam[1][:mark]
      g.save!
    end

    redirect_to @course, notice: 'Exam grades vergeben'

  end

  # GET /exams/1
  # GET /exams/1.json
  def show
  end

  # GET /exams/new
  def new
    @exam = Exam.new
    @exam.course = @course
  end

  # GET /exams/1/edit
  def edit
  end

  # POST /exams
  # POST /exams.json
  def create
    @exam = Exam.new(exam_params)

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @course, notice: 'Exam was successfully created.' }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  def update
    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to @course, notice: 'Exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to @course, notice: 'Exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_exam
    @exam = Exam.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def exam_params
    params.require(:exam).permit(:title, :course_id, :date, :info, :bonus)
  end
end
