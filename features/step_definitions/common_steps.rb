Given('I am on the signup page') do
  visit new_user_registration_path
end

Given('I am on the login page') do
  visit new_user_session_path
end

Given('I am on the home page') do
  visit '/'
end

When('I click on {string}') do |text|
  # Acceptable link texts for profile
  if text == "View Profile"
    text = "Profile"
  end

  click_link_or_button text
end

When('I fill in {string} with {string}') do |field, text|
  fill_in field, with: text
end

When('I press {string}') do |button|
  click_button button
end

Then('I should see {string}') do |text|
  expect(page).to have_content text
end

Then('I should not see {string}') do |text|
  expect(page).to_not have_content text
end

Given('a user exists with email {string} and password {string}') do |email, password|
  User.create!(email: email, password: password, password_confirmation: password)
end

Given('I am logged in as {string}') do |email|
  user = User.find_by(email: email)
  visit new_user_session_path
  fill_in 'Email', with: email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end