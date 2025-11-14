require 'rails_helper'

RSpec.describe "Recipient Management", type: :feature do
  let(:user) { create(:user) }  # assuming Devise or similar

  before do
    login_as(user)  # provided by Warden test helpers if using Devise
  end

  scenario "user creates a new recipient from the home page" do
    visit recipients_path  # home page

    click_link "Add Recipient"

    fill_in "First name",  with: "Ada"
    fill_in "Last name",   with: "Lovelace"
    fill_in "Age",         with: "28"
    fill_in "Occupation",  with: "Mathematician"
    fill_in "Hobbies",     with: "Math, computing"
    fill_in "Likes",       with: "Algorithms"
    fill_in "Dislikes",    with: "Bugs"

    click_button "Create Recipient"

    expect(page).to have_content("Recipient was successfully created")
    expect(page).to have_content("Ada Lovelace")
    expect(page).to have_content("Age: 28")
  end

  scenario "user submits invalid data" do
    visit recipients_path
    click_link "Add Recipient"

    click_button "Create Recipient"

    expect(page).to have_content("can't be blank")
  end
end
