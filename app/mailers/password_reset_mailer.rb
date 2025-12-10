class PasswordResetMailer < ApplicationMailer
  def reset_email
    @user  = params[:user]
    token  = params[:token]
    @reset_url = edit_password_reset_url(token)

    mail(
      to: @user.email.to_s.strip,
      subject: "Reset your GiftWise password"
    )
  end
end
