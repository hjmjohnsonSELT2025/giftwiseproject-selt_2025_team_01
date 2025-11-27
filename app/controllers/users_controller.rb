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
    @user = User.new(user_params)

    if @user.save
      # automatically create an associated profile with default empty values
      @user.create_profile
      session[:user_id] = @user.id
      redirect_to profile_path(@user.profile), notice: "Edit Profile to get started!"
      # or redirect_to root_path, notice: "Welcome, #{@user.email}"
    else
      #render :new
      flash.now[:alert] = "There was an error creating your account."
      render :new, status: :unprocessable_entity
    end
  end


  private

  # [CONTROLLER] Strong Parameters pattern.
  # Acts as a security gate/firewall to prevent malicious users from overwriting
  # sensitive model attributes (like admin flags) during signup.
  # Used for signup form
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end