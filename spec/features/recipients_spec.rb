require "rails_helper"

RSpec.feature "Recipients Management", type: :feature do
  let!(:user) { User.create!(email: "testuser@example.com", password: "pass123", password_confirmation: "pass123") }

  before do
    # Log in the user before each scenario
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "pass123"
    click_button "Log in"
  end

  scenario "User sees empty recipients list initially" do
    visit recipients_path
    expect(page).to have_content("Your Recipients")
    expect(page).to have_link("Add Recipient")
    expect(page).not_to have_css("li")
  end

  scenario "User adds a new recipient successfully" do
    visit new_recipient_path
    fill_in "Name", with: "Alice"
    fill_in "Age", with: 25
    fill_in "Relationship", with: "friend"
    fill_in "Hobbies", with: "Books, Coffee"
    fill_in "Dislikes", with: "Noise"
    click_button "Create Recipient"

    # Redirects to show page of the newly created recipient
    recipient = user.recipients.last
    expect(current_path).to eq(recipient_path(recipient))

    expect(page).to have_content("Recipient added")
    expect(page).to have_content("Alice")
    expect(page).to have_content("25")
    expect(page).to have_content("friend")
    expect(page).to have_content("Books, Coffee")
    expect(page).to have_content("Noise")
  end

  scenario "User edits an existing recipient" do
    recipient = user.recipients.create!(name: "Bob", age: 30, relationship: "colleague", hobbies: "Hiking", dislikes: "Lateness")
    visit edit_recipient_path(recipient)

    fill_in "Name", with: "Bobby"
    fill_in "Age", with: 31
    fill_in "Relationship", with: "best friend"
    fill_in "Hobbies", with: "Hiking, Photography"
    fill_in "Dislikes", with: "Lateness, Spicy food"
    click_button "Update Recipient"

    expect(current_path).to eq(recipient_path(recipient))
    expect(page).to have_content("Recipient updated")
    expect(page).to have_content("Bobby")
    expect(page).to have_content("31")
    expect(page).to have_content("best friend")
    expect(page).to have_content("Hiking, Photography")
    expect(page).to have_content("Lateness, Spicy food")
  end

  scenario "User deletes a recipient" do
    recipient = user.recipients.create!(name: "Charlie")
    visit recipient_path(recipient)

    click_link "Delete"
    expect(page).to have_content("Recipient deleted")
    expect(user.recipients.find_by(id: recipient.id)).to be_nil
  end

  scenario "Validations: cannot create recipient without a name" do
    visit new_recipient_path
    fill_in "Name", with: ""
    click_button "Create Recipient"

    expect(page).to have_content("prohibited this recipient from being saved")
    expect(page).to have_content("Name can't be blank")
  end

  scenario "Unauthenticated access redirects to login" do
    click_link "Log Out"
    visit recipients_path
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content("Log in")
  end
end
