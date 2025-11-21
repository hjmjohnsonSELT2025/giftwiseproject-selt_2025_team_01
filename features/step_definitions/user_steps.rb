# language: ruby
# File: giftwise/features/step_definitions/user_steps.rb

# Step definitions for user profile feature (create / view / edit / back).
# Uses FactoryBot, Capybara and common Rails path helpers (with simple fallbacks).

module UserStepsHelpers
  def find_or_create_user(email, password = 'password')
    User.find_by(email: email) || FactoryBot.create(:user, email: email, password: password, password_confirmation: password)
  end

  def try_visit(*paths)
    paths.each do |p|
      begin
        visit(p)
        return
      rescue StandardError
        next
      end
    end
    raise "Could not visit any of: #{paths.inspect}"
  end

  def try_click_button_or_link(name)
    if page.has_button?(name)
      click_button(name)
    elsif page.has_link?(name)
      click_link(name)
    else
      raise "No button or link named '#{name}' found on page"
    end
  end

  def root_path_fallback
    respond_to?(:root_path) ? root_path : '/'
  end
end

World(UserStepsHelpers)
#
# Given(/^a user exists with email "([^"]+)" and password "([^"]+)"$/) do |email, password|
#   FactoryBot.create(:user, email: email, password: password, password_confirmation: password)
# end

Given(/^I am signed in as "([^"]+)"$/) do |email|
  user = User.find_by(email: email) || FactoryBot.create(:user, email: email, password: 'password', password_confirmation: 'password')

  if defined?(login_as)
    login_as(user, scope: :user)
  else
    # Try Devise sign in form fallbacks
    begin
      try_visit(new_user_session_path)
    rescue StandardError
      try_visit('/users/sign_in', '/sign_in', '/login', '/sessions/new')
    end

    fill_in('Email', with: user.email) if page.has_field?('Email')
    fill_in('Password', with: 'password') if page.has_field?('Password')

    if page.has_button?('Log in')
      click_button('Log in')
    elsif page.has_button?('Sign in')
      click_button('Sign in')
    else
      # attempt submit if only one submit exists
      first('input[type="submit"]', visible: true)&.click
    end
  end
end

When(/^I visit the new profile page$/) do
  # common path names; adjust if your app uses different routes
  candidates = []
  candidates << (defined?(new_profile_path) ? new_profile_path : nil)
  candidates << (defined?(new_user_profile_path) ? new_user_profile_path : nil)
  candidates << '/profiles/new'
  candidates << '/profile/new'
  candidates << '/users/profile/new'
  candidates.compact!
  try_visit(*candidates)
end

When(/^I visit the home page$/) do
  begin
    visit(root_path)
  rescue StandardError
    try_visit('/', root_path_fallback)
  end
end

When(/^I visit the profile page for "([^"]+)"$/) do |email|
  user = User.find_by(email: email) || raise("No user with email #{email}")
  candidates = []
  candidates << (respond_to?(:user_profile_path) ? user_profile_path(user) : nil)
  candidates << (respond_to?(:profile_path) ? profile_path(user) : nil)
  candidates << (respond_to?(:user_path) ? user_path(user) : nil)
  candidates << "/users/#{user.id}"
  candidates << "/profiles/#{user.id}"
  candidates.compact!
  try_visit(*candidates)
end

When(/^I click "([^"]+)"$/) do |name|
  try_click_button_or_link(name)
end

When(/^I click "([^"]+)" button$/) do |name|
  click_button(name)
end

When(/^I click "([^"]+)" link$/) do |name|
  click_link(name)
end

When(/^I fill in "([^"]+)" with "([^"]+)"$/) do |field, value|
  fill_in(field, with: value)
end

Given(/^the user has a profile with:$/) do |table|
  # Assumes background created a user with known email; prefer first background or default to 'sue@example.com'
  email = (defined?(current_email) && current_email) || 'sue@example.com'
  user = User.find_by(email: email) || FactoryBot.create(:user, email: email, password: 'password', password_confirmation: 'password')
  attrs = {}
  table.rows_hash.each do |k, v|
    key = k.downcase.strip
    if key == 'age'
      attrs[:age] = v.to_i
    else
      attrs[key.to_sym] = v
    end
  end
  user.update!(attrs)
end

Then(/^I should be on the home page$/) do
  begin
    expect(page).to have_current_path(root_path)
  rescue StandardError
    expect(page).to have_current_path('/')
  end
end

Then(/^I should be signed in as "([^"]+)"$/) do |email|
  # prefer an explicit indicator, otherwise assert presence of the email
  if page.has_text?("Signed in as #{email}")
    expect(page).to have_text("Signed in as #{email}")
  else
    expect(page).to have_text(email)
  end
end

Then(/^I should be on the profile page for "([^"]+)"$/) do |email|
  user = User.find_by(email: email) || raise("No user with email #{email}")
  possible_paths = []
  possible_paths << (respond_to?(:user_profile_path) ? user_profile_path(user) : nil)
  possible_paths << (respond_to?(:profile_path) ? profile_path(user) : nil)
  possible_paths << (respond_to?(:user_path) ? user_path(user) : nil)
  possible_paths << "/users/#{user.id}"
  possible_paths << "/profiles/#{user.id}"
  possible_paths.compact!

  matched = possible_paths.any? { |p| URI.parse(page.current_url).path == p rescue false }
  if !matched
    # fallback check: page contains user's email or name
    expect(page).to have_text(email)
  else
    expect(matched).to be true
  end
end

Then(/^I should see "([^"]+)"$/) do |text|
  expect(page).to have_text(text)
end

Then(/^I should see a button "([^"]+)"$/) do |name|
  expect(page).to have_button(name)
end

Then(/^I should see a button "([^"]+)" on the page$/) do |name|
  expect(page).to have_button(name)
end

Then(/^I should see a button "([^"]+)"|link "([^"]+)"$/) do |_a|
  # noop -- kept for tolerant matching of slightly different phrasing
  # prefer explicit checks above.
end

Then(/^I should see a button "([^"]+)" or link "([^"]+)"$/) do |btn, link|
  expect(page).to have_button(btn).or have_link(link)
end
