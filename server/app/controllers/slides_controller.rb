class SlidesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_slide, only: [:show, :edit, :update, :destroy, :download]
  before_action :auth, only: [:edit, :update, :destroy]

   # GET /exercise_sheets/1/download
  def download
    # puts "#{Rails.root}/uploads/exercise_sheet/#{@current_exercise_sheet.id}"
    # send_file "#{Rails.root}/uploads/exercise_sheet/#{@current_exercise_sheet.id}"
    if can? current_user, :see, @slide
      send_file(@slide.file.path ,
      :type => 'application/pdf',
      :disposition => 'attachment')    
    else
      redirect_to denied_path
    end
  end

  # GET /slides
  # GET /slides.json
  def index
    redirect_to denied_path unless can? current_user, :blublub, nil
    @slides = Slide.all
  end

  # GET /slides/1
  # GET /slides/1.json
  def show
  end

  # GET /slides/new
  def new
    @slide = Slide.new
  end

  # GET /slides/1/edit
  def edit
  end

  # POST /slides
  # POST /slides.json
  def create
    @slide = Slide.new(slide_params)

    respond_to do |format|
      if @slide.save
        format.html { redirect_to @slide, notice: 'Slide was successfully created.' }
        format.json { render :show, status: :created, location: @slide }
      else
        format.html { render :new }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slides/1
  # PATCH/PUT /slides/1.json
  def update
    respond_to do |format|
      if @slide.update(slide_params)
        format.html { redirect_to @slide, notice: 'Slide was successfully updated.' }
        format.json { render :show, status: :ok, location: @slide }
      else
        format.html { render :edit }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    @slide.destroy
    respond_to do |format|
      format.html { redirect_to slides_url, notice: 'Slide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slide
      @slide = Slide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slide_params
      params.require(:slide).permit(:file, :course_id, :publish, :public, :lecture, :info, :title)
    end

    def auth
      redirect_to denied_path unless can? current_user, :manage, @slide
    end
end
