class SessionsController < ApplicationController
  # allow signup pages without authentication
  skip_before_action :require_login, only: %i[new create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome, #{user.email}"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to login_path
  end
end
