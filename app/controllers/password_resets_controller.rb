class PasswordResetsController < ApplicationController
  # Password reset should work even if user is logged out and has no profile
  skip_before_action :require_login
  skip_before_action :ensure_profile_exists

  # GET /password_resets/new
  def new
  end

  # POST /password_resets
  def create
    if (user = User.find_by(email: params[:email]))
      token = user.generate_reset_password_token!
      PasswordResetMailer.with(user: user, token: token).reset_email.deliver_now
    end

    redirect_to login_path, notice: "If that email exists, you'll receive a reset link shortly."
  end

  # GET /password_resets/:id/edit
  def edit
    @token = params[:id]
    @user  = User.find_by(reset_password_token: @token)

    Rails.logger.info "DEBUG RESET EDIT: token=#{@token.inspect} user_id=#{@user&.id}"

    if @user.nil?
      flash[:alert] = "This reset link is invalid. Please request a new one."
      redirect_to new_password_reset_path
      return
    end

    # Renders app/views/password_resets/edit.html.erb
  end

  # PATCH /password_resets/:id
  def update
    @token = params[:id]
    @user  = User.find_by(reset_password_token: @token)

    if @user.nil?
      redirect_to new_password_reset_path, alert: "Invalid reset link."
      return
    end

    new_password = params.dig(:user, :password)

    if new_password.blank?
      flash.now[:alert] = "Password can't be blank."
      render :edit, status: :unprocessable_entity
      return
    end

    if @user.reset_password!(new_password)
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Your password has been updated and you are now logged in."
    else
      flash.now[:alert] = "Could not update password. Please try again."
      render :edit, status: :unprocessable_entity
    end
  end
end
