require 'rails_helper'

RSpec.feature "User Sign Up", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  scenario "User successfully signs up w/ valid credentials" do
    visit signup_path

    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_button "Sign Up"

    expect(page).to have_content("Welcome, newuser@example.com")
  end

  scenario "User fails to sign up w/ invalid credentials" do
    visit signup_path

    fill_in "Email", with: ""
    fill_in "Password", with: "123"
    fill_in "Password confirmation", with: "321"
    click_button "Sign Up"

    expect(page).to have_content("error")
  end

  scenario "User fails to sign up with an already registered email" do
    # First, create a user in the test database
    User.create!(
      email: "existinguser@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    # Then attempt to sign up again with the same email
    visit signup_path
    fill_in "Email", with: "existinguser@example.com"
    fill_in "Password", with: "newpassword456"
    fill_in "Password confirmation", with: "newpassword456"
    click_button "Sign Up"

    # Expect to see an error related to duplicate email
    expect(page).to have_content("This Email is already in use")
  end
end
