class PasswordResetMailer < ApplicationMailer
  # Sends a password reset email containing a link with the raw token.
  def reset_email
    @user  = params[:user]
    token  = params[:token]
    @reset_url = edit_password_reset_url(token)

    mail to: @user.email, subject: "Reset Password Link for your GiftWise Account"
  end
end
