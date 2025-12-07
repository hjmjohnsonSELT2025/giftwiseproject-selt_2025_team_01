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