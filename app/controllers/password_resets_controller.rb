class PasswordResetsController < ApplicationController
  # Let anyone access password reset flow
  skip_before_action :require_login, only: %i[new create edit update]

  # GET /password_resets/new
  # "Forgot your password?" page
  def new
  end

  # POST /password_resets
  # Handle email form, send reset link if user exists
  def create
    if (user = User.find_by(email: params[:email]))
      token = user.generate_reset_password_token!
      PasswordResetMailer.with(user: user, token: token).reset_email.deliver_now
    end

    redirect_to login_path, notice: "If that email exists, you'll receive a reset link shortly."
  end

  # GET /password_resets/:id/edit
  # Show "enter new password" form
  def edit
    @user = User.find_by(reset_password_token: params[:id])

    if @user.nil?
      flash[:alert] = "This reset link is invalid. Please request a new one."
      redirect_to new_password_reset_path
      return
    end

    # Temporarily ignore expiry for debugging:
    # if @user.reset_password_token_expired?
    #   flash[:alert] = "This reset link has expired. Please request a new one."
    #   redirect_to new_password_reset_path
    #   return
    # end

    # If we get here, @user is set and we will render app/views/password_resets/edit.html.erb
  end

  # PATCH /password_resets/:id
  def update
    @user = User.find_by(reset_password_token: params[:id])

    unless @user
      redirect_to new_password_reset_path, alert: "Invalid reset link."
      return
    end

    # Temporarily ignore expiry while debugging:
    # if @user.reset_password_token_expired?
    #   redirect_to new_password_reset_path, alert: "This reset link has expired. Please request a new one."
    #   return
    # end

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
