class SessionsController < ApplicationController
  # Allow these actions without being logged in
  skip_before_action :require_login, only: %i[new create duo duo_verify]
  # Duo iframe POST doesn’t include the CSRF token, so skip it just for that action
  skip_before_action :verify_authenticity_token, only: :duo_verify

  # [VIEW] Renders the login form
  def new
  end

  # [MODEL & CONTROLLER] Handles the logic for logging a user in.
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      if duo_enabled? && duo_configured?
        # Store the user id temporarily until Duo succeeds
        session[:pre_2fa_user_id] = user.id
        redirect_to duo_login_path
      else
        # Normal login (no Duo)
        session[:user_id] = user.id
        redirect_to root_path, notice: "Welcome, #{user.email}"
      end
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end


  # Duo: show the iframe
  def duo
    user = User.find_by(id: session[:pre_2fa_user_id])

    unless user && duo_enabled? && duo_configured?
      session.delete(:pre_2fa_user_id)
      redirect_to login_path, alert: "Your login session expired. Please log in again."
      return
    end

    # Use email as the Duo username/identifier
    @sig_request = Duo.sign_request(
      DUO["DUO_IKEY"],
      DUO["DUO_SKEY"],
      DUO["DUO_AKEY"],
      user.email
    )
  end

  # Duo: handle the POST back from Duo iframe
  def duo_verify
    user = User.find_by(id: session[:pre_2fa_user_id])

    unless user && duo_enabled? && duo_configured?
      session.delete(:pre_2fa_user_id)
      redirect_to login_path, alert: "Your login session expired. Please log in again."
      return
    end

    authenticated_user = Duo.verify_response(
      DUO["DUO_IKEY"],
      DUO["DUO_SKEY"],
      DUO["DUO_AKEY"],
      params["sig_response"]
    )

    if authenticated_user
      session.delete(:pre_2fa_user_id)
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome, #{user.email}"
    else
      session.delete(:pre_2fa_user_id)
      redirect_to login_path, alert: "Duo verification failed"
    end
  end

  # [CONTROLLER] Handles the logout logic.
  def destroy
    session[:user_id] = nil
    session[:pre_2fa_user_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to login_path
  end

  private

  # Very simple feature flag:
  # set DUO_ENABLED=true in your env (locally or on Heroku)
  def duo_enabled?
    ENV["DUO_ENABLED"] == "true"
  end

  # Check that the DUO constant is present and has keys
  def duo_configured?
    defined?(DUO) && DUO.is_a?(Hash) &&
      DUO["DUO_IKEY"].present? &&
      DUO["DUO_SKEY"].present? &&
      DUO["DUO_HOST"].present? &&
      DUO["DUO_AKEY"].present?
  end
end
