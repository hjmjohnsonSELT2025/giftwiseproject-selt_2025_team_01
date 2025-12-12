class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create duo duo_verify]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      if ENV["DUO_ENABLED"] == "true"
        session[:passed_duo] = false
        redirect_to duo_login_path
      else
        session[:passed_duo] = true
        redirect_to root_path, notice: "Welcome, #{user.email}"
      end
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    session[:passed_duo] = nil
    flash[:notice] = "You have been logged out"
    redirect_to login_path
  end

  def duo
    # if somehow they hit this without a session, send them back to login
    unless session[:user_id]
      redirect_to login_path, alert: "Please log in first"
      return
    end

    user = User.find_by(id: session[:user_id])
    # Duo "username" can be any stable identifier; email is fine
    duo_username = user&.email || "user-#{session[:user_id]}"

    @sig_request = Duo.sign_request(
      DUO["DUO_IKEY"],
      DUO["DUO_SKEY"],
      DUO["DUO_AKEY"],
      duo_username
    )
  end

  def duo_verify
    sig_response = params[:sig_response]

    authenticated_user = Duo.verify_response(
      DUO["DUO_IKEY"],
      DUO["DUO_SKEY"],
      DUO["DUO_AKEY"],
      sig_response
    )

    if authenticated_user
      session[:passed_duo] = true
      redirect_to root_path, notice: "Successfully authenticated with Duo"
    else
      session[:user_id] = nil
      session[:passed_duo] = nil
      redirect_to login_path, alert: "Duo authentication failed. Please try again."
    end
  end
end
