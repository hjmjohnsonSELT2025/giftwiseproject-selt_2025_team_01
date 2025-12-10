class PasswordResetsController < ApplicationController
  skip_before_action :require_login, only: %i[new create edit update]

  def new
  end

  def create
    if (user = User.find_by(email: params[:email]))
      token = user.generate_reset_password_token!
      PasswordResetMailer.with(user: user, token: token).reset_email.deliver_now
    end

    redirect_to login_path, notice: "If that email exists, you'll receive a reset link shortly."
  end

  def edit
    @user = User.find_by(reset_password_token: params[:id])

    if @user.nil?
      # Don’t silently redirect – show a clear error
      redirect_to new_password_reset_path,
                  alert: "This reset link is invalid. Please request a new one."
      return
    end

    # If you want to enforce expiry, keep this block.
    if @user.reset_password_token_expired?
      redirect_to new_password_reset_path,
                  alert: "This reset link has expired. Please request a new one."
      return
    end

    # If we reach here, @user exists and token is valid.
    # Rails will render app/views/password_resets/edit.html.erb
  end

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
      # auto log in
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Your password has been updated and you are now logged in."
    else
      flash.now[:alert] = "Could not update password. Please try again."
      render :edit, status: :unprocessable_entity
    end
  end
end
