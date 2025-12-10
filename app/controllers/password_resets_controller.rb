class PasswordResetsController < ApplicationController
  # Users are not logged in when they reset passwords.
  skip_before_action :require_login, only: %i[new create edit update]

  # [VIEW] Show form to request a password reset (enter email).
  def new
  end

  # [CONTROLLER & MODEL] Handle reset request:
  # 1. Find user by email (if it exists).
  # 2. Generate a token and timestamp.
  # 3. Send reset email.
  # We always redirect with the same message to avoid leaking whether email exists.
  def create
    if (user = User.find_by(email: params[:email]))
      token = user.generate_reset_password_token!
      PasswordResetMailer.with(user: user, token: token).reset_email.deliver_now
    end

    redirect_to login_path, notice: "If that email exists, you'll receive a reset link shortly."
  end

  # [VIEW] Show form to set a new password.
  # User is fetched by the reset token in the URL.
  def edit
    @user = find_user_by_token
    return unless @user

    if @user.reset_password_token_expired?
      redirect_to new_password_reset_path, alert: "Reset link has expired. Please request a new one."
    end
  end

  # [CONTROLLER & MODEL] Update the password using the reset token.
  def update
    @user = find_user_by_token
    unless @user
      redirect_to new_password_reset_path, alert: "Invalid reset link."
      return
    end

    if @user.reset_password_token_expired?
      redirect_to new_password_reset_path, alert: "Reset link has expired. Please request a new one."
      return
    end

    new_password = params.dig(:user, :password)

    if new_password.blank?
      flash.now[:alert] = "Password can't be blank."
      render :edit, status: :unprocessable_entity
      return
    end

    if @user.reset_password!(new_password)
      redirect_to login_path, notice: "Password updated. You can now log in."
    else
      flash.now[:alert] = "Could not update password."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Looks up a user by the reset token in params[:id].
  # Returns nil and sets a flash if not found.
  def find_user_by_token
    user = User.find_by(reset_password_token: params[:id])
    unless user
      flash[:alert] = "Invalid or already used reset link."
    end
    user
  end
end
