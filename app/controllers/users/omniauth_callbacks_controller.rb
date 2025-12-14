class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    handle_auth("Google")
  end

  def github
    handle_auth("GitHub")
  end

  def failure
    redirect_to new_user_session_path, alert: "Sign-in failed. Please try again."
  end

  private

  def handle_auth(kind)
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)

    if user.nil?
      redirect_to new_user_session_path,
                  alert: "No account exists for #{auth.info.email}. Please sign up first."
      return
    end

    flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: kind)
    sign_in_and_redirect user, event: :authentication
  end
end
