class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_profile
  before_action :authorize_user!, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: "Profile updated successfully."
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :age, :occupation, :hobbies, :likes, :dislikes)
  end

  def authorize_user!
    unless @profile.user_id == session[:user_id]
      redirect_to @profile, alert: "You are not allowed to edit this profile."
    end
  end

  def require_login
    redirect_to login_path unless session[:user_id]
  end
end
