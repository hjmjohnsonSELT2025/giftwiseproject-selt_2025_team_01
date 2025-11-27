class ApplicationController < ActionController::Base
  # [VIEW & CONTROLLER] Exposes the 'current_user' method to all Views.
  # Normally, methods defined in controllers are not visible to views (ERB files).
  # This helper bridges that gap, allowing us to check 'current_user' in any view.
  helper_method :current_user # makes it available in views too
  before_action :ensure_profile_exists

  private

  # [MODEL & SESSION] Retrieves the currently logged-in user.
  # 1. Checks the 'session' (browser cookie storage) for a user_id.
  # 2. If found, queries the User Model to fetch the user's record from the database.
  # 3. Uses memoization (@current_user ||=) so we only query the database once per request.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # [CONTROLLER] Global Security Configuration.
  # Defines a default rule: "Run require_login before any action in any controller".
  # Subclasses (like UsersController) can override this using 'skip_before_action'.
  before_action :require_login
  # requires login for all controllers inheriting from ApplicationController

  # [CONTROLLER] The Guard Method.
  # Checks authentication state. If the user isn't logged in (session[:user_id] is missing),
  # it interrupts the request and redirects the browser to the login page (View).
  def require_login
    redirect_to login_path unless session[:user_id]
  end

  def ensure_profile_exists
    return unless current_user # ignore if logged out

    if current_user.profile.nil?
      current_user.create_profile(
        name: "New User",
        age: nil,
        occupation: "",
        hobbies: "",
        likes: "",
        dislikes: ""
      )
    end
  end

end
