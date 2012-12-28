class ApplicationController < ActionController::Base
  protect_from_forgery
    
  helper_method :current_user


  def authenticate_user!
    unless session[:user_id]
      redirect_to root_path
    end
  end
  
  def go_to_home_if_logged_in!
    if session[:user_id]
      redirect_to current_user
    end
  end


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
