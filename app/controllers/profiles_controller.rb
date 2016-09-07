class ProfilesController < ApplicationController
  include ProfilesHelper
	before_action :authenticate_user!

  def index


    redirect_to profile_path(current_user.id)
  end

	def show

    

    unless has_filled_out_data(current_user)
      flash.now[:warning] = 'Du kannst nur an Kursen teilnehmen und Submissions durchführen, wenn deine Angaben im Profil vollständig sind.'
    end

    cid = params[:id] || current_user.id

    unless params[:id].blank?
      redirect_to denied_path unless can? current_user, :see, User.find(params[:id])
    end
    
		@user = User.find(cid)
		@my_courses = @user.courses
    @next_submission = Submission.new
    @my_submissions = Submission.where(user_id: @user.id).order(created_at:  :desc).limit(10)
	end



end
