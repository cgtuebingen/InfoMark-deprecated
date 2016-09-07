class LinecommentsController < ApplicationController
  # DISCLAIMER: I KNOW THIS IS UGLY AND HACKY! BUT IT WORKS!
  before_action :authenticate_user!
  before_action :set_linecomment, only: [ :edit, :update, :destroy]
  #protect_from_forgery except: :new
  before_action :auth, only: [:destroy]

  # GET /linecomments
  # GET /linecomments.json
  def index
    @linecomments = Linecomment.all
  end

  # GET /linecomments/1
  # GET /linecomments/1.json
  def show
    puts params[:id]
    sid = Submission.find(params[:id]).id
    sid ||= 0
    @linecomment = Linecomment.where(file_name: params[:fn], line: params[:line], submission_id:sid).first
    @linecomment ||= Linecomment.new
    respond_to do |format|
      format.json
      format.html
    end
  end

  # GET /linecomments/new
  def new
    sid = Submission.find(params[:sid]).id
    sid ||= 0
    @linecomment = Linecomment.where(file_name: params[:fn], line: params[:line], submission_id:sid).first
    @linecomment ||= Linecomment.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /linecomments/1/edit
  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  # POST /linecomments
  # POST /linecomments.json
  def create
    # find correct submission_id (thx obfuscated_id)
    puts "------------------------"
    sid = Submission.deobfuscate_id(params[:linecomment][:submission_id])
    lp = {"submission_id"=>sid, "file_name"=>linecomment_params[:file_name], "line"=>linecomment_params[:line], "comment"=>linecomment_params[:comment], "user_id"=>current_user.id}
    puts lp
    puts "------------------------"

    Linecomment.where(submission_id: sid, file_name: linecomment_params[:file_name], line: linecomment_params[:line],user_id:current_user.id).delete_all

    unless linecomment_params[:comment].empty?
      # sid = Submission.find(params[:submission_id]).first.id
      @linecomment = Linecomment.new(lp)

      respond_to do |format|
        if @linecomment.save
          format.html { redirect_to @linecomment, notice: 'Linecomment was successfully created.' }
          format.json { render :show, status: :created, location: @linecomment }
          format.js { render :json => {} }
        else
          format.html { render :new }
          format.json { render json: @linecomment.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.js { render :json => {} }
      end
    end
  end

  # PATCH/PUT /linecomments/1
  # PATCH/PUT /linecomments/1.json
  def update

    puts "------------------------"
    sid = Submission.deobfuscate_id(params[:linecomment][:submission_id])
    lp = {"submission_id"=>sid, "file_name"=>linecomment_params[:file_name], "line"=>linecomment_params[:line], "comment"=>linecomment_params[:comment], "user_id"=>current_user.id}
    puts lp
    puts "------------------------"

    Linecomment.where(submission_id: sid, file_name: linecomment_params[:file_name], line: linecomment_params[:line],user_id:current_user.id).delete_all
    
    unless linecomment_params[:comment].empty?
      # sid = Submission.find(params[:submission_id]).first.id
      @linecomment = Linecomment.new(lp)

      respond_to do |format|
        if @linecomment.save
          format.html { redirect_to @linecomment, notice: 'Linecomment was successfully created.' }
          format.json { render :show, status: :created, location: @linecomment }
          format.js { render :json => {} }
        else
          format.html { render :new }
          format.json { render json: @linecomment.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.js { render :json => {} }
      end
    end
  end

  # DELETE /linecomments/1
  # DELETE /linecomments/1.json
  def destroy
    @linecomment.destroy
    respond_to do |format|
      format.html { redirect_to linecomments_url, notice: 'Linecomment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_linecomment
    @linecomment = Linecomment.find(params[:id])

  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def linecomment_params
    params.require(:linecomment).permit(:submission_id,:file_name, :line, :comment, :user_id)
  end

  def auth
      redirect_to denied_path unless can? current_user, :manage, @linecomment
    end
end
