class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params_signup)
    if @user.save
      redirect_to @user, notice: "Welcome, #{@user.email}"
      # session[:user_id] = @user.id
      # redirect_to root_path, notice: "Welcome, #{@user.email}"
    else
      flash.now[:alert] = "There was an error creating your account."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # Show user details here
    @user = User.find(session[:user_id])
  end

  # Form to edit profile details
  def edit
    @user = User.find(session[:user_id])
  end

  private

  # Used for signup form
  def user_params_signup
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # Used when editing the user's profile later
  def user_params_profile
    params.require(:user).permit(
    :name, :age, :occupation, :hobbies, :likes, :dislikes
    )
  end

end