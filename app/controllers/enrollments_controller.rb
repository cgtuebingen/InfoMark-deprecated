class EnrollmentsController < ApplicationController
	before_action :authenticate_user!
  before_action :set_user, only: [:index]
  before_action :set_enrollment, only: [:edit, :update]
  before_action :auth

  def index

  end

  def edit
  end

  def update
    @enrollment.update(enrollment_params)
    redirect_to user_enrollments_path(@enrollment.user_id)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
    @enrollments = Enrollment.where(user: @user).includes(:course)
  end

   def set_enrollment
    @enrollment = Enrollment.find(params[:id])
  end

  def enrollment_params
    params.require(:enrollment).permit(:role)
  end

  def auth
    redirect_to denied_path unless can? current_user, :manage, nil
  end
	
end

