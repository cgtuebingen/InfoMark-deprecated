class GlobalnotificationsController < ApplicationController
  before_action :set_globalnotification, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :auth, only: [:edit, :update, :destroy]

  # GET /globalnotifications
  # GET /globalnotifications.json
  def index
    @globalnotifications = Globalnotification.all
  end

  # GET /globalnotifications/1
  # GET /globalnotifications/1.json
  def show
  end

  # GET /globalnotifications/new
  def new
    @globalnotification = Globalnotification.new
  end

  # GET /globalnotifications/1/edit
  def edit
  end

  # POST /globalnotifications
  # POST /globalnotifications.json
  def create
    @globalnotification = Globalnotification.new(globalnotification_params)

    respond_to do |format|
      if @globalnotification.save
        format.html { redirect_to @globalnotification, notice: 'Globalnotification was successfully created.' }
        format.json { render :show, status: :created, location: @globalnotification }
      else
        format.html { render :new }
        format.json { render json: @globalnotification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /globalnotifications/1
  # PATCH/PUT /globalnotifications/1.json
  def update
    respond_to do |format|
      if @globalnotification.update(globalnotification_params)
        format.html { redirect_to @globalnotification, notice: 'Globalnotification was successfully updated.' }
        format.json { render :show, status: :ok, location: @globalnotification }
      else
        format.html { render :edit }
        format.json { render json: @globalnotification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /globalnotifications/1
  # DELETE /globalnotifications/1.json
  def destroy
    @globalnotification.destroy
    respond_to do |format|
      format.html { redirect_to globalnotifications_url, notice: 'Globalnotification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_globalnotification
    @globalnotification = Globalnotification.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def globalnotification_params
    params.require(:globalnotification).permit(:body, :start, :ends, :visibility)
  end

  def auth
    redirect_to denied_path unless can? current_user, :manage, @globalnotification
  end
  
end
