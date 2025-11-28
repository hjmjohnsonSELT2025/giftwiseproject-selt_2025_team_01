require "rails_helper"

RSpec.describe ProfilesController, type: :controller do
  let(:user) { User.create(email: "test@example.com", password: "password") }
  let(:profile) { Profile.create(user: user, name: "Test User") }

  before do
    session[:user_id] = user.id
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: profile.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #edit" do
    it "allows editing own profile" do
      get :edit, params: { id: profile.id }
      expect(response).to have_http_status(:ok)
    end

    it "redirects if editing another user's profile" do
      other_user = User.create(email: "other@example.com", password: "password")
      other_profile = Profile.create(user: other_user)

      get :edit, params: { id: other_profile.id }
      expect(response).to redirect_to(profile_path(other_profile))
      expect(flash[:alert]).to be_present
    end
  end
end
