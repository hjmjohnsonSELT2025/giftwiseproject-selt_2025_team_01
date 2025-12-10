class PasswordResetMailer < ApplicationMailer
  def reset_email
    user  = params[:user]
    token = params[:token]

    # This is only used in the email body, not headers
    @reset_url = edit_password_reset_url(token)

    # Headers: ALL single-line, simple strings
    mail(
      to: user.email.to_s.strip,
      subject: "Reset your GiftWise password"
    )
  end
end
