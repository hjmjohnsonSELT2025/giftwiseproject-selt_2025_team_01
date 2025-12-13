# ruby
require "rails_helper"

RSpec.feature "User Login", type: :feature do
  let!(:user) { User.create!(email: "test@example.com", password: "password123", password_confirmation: "password123") }

  scenario "User logs in with valid credentials" do
    visit new_user_session_path
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    click_button "Log in"
    expect(page).to have_content("Logged in as test@example.com")
  end

  scenario "User fails login with invalid credentials" do
    visit new_user_session_path
    fill_in "Email", with: "wrong@example.com"
    fill_in "Password", with: "wrongpass"
    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")
  end

  scenario "User logs out successfully" do
    # Log in first
    visit new_user_session_path
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    click_button "Log in"

    expect(page).to have_link("Log Out")
    click_link "Log Out"
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
