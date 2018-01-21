class ExamGradesController < ApplicationController
  before_action :set_exam_grade, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # # GET /exam_grades
  # # GET /exam_grades.json
  # def index
  #   @exam_grades = ExamGrade.all
  # end

  # # GET /exam_grades/1
  # # GET /exam_grades/1.json
  # def show
  # end

  # # GET /exam_grades/new
  # def new
  #   @exam_grade = ExamGrade.new
  # end

  # # GET /exam_grades/1/edit
  # def edit
  # end

  # # POST /exam_grades
  # # POST /exam_grades.json
  # def create
  #   @exam_grade = ExamGrade.new(exam_grade_params)

  #   respond_to do |format|
  #     if @exam_grade.save
  #       format.html { redirect_to @exam_grade, notice: 'Exam grade was successfully created.' }
  #       format.json { render :show, status: :created, location: @exam_grade }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @exam_grade.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /exam_grades/1
  # # PATCH/PUT /exam_grades/1.json
  # def update
  #   respond_to do |format|
  #     if @exam_grade.update(exam_grade_params)
  #       format.html { redirect_to @exam_grade, notice: 'Exam grade was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @exam_grade }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @exam_grade.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /exam_grades/1
  # # DELETE /exam_grades/1.json
  # def destroy
  #   @exam_grade.destroy
  #   respond_to do |format|
  #     format.html { redirect_to exam_grades_url, notice: 'Exam grade was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_exam_grade
  #     @exam_grade = ExamGrade.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def exam_grade_params
  #     params.require(:exam_grade).permit(:points, :mark, :info, :user_id, :exam_id)
  #   end
end
