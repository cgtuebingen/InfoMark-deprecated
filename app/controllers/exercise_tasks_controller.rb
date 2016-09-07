class ExerciseTasksController < ApplicationController
  before_action :set_exercise_task, only: [:show, :edit, :update, :destroy]
  before_action :set_exercise_sheet, only: [:create]
  before_action :auth, only: [:edit, :update, :destroy]

  # GET /exercise_tasks
  # GET /exercise_tasks.json
  def index
    @exercise_tasks = ExerciseTask.all
  end

  # GET /exercise_tasks/1
  # GET /exercise_tasks/1.json
  def show
  end

  # GET /exercise_tasks/new
  def new
    @exercise_sheet = ExerciseSheet.find(params[:exercise_sheet_id])
    @exercise_task = ExerciseTask.new
  end

  # GET /exercise_tasks/1/edit
  def edit
  end

  # POST /exercise_tasks
  # POST /exercise_tasks.json
  def create
    @exercise_task = ExerciseTask.new(exercise_task_params)
    @exercise_task.exercise_sheet_id = params[:exercise_sheet_id]

    respond_to do |format|
      if @exercise_task.save
        format.html { redirect_to exercise_sheet_path(params[:exercise_sheet_id]), notice: 'Exercise task was successfully created.' }
        format.json { render :show, status: :created, location: @exercise_task }
      else
        format.html { render :new }
        format.json { render json: @exercise_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exercise_tasks/1
  # PATCH/PUT /exercise_tasks/1.json
  def update
    respond_to do |format|
      if @exercise_task.update(exercise_task_params)
        format.html { redirect_to exercise_sheet_path(@exercise_task.exercise_sheet), notice: 'Exercise task was successfully updated.' }
        format.json { render :show, status: :ok, location: @exercise_task }
      else
        format.html { render :edit }
        format.json { render json: @exercise_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercise_tasks/1
  # DELETE /exercise_tasks/1.json
  def destroy

    sheet_id = @exercise_task.exercise_sheet_id
    @exercise_task.destroy
    respond_to do |format|
      format.html { redirect_to exercise_sheet_path(sheet_id), notice: 'Exercise task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_task
      @exercise_task = ExerciseTask.find(params[:id])
    end
    def set_exercise_sheet
      @exercise_sheet = ExerciseSheet.find(params[:exercise_sheet_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exercise_task_params
      params.require(:exercise_task).permit(:order, :max_points, :public_test, :private_test)
      #params[:exercise_task]
    end

    def auth
      redirect_to denied_path unless can? current_user, :manage, @exercise_task.exercise_sheet
    end
end
