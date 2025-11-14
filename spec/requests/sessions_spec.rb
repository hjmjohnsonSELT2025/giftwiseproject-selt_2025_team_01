require 'rails_helper'

# NOTE: As of now (2:30 PM 11/14/2025), we already made our own test files to adhere to TDD/BDD.
# These files are: user_sign_up_spec.rb, user_login_spec.rb, and recipients_spec.rb,
# located in the `spec/features/` directory.
#
# These custom tests provide more comprehensive coverage and are better aligned with our application’s
# structure compared to the default session tests.
#
# We're not sure if we NEED to have these default test files, but just in case, we’ve modified
# this file to use the correct routes and functionality from our app.

RSpec.describe "Sessions", type: :request do
  # describe "GET /new" do
  describe "GET /login" do
    it "returns http success" do
      # get "/sessions/new"
      get "/login"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /login" do
    it "returns http success" do
      # create a user first
      user = User.create!(email: "test@example.com", password: "pass123", password_confirmation: "pass123")

      post "/login", params: { email: user.email, password: "pass123" }
      expect(response).to have_http_status(:redirect) # successful login will redirect
    end
  end

  describe "GET /destroy" do
    it "logs out succesfully" do
      delete "/logout"
      expect(response).to have_http_status(:redirect)
    end
  end

end
