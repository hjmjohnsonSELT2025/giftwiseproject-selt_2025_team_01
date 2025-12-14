# features/step_definitions/gift_idea_steps.rb

Given('the following users exist:') do |table|
  table.hashes.each do |user_attrs|
    User.create!(
      email: user_attrs['email'],
      password: user_attrs['password'],
      password_confirmation: user_attrs['password']
    )
  end
end

Given('I am logged out') do
  delete logout_path
end

Given('I have a recipient named {string}') do |name|
  user = User.find_by!(email: 'user@example.com')
  Recipient.create!(name: name, user: user)
end

When('I click {string} for {string}') do |action, item|
  gift = GiftIdea.find_by!(title: item)

  within("#gift_idea_#{gift.id}") do
    click_link_or_button action
  end
end


Given('{string} has the following gift ideas:') do |recipient_name, table|
  recipient = Recipient.find_by!(name: recipient_name)
  table.hashes.each do |attrs|
    GiftIdea.create!(
      title: attrs['title'],
      notes: attrs['notes'],
      recipient: recipient
    )
  end
end


# For viewing existing gift ideas
When('I view the gift ideas page for {string}') do |recipient_name|
  recipient = Recipient.find_by!(name: recipient_name)
  visit recipient_path(recipient)
end

# Keep the existing one for the form
Given('I am on the new gift ideas page for {string}') do |recipient_name|
  recipient = Recipient.find_by!(name: recipient_name)
  visit new_recipient_gift_idea_path(recipient)
end


When('I follow {string}') do |link|
  click_link link
end

Then('I should be on the login page') do
  expect(current_path).to eq(login_path)
end


Then('I should see a link to {string}') do |url|
  expect(page).to have_link(href: url)
end

# ============================================================================
# AI-SPECIFIC STEP DEFINITIONS
# ============================================================================

# Create recipient with detailed profile
Given('I have a recipient with the following details:') do |table|
  user = User.find_by!(email: 'user@example.com')
  attrs = table.rows_hash
  Recipient.create!(
    name: attrs['name'],
    age: attrs['age'],
    relationship: attrs['relationship'],
    hobbies: attrs['hobbies'],
    dislikes: attrs['dislikes'],
    user: user
  )
end

# Click button (generic for AI Gift Idea button and others)
When('I click {string}') do |button_text|
  click_button(button_text)
end

# Wait for AI suggestion to load
When('I wait for the AI suggestion to load') do
  sleep 2 # Wait for async JavaScript to complete
end

# Check if suggestion avoids dislikes
Then('the AI suggestion should not mention {string}') do |dislike|
  title = find_field('Title').value
  notes = find_field('Notes').value
  combined = "#{title} #{notes}".downcase

  expect(combined).not_to include(dislike.downcase)
end

# Verify AI suggestion wasn't saved after canceling
Then('the AI suggestion should not be saved') do
  # Verify the last gift idea wasn't created in last few seconds
  if GiftIdea.any?
    expect(GiftIdea.last.created_at).to be < 5.seconds.ago
  end
end

Then('I should be on the recipients page') do
  expect(current_path).to eq(recipients_path)
end

# Check professional appropriateness
Then('the AI suggestion should be appropriate for a professional relationship') do
  title = find_field('Title').value
  notes = find_field('Notes').value
  combined = "#{title} #{notes}".downcase

  # Check it doesn't contain overly personal items
  inappropriate_terms = ['romantic', 'intimate', 'personal care']
  inappropriate_terms.each do |term|
    expect(combined).not_to include(term)
  end
end