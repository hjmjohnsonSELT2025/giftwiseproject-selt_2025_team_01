require 'rails_helper'

RSpec.feature "User Sign Up", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  scenario "User successfully signs up w/ valid credentials" do
    visit new_user_registration_path

    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    click_button "Sign up"

    expect(page).to have_content("Recipients")
  end

  scenario "User fails to sign up w/ invalid credentials" do
    visit new_user_registration_path

    fill_in "Email", with: ""
    fill_in "Password", with: "123"
    fill_in "Password confirmation", with: "321"
    click_button "Sign up"

    expect(page).to have_content("3 errors prohibited this user from being saved:")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
  end

  scenario "User fails to sign up with an already registered email" do
    # First, create a user in the test database
    User.create!(
      email: "existinguser@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    # Then attempt to sign up again with the same email
    visit new_user_registration_path
    fill_in "Email", with: "existinguser@example.com"
    fill_in "Password", with: "newpassword456"
    fill_in "Password confirmation", with: "newpassword456"
    click_button "Sign up"

    # Expect to see an error related to duplicate email
    expect(page).to have_content("1 error prohibited this user from being saved:")
    expect(page).to have_content("Email has already been taken")
  end
end
