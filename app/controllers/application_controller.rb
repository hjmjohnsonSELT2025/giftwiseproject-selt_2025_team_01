class ApplicationController < ActionController::Base
  # Devise authentication
  before_action :authenticate_user!
  before_action :ensure_profile_exists

  private

  # [CONTROLLER & MODEL] Ensures that a Profile exists for the current user.
  # This method is called before every action in every controller to fix user accounts created
  # before the Profile update.
  # If the user is logged in but doesn't have a profile, it creates one with default values.
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
