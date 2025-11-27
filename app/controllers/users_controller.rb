class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  # [VIEW & MODEL] Prepares the 'new' User view (Sign Up page).
  # Creates an empty User model object (@user) so the 'form_with' helper in the View
  # can infer fields and routing paths.
  def new
    @user = User.new
  end

  # [MODEL] Handles the creation of a new user in the database.
  # 1. Instantiates a new User model with sanitized parameters.
  # 2. Triggers Model validations via @user.save.
  # 3. If successful: specific controller logic logs them in immediately (setting session).
  # 4. If failed: re-renders the 'new' View so errors can be displayed.
  def create
    @user = User.new(user_params_signup)
    if @user.save
      #redirect_to @user, notice: "Welcome, #{@user.email}"
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome, #{@user.email}"
    else
      flash.now[:alert] = "There was an error creating your account."
      render :new, status: :unprocessable_entity
    end
  end

  # [MODEL & VIEW] Fetches data to display a user's profile.
  # Queries the User model using the ID stored in the session (security check)
  # and makes the @user variable available to the 'show' View.
  def show
    # Show user details here
    @user = User.find(session[:user_id])
  end

  # [MODEL & VIEW] Prepares the 'edit' View.
  # Fetches the current user from the Model so the form in the View is pre-filled
  # with existing database values.
  # Form to edit profile details
  def edit
    @user = User.find(session[:user_id])
  end

  private

  # [CONTROLLER] Strong Parameters pattern.
  # Acts as a security gate/firewall to prevent malicious users from overwriting
  # sensitive model attributes (like admin flags) during signup.
  # Used for signup form
  def user_params_signup
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # [CONTROLLER] Strong Parameters for profile updates.
  # Allows a different set of attributes to be modified than during signup.
  # Used when editing the user's profile later
  def user_params_profile
    params.require(:user).permit(
    :name, :age, :occupation, :hobbies, :likes, :dislikes
    )
  end

end