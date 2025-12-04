require "rails_helper"

RSpec.feature "Event Recipient Management", type: :feature do
  let!(:user) { User.create!(email: "user@example.com", password: "pass123", password_confirmation: "pass123") }
  let!(:recipient1) { user.recipients.create!(name: "Alice") }
  let!(:recipient2) { user.recipients.create!(name: "Bob") }
  let!(:event) { user.events.create!(name: "Birthday Party", date: Date.today) }

  before do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "pass123"
    click_button "Log In"
  end

  scenario "User adds a recipient to an event" do
    visit event_path(event)

    # Alice should be in the "add" list
    within("#available-recipients") { expect(page).to have_content("Alice") }

    click_button "Add", match: :first

    expect(current_path).to eq(event_path(event))
    expect(page).to have_content("Recipient added")

    # Alice should now be in the "event-recipients" list
    within("#event-recipients") { expect(page).to have_content("Alice") }
  end

  scenario "User removes a recipient from an event" do
    # Pre-add Alice
    event.recipients << recipient1

    visit event_path(event)
    within("#event-recipients") { expect(page).to have_content("Alice") }

    click_button "Remove", match: :first

    expect(current_path).to eq(event_path(event))
    expect(page).to have_content("Recipient removed")
    within("#event-recipients") { expect(page).not_to have_content("Alice") }
  end

  scenario "Recipients not yet added show in the add list" do
    # Pre-add Alice
    event.recipients << recipient1
    visit event_path(event)

    within("#available-recipients") do
      expect(page).to have_content("Bob") # still available
      expect(page).not_to have_content("Alice") # already added
    end
  end
end
