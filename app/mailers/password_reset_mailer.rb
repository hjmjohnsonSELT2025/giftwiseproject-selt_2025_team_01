class PasswordResetMailer < ApplicationMailer
  def reset_email
    # Instance variable so the view can use @user
    @user  = params[:user]
    token  = params[:token]

    # Used in the view for the reset link
    @reset_url = edit_password_reset_url(token)

    # Headers: single-line, sanitized
    mail(
      to: @user.email.to_s.strip,
      subject: "Reset your GiftWise password"
    )
  end
end
