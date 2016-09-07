
class SubmissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_submission, only: [:show, :download]
  before_action :auth, only: [:download, :show]

  # GET /exercise_sheets/1/download
  def download
    if can? current_user, :download, @current_submission
      send_file(@current_submission.file.path ,
                :type => 'application/zip',
                :disposition => 'attachment')
    else
      redirect_to denied_path
    end
  end

  def index

  end

  def new
    @submission = Submission.new
  end

  def show
    redirect_to denied_path unless can? current_user, :see, @current_submission

    @submission_files = []

    parent_dir  = "/data/unpacked/#{@current_submission.id}"
    #parent_dir  = "/home/wieschol/git/lectures/InfoII_ss16_assignments/Uebungen/Tafel_Ue/Ue_T_04/code/solution/aufgabe2/out"

    if File.directory?(parent_dir)
      allowed_ext = ["java","cpp","hpp","h","c","txt"]
      @submission_files  = []
      allowed_ext.each do |single|
        @submission_files += Dir.glob("#{parent_dir}/**/*.#{single}")
      end
    end

    @linecomments = Linecomment.where(submission_id:@current_submission.id)
  end

  def create
    @submission = Submission.new(upload_params)
    @submission.user_id = current_user.id
    @submission.status = 0


    if @submission.save
      # redirect_to profile_path(current_user.id), notice: "Submission wurde hochgeladen. Jetzt Ergebnis anzeigen"
      redirect_to submission_path(@submission), notice: "Submission wurde hochgeladen."
      # redirect_to profile_path(current_user.id), notice: "Submission wurde hochgeladen. <a href=\"/submissions/#{@submission.obfuscated_id}\">Jetzt Ergebnis anzeigen".html_safe
      Resque.enqueue(SubmissionTester, @submission.obfuscated_id)
    else
      redirect_to profile_path(current_user.id), :flash => { error: "Cannot upload file"}
    end

  end

  def destroy

    # @submission = Submission.find(params[:id])
    # @submission.destroy
    # redirect_to profile_path(current_user.id), notice:  "The submission  has been deleted."
  end

  private
  def upload_params
    params.require(:submission).permit(:exercise_task_id, :file)
  end

  def get_submission
    @current_submission = Submission.find(params[:id])
    @related_submissions = Submission
    .where(user: current_user, exercise_task_id: @current_submission.exercise_task_id)
    .where.not(id: @current_submission.id)
    @sheet = @current_submission.exercise_task.exercise_sheet
  end

  def auth
    redirect_to denied_path unless can? current_user, :see, @current_submission
  end



end
