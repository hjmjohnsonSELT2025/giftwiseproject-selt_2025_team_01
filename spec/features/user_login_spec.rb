require "rails_helper"

RSpec.feature "User Login", type: :feature do
  let!(:user) { User.create!(email: "test@example.com", password: "password123", password_confirmation: "password123") }

  scenario "User logs in with valid credentials" do
    visit login_path
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    click_button "Log In"

    expect(page).to have_content("Welcome, test@example.com")
  end

  scenario "User fails login with invalid credentials" do
    visit login_path
    fill_in "Email", with: "wrong@example.com"
    fill_in "Password", with: "wrongpass"
    click_button "Log In"

    expect(page).to have_content("Invalid email or password")
  end

  # scenario "User logs out successfully" do
  #   # Log in first
  #   visit login_path
  #   fill_in "Email", with: "test@example.com"
  #   fill_in "Password", with: "password123"
  #   click_button "Log In"
  #
  #   click_link "Logout"
  #   expect(page).to have_content("You have been logged out")
  # end
end
