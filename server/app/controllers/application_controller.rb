class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :abilities, :can?

  #from devise
  #@current_user ||= warden.authenticate(scope: :user)


  before_filter :set_start_time

  def set_start_time
    @start_time = Time.now
  end


  protected
  
  def abilities
    Ability.abilities
  end

  # simple delegate method for controller & view
  def can?(object, action, subject)
    if current_user.root
      true
    else
      abilities.allowed?(object, action, subject)
    end
  end

end
