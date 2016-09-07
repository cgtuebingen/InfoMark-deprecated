class ExerciseSheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise_sheet, only: [:show, :edit, :update, :destroy, :download]
  before_action :auth, only: [:edit, :update, :destroy]
  before_action :get_gradings, only: [:show]

  # GET /exercise_sheets/1/download
  def download
    # puts "#{Rails.root}/uploads/exercise_sheet/#{@current_exercise_sheet.id}"
    # send_file "#{Rails.root}/uploads/exercise_sheet/#{@current_exercise_sheet.id}"
    if can? current_user, :see, @current_exercise_sheet
      send_file(@current_exercise_sheet.file.path ,
      :type => 'application/zip',
      :disposition => 'attachment')    
    else
      redirect_to denied_path
    end
  end

  # GET /exercise_sheets
  # GET /exercise_sheets.json
  def index
    @current_exercise_sheets = ExerciseSheet.all
  end

  # GET /exercise_sheets/1
  # GET /exercise_sheets/1.json
  def show
    @next_submission = Submission.new
    redirect_to denied_path unless can? current_user, :see, @current_exercise_sheet
  end

  # GET /exercise_sheets/new
  def new
    @current_exercise_sheet = ExerciseSheet.new
    @current_exercise_sheet.user = current_user
    @current_exercise_sheet.course_id = params[:course_id]
  end

  # GET /exercise_sheets/1/edit
  def edit
    
  end

  # POST /exercise_sheets
  # POST /exercise_sheets.json
  def create
    @current_exercise_sheet = ExerciseSheet.new(exercise_sheet_params)

    respond_to do |format|
      if @current_exercise_sheet.save
        format.html { redirect_to @current_exercise_sheet, notice: 'Exercise sheet was successfully created.' }
        format.json { render :show, status: :created, location: @current_exercise_sheet }
      else
        format.html { render :new }
        format.json { render json: @current_exercise_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exercise_sheets/1
  # PATCH/PUT /exercise_sheets/1.json
  def update
    respond_to do |format|
      if @current_exercise_sheet.update(exercise_sheet_params)
        format.html { redirect_to @current_exercise_sheet, notice: 'Exercise sheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @current_exercise_sheet }
      else
        format.html { render :edit }
        format.json { render json: @current_exercise_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercise_sheets/1
  # DELETE /exercise_sheets/1.json
  def destroy
    @current_exercise_sheet.destroy
    respond_to do |format|
      format.html { redirect_to exercise_sheets_url, notice: 'Exercise sheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_sheet
      @current_exercise_sheet = ExerciseSheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exercise_sheet_params
      params.require(:exercise_sheet).permit(:course_id, :user_id, :order, :file, :publish, :duedate, :description)
    end

    def get_gradings
      @gradings = Grading.where(exercise_sheet_id: @current_exercise_sheet.id, user: current_user).includes(:submission, submission: :exercise_task)
    end

    def auth
      redirect_to denied_path unless can? current_user, :manage, @current_exercise_sheet
    end
end
