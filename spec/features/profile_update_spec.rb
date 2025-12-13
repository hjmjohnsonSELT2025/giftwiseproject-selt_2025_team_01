require 'rails_helper'

RSpec.feature "Profile Update", type: :feature do
  let(:user) do
    User.create!(
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  let!(:profile) do
    user.create_profile(
      name: "Old Name",
      age: 25,
      occupation: "Student",
      hobbies: "Reading",
      likes: "Tea",
      dislikes: "Noise"
    )
  end

  # Helper to click whatever login button text your app uses
  def click_login_button
    possible_labels = ["Log in", "Log In", "Login", "Sign in", "Sign In"]

    possible_labels.each do |label|
      if page.has_button?(label)
        click_button label
        return
      end
    end

    raise "Could not find a login button with any of: #{possible_labels.join(', ')}"
  end

  # Helper to click whatever submit button is on the profile form
  def click_profile_submit_button
    possible_labels = ["Update Profile", "Save Profile", "Save changes", "Save", "Update"]

    possible_labels.each do |label|
      if page.has_button?(label)
        click_button label
        return
      end
    end

    # Fallback: click the first submit-type button on the page
    if page.has_css?("input[type='submit'], button[type='submit']")
      first("input[type='submit'], button[type='submit']").click
      return
    end

    raise "Could not find any profile submit button"
  end

  before do
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "password123"

    click_login_button
  end

  scenario "User successfully updates their profile" do
    visit edit_profile_path(profile)

    fill_in "Name", with: "Updated Name"
    fill_in "Hobbies", with: "Running, coding"
    click_profile_submit_button

    expect(page).to have_content("Profile updated successfully.")
    expect(page).to have_content("Updated Name")
    expect(page).to have_content("Running, coding")
  end

  scenario "User fails to update with invalid age" do
    visit edit_profile_path(profile)

    fill_in "Age", with: "-5"
    click_profile_submit_button

    # Stay on the edit page (render :edit, no redirect)
    expect(page).to have_content("Edit Profile")

    # Age in the database should not have changed
    profile.reload
    expect(profile.age).to eq(25)

    # And the invalid value should still be in the form field
    expect(page).to have_field("Age", with: "-5")
  end

  scenario "User cannot edit another user's profile" do
    other_user = User.create!(
      email: "other@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    other_profile = other_user.create_profile(name: "Wrong Profile", age: 30)

    visit edit_profile_path(other_profile)

    expect(page).to have_content("You are not allowed to edit this profile.")
    expect(page).to have_current_path(profile_path(other_profile))
  end
end
