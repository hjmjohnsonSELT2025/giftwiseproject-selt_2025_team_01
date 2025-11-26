class ApplicationController < ActionController::Base
  helper_method :current_user # makes it available in views too

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  before_action :require_login
  # requires login for all controllers inheriting from ApplicationController
  def require_login
    redirect_to login_path unless session[:user_id]
  end

end
