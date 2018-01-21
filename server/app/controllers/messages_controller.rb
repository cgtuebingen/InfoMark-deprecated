class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :auth

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @course = Course.find(params[:course_id])
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @course = Course.find(params[:course_id])
    @message = Message.new(message_params)

    if params[:message][:course_info] == "-1"
      @message.recipients =  @course.users.map(&:id).join(",") 
    else
      @message.recipients =  CourseGroup.find(params[:message][:course_info]).users.map(&:id).join(",") + ",#{CourseGroup.find(params[:message][:course_info]).owner.id}"
    end

    if @message.save
      Resque.enqueue(MessageWorker, @message.id)
      redirect_to groups_path, notice: 'Absenden der Nachricht wird durch Background-Job durchgeführt.'
    else
      render :new
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:recipients, :subject, :body, :course_id)
  end

  def auth
    redirect_to denied_path if highest_role(current_user)  == 0
  end

  def highest_role(user)
      Enrollment.roles[Enrollment.where(user: user).order(role: :desc).first.role]
    end
end
