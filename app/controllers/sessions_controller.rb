class SessionsController < ApplicationController
  # allow signup pages without authentication
  skip_before_action :require_login, only: %i[new create]

  # [VIEW] Renders the login form (app/views/sessions/new.html.erb).
  # No model interaction is needed here as we are just displaying a static form.
  def new
  end

  # [MODEL & CONTROLLER] Handles the logic for logging a user in.
  # 1. Communicates with the User model to find a record by email.
  # 2. Uses the model's 'authenticate' method (from has_secure_password) to verify the password.
  # 3. Sets the session cookie if successful, or re-renders the 'new' View with errors if authentication fails.
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome, #{user.email}"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  # [CONTROLLER] Handles the logout logic.
  # Clears the session data, effectively severing the link between the user's browser and the server-side authentication state.
  # Redirects the user back to the login View.
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to login_path
  end
end
