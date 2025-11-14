require 'rails_helper'

RSpec.describe "Users", type: :request do
  # describe "GET /new" do
  describe "GET /signup" do
    it "returns http success" do
      # get "/users/new"
      get "/signup"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /users" do
    # it "returns http success" do
    it "creates a new user and redirects" do
      post "/users", params: { user: { email: "test@example.com", password: "pass123", password_confirmation: "pass123" } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /recipients" do
    it "shows the recipients page after login" do
      # make user & login
      user = User.create!(email: "test@example.com", password: "pass123", password_confirmation: "pass123")
      post "/login", params: { email: user.email, password: "pass123" }
      session[:user_id] = user.id # we can probably get a gem to make this cleaner

      # Go to actual recipients view page
      get recipients_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Logged in as test@example.com")
    end
  end

end
