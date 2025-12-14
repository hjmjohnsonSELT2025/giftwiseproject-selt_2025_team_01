require 'rails_helper'

# ==============================
# NEW: User model specs for from_omniauth
# ==============================
RSpec.describe User, type: :model do
  let(:auth_hash) do
    OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456',
      info: { email: 'test@example.com', name: 'Test User', image: 'avatar.png' },
      extra: { raw_info: {} }
    )
  end

  context "when user does not exist" do
    it "creates a new user" do
      expect { User.from_omniauth(auth_hash) }.to change(User, :count).by(1)
      user = User.last
      expect(user.email).to eq('test@example.com')
      expect(user.provider).to eq('google_oauth2')
      expect(user.uid).to eq('123456')
    end
  end

  context "when user exists without provider/uid" do
    let!(:existing_user) { User.create!(email: 'test@example.com', password: 'password123') }

    it "updates provider and uid" do
      user = User.from_omniauth(auth_hash)
      expect(user.id).to eq(existing_user.id)
      expect(user.provider).to eq('google_oauth2')
      expect(user.uid).to eq('123456')
    end
  end

  context "when user exists with provider/uid" do
    let!(:existing_user) do
      User.create!(
        email: 'test@example.com',
        password: 'password123',
        provider: 'google_oauth2',
        uid: '123456'
      )
    end

    it "returns the existing user without creating a new one" do
      expect { User.from_omniauth(auth_hash) }.not_to change(User, :count)
    end
  end
end

# ==============================
# EXISTING CONTROLLER SPEC BELOW
# ==============================
RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  # This makes sure the Devise helpers are available for controller specs
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  # Helper method to simulate the omniauth authentication hash
  def mock_omniauth_auth(provider)
    OmniAuth::AuthHash.new({
                             provider: provider.to_s,
                             uid: '123456',
                             info: {
                               email: "test@example.com",
                               name: "Test User"
                             },
                             # Add necessary structure to ensure .except('extra') works without error
                             extra: {
                               raw_info: {}
                             }
                           })
  end

  # --- Shared Context for Omniauth Testing ---
  shared_context "OmniAuth Setup" do |provider|
    let(:auth_hash) { mock_omniauth_auth(provider) }

    # Before each test in the context, set the required environment variable
    before do
      request.env["omniauth.auth"] = auth_hash
    end
  end

  # =========================================================================
  # GOOGLE OAUTH2
  # =========================================================================
  describe "GET #google_oauth2" do
    include_context "OmniAuth Setup", :google_oauth2

    context "when authentication succeeds (user persists)" do
      let(:user) { instance_double("User") }

      before do
        allow(User).to receive(:from_omniauth).and_return(user)
        allow(user).to receive(:persisted?).and_return(true)
        allow(controller).to receive(:sign_in_and_redirect) do |*args|
          controller.render plain: "redirected"
        end
      end

      it "signs in the user" do
        expect(controller).to receive(:sign_in_and_redirect).with(user, event: :authentication)
        get :google_oauth2
      end

      it "sets a success flash message" do
        get :google_oauth2
        expect(flash[:notice]).to include("Google")
      end
    end

    context "when authentication fails (user does not persist)" do
      let(:user) { instance_double("User") }

      before do
        # We assume User.from_omniauth returns a user object that failed validation/persistence
        allow(User).to receive(:from_omniauth).and_return(user)
        allow(user).to receive(:persisted?).and_return(false)
      end

      it "redirects to the registration page" do
        get :google_oauth2
        expect(response).to redirect_to(new_user_registration_url)
      end

      it "sets an alert message" do
        get :google_oauth2
        expect(flash[:alert]).to eq('Something went wrong. Please try again.')
      end

      it "stores the omniauth data in the session" do
        get :google_oauth2
        expect(session['devise.google_data']).to eq(auth_hash.except('extra'))
      end
    end
  end

  # =========================================================================
  # GITHUB
  # =========================================================================
  describe "GET #github" do
    include_context "OmniAuth Setup", :github

    context "when authentication succeeds (user persists)" do
      let(:user) { instance_double("User", provider: "github") }

      before do
        allow(User).to receive(:from_omniauth).and_return(user)
        allow(user).to receive(:persisted?).and_return(true)
        allow(controller).to receive(:sign_in_and_redirect) do |*args|
          controller.render plain: "redirected"
        end
      end

      it "signs in the user" do
        expect(controller).to receive(:sign_in_and_redirect).with(user, event: :authentication)
        get :github
      end

      it "sets a success flash message" do
        get :github
        expect(flash[:notice]).to include("GitHub")
      end
    end

    context "when authentication fails (user does not persist)" do
      let(:user) { instance_double("User") }

      before do
        allow(User).to receive(:from_omniauth).and_return(user)
        allow(user).to receive(:persisted?).and_return(false)
      end

      it "redirects to the registration page" do
        get :github
        expect(response).to redirect_to(new_user_registration_url)
      end

      it "sets an alert message" do
        get :github
        expect(flash[:alert]).to eq('Something went wrong. Please try again.')
      end

      it "stores the omniauth data in the session" do
        get :github
        expect(session['devise.github_data']).to eq(auth_hash.except('extra'))
      end
    end
  end
end
