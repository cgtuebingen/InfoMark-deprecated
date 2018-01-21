class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :become]
  before_action :test_admin


  def index
    @users = User.all
  end

  def edit
  end

  def update


    update = false
    if user_params[:email] != @user.email
      update = true
    end

    if @user.update(user_params)
      if update
        @user.send_confirmation_instructions
      end
      redirect_to users_path
    else
      raise "error"
    end
  end

  def become
    return unless current_user.root?
    sign_in(:user, @user)
    redirect_to root_url # or user_root_url
  end

  private

  def set_user
    @user = User.find(params[:id])
  end



  def test_admin
    redirect_to denied_path unless current_user.root?
  end

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email)
  end
end
