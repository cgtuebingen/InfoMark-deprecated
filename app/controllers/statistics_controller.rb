class StatisticsController < ApplicationController

	before_action :authenticate_user!
	before_action :auth
  def index
  end

  def auth
      redirect_to denied_path unless can? current_user, :only_root, nil
    end
end
