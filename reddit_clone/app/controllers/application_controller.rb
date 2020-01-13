class ApplicationController < ActionController::Base

  helper_method :current_user, :ensure_logged_in, :log_in!, :log_out!, :logged_in?

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def ensure_logged_in
    unless current_user
      flash[:error] = ['Must be signed in to do that']
      redirect_to new_session_url 
    end
  end

  def logged_in?
    !!current_user
  end

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
