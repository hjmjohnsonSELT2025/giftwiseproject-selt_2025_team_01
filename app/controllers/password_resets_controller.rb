class PasswordResetsController < ApplicationController
  # Allow these actions without being logged in
  skip_before_action :require_login, only: %i[new create edit update]

  # Show "Forgot your password?" form
  def new
  end

  # Handle email submit – send reset email if user exists
  def create
    if (user = User.find_by(email: params[:email]))
      token = user.generate_reset_password_token!
      PasswordResetMailer.with(user: user, token: token).reset_email.deliver_now
    end

    # Always respond the same, so we don't leak which emails exist
    redirect_to login_path, notice: "If that email exists, you'll receive a reset link shortly."
  end

  # Show "Reset your password" form when user clicks email link
  def edit
    @user = User.find_by(reset_password_token: params[:id])

    if @user.nil? || @user.reset_password_token_expired?
      redirect_to new_password_reset_path,
                  alert: "This reset link is invalid or has expired. Please request a new one."
    end
  end

  # Process the submitted new password
  def update
    @user = User.find_by(reset_password_token: params[:id])

    unless @user
      redirect_to new_password_reset_path, alert: "Invalid reset link."
      return
    end

    if @user.reset_password_token_expired?
      redirect_to new_password_reset_path, alert: "This reset link has expired. Please request a new one."
      return
    end

    new_password = params.dig(:user, :password)

    if new_password.blank?
      flash.now[:alert] = "Password can't be blank."
      render :edit, status: :unprocessable_entity
      return
    end

    if @user.reset_password!(new_password)
      # Auto log in the user after password reset
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Your password has been updated and you are now logged in."
    else
      flash.now[:alert] = "Could not update password. Please try again."
      render :edit, status: :unprocessable_entity
    end
  end
end
