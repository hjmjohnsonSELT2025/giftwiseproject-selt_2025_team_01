class PasswordResetMailer < ApplicationMailer
  def reset_email
    @user  = params[:user]
    @token = params[:token]

    # Optional debugging so you can see it in Heroku logs
    Rails.logger.info "MAILER reset_email: user_id=#{@user.id} token=#{@token.inspect}"

    mail(
      to: @user.email.to_s.strip,
      subject: "Reset your GiftWise password"
    )
  end
end
