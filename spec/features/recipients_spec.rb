require "rails_helper"

RSpec.feature "Recipients Management", type: :feature do
  let!(:user) { User.create!(email: "testuser@example.com", password: "password123", password_confirmation: "password123") }

  # Log in before each scenario
  before do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password123"
    click_button "Log In"
  end

  scenario "User sees empty recipients list initially" do
    visit recipients_path
    expect(page).to have_content("Your Recipients")
    expect(page).to have_link("Add Recipient")
    expect(page).not_to have_css("li") # no recipients yet
  end

  scenario "User adds a new recipient" do
    visit new_recipient_path
    fill_in "Name", with: "Alice"
    fill_in "Description", with: "Loves books and coffee"
    click_button "Create Recipient"

    expect(page).to have_content("Recipient added")
    expect(page).to have_content("Alice")
    expect(page).to have_content("Loves books and coffee")
  end

  scenario "User edits a recipient" do
    recipient = user.recipients.create!(name: "Bob", description: "Enjoys hiking")
    visit edit_recipient_path(recipient)

    fill_in "Name", with: "Bobby"
    fill_in "Description", with: "Hiking and photography"
    click_button "Update Recipient"

    expect(page).to have_content("Recipient updated")
    expect(page).to have_content("Bobby")
    expect(page).to have_content("Hiking and photography")
  end

  scenario "User deletes a recipient" do
    recipient = user.recipients.create!(name: "Charlie", description: "Music lover")
    visit recipients_path

    page.driver.submit :delete, recipient_path(recipient), {}

    expect(page).to have_content("Recipient deleted")
    expect(page).not_to have_content("Charlie")
  end
end