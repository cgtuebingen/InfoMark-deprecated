class StaticPagesController < ApplicationController
	before_action :authenticate_user!
  
  def home
  end

  def denied
  end

  def changelog
  end

  def termsofuse
    
  end
end
