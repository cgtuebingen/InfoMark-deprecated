class SupplementariesController < ApplicationController
  before_action :set_supplementary, only: [:show, :edit, :update, :destroy, :download]
  before_action :authenticate_user!
  before_action :auth, only: [:edit, :update, :destroy]

  # GET /supplementaries/download
  def download
    #https://info2.informatik.uni-tuebingen.de/supplementaries/1/download
    if can? current_user, :see, @supplementary
      send_file(@supplementary.file.path ,
                :type => 'application/zip',
                :disposition => 'attachment')
    else
      redirect_to denied_path
    end
  end

  # GET /supplementaries
  # GET /supplementaries.json
  def index
    redirect_to denied_path unless can? current_user, :blublub, nil
    @supplementaries = Supplementary.all
  end

  # GET /supplementaries/1
  # GET /supplementaries/1.json
  def show
  end

  # GET /supplementaries/new
  def new
    @supplementary = Supplementary.new
  end

  # GET /supplementaries/1/edit
  def edit
  end

  # POST /supplementaries
  # POST /supplementaries.json
  def create
    @supplementary = Supplementary.new(supplementary_params)

    respond_to do |format|
      if @supplementary.save
        format.html { redirect_to @supplementary, notice: 'Supplementary was successfully created.' }
        format.json { render :show, status: :created, location: @supplementary }
      else
        format.html { render :new }
        format.json { render json: @supplementary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supplementaries/1
  # PATCH/PUT /supplementaries/1.json
  def update
    respond_to do |format|
      if @supplementary.update(supplementary_params)
        format.html { redirect_to @supplementary, notice: 'Supplementary was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplementary }
      else
        format.html { render :edit }
        format.json { render json: @supplementary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplementaries/1
  # DELETE /supplementaries/1.json
  def destroy
    @supplementary.destroy
    respond_to do |format|
      format.html { redirect_to supplementaries_url, notice: 'Supplementary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_supplementary
    @supplementary = Supplementary.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def supplementary_params
    params.require(:supplementary).permit(:file, :course_id, :info, :visibility)
  end

  def auth
    redirect_to denied_path unless can? current_user, :manage, @supplementary
  end
end
