# language: ruby
# file: `giftwise/features/step_definitions/profile_steps.rb`
require 'capybara/cucumber'
require 'rspec/expectations'

GIVEN_SIGNUP_PATHS = ['/signup', '/users/sign_up']
SIGNUP_BUTTONS = ['Sign up', 'Sign Up', 'Create Account', 'Register']
EDIT_LINKS = ['Edit profile', 'Edit Profile', 'Edit']
PROFILE_SAVE_BUTTONS = ['Save Profile', 'Save', 'Update Profile', 'Update', 'Save changes']

Given(/^I am on the sign up page$/) do
  # try common signup URLs
  path = GIVEN_SIGNUP_PATHS.find { |p| visit(p); page.status_code == 200 rescue true }
  visit('/signup') unless path # default
end

When(/^I sign up with the following email and password:$/) do |table|
  params = table.rows_hash

  # Try common field labels for account signup
  if params['email']
    if page.has_field?('Email')
      fill_in 'Email', with: params['email']
    elsif page.has_field?('email')
      fill_in 'email', with: params['email']
    end
  end

  if params['password']
    if page.has_field?('Password')
      fill_in 'Password', with: params['password']
    elsif page.has_field?('password')
      fill_in 'password', with: params['password']
    end
  end

  if params['password_confirmation']
    if page.has_field?('Password confirmation')
      fill_in 'Password confirmation', with: params['password_confirmation']
    elsif page.has_field?('Password Confirmation')
      fill_in 'Password Confirmation', with: params['password_confirmation']
    elsif page.has_field?('password_confirmation')
      fill_in 'password_confirmation', with: params['password_confirmation']
    end
  end

  # submit signup
  clicked = false
  SIGNUP_BUTTONS.each do |btn|
    if page.has_button?(btn)
      click_button btn
      clicked = true
      break
    end
  end
  raise 'Could not find signup button' unless clicked
end

Then(/^I click the edit profile button$/) do
  # Attempt to click a visible edit link/button on current page
  clicked = false
  EDIT_LINKS.each do |link_text|
    if page.has_link?(link_text)
      click_link link_text
      clicked = true
      break
    elsif page.has_button?(link_text)
      click_button link_text
      clicked = true
      break
    end
  end

  # If an edit link wasn't present, try to visit the latest profile's edit page
  unless clicked
    profile = Profile.order(:created_at).last
    raise 'No profile found to edit' unless profile
    visit("/profiles/#{profile.id}/edit")
  end
end

When(/^I fill in the profile form with the following details:$/) do |table|
  params = table.rows_hash

  # Helper that tries several possible form field names for a given attribute
  try_fill = lambda do |attr_name, value|
    label_variants = [attr_name.capitalize, attr_name.downcase, "profile[#{attr_name}]", attr_name]
    label_variants.each do |label|
      if page.has_field?(label)
        fill_in label, with: value
        return true
      end
    end
    false
  end

  params.each do |key, value|
    next if value.nil?
    try_fill.call(key, value.to_s)
  end
end

When(/^I submit the profile form$/) do
  clicked = false
  PROFILE_SAVE_BUTTONS.each do |btn|
    if page.has_button?(btn)
      click_button btn
      clicked = true
      break
    end
  end
  raise 'Could not find profile save button on edit page' unless clicked
end

Then(/^a profile should be created with the following attributes:$/) do |table|
  expected = table.rows_hash
  profile = Profile.order(:created_at).last
  raise 'No profile created' unless profile

  expected.each do |key, value|
    key_norm = key.strip.downcase
    # ensure attribute exists
    unless profile.respond_to?(key_norm)
      raise "Profile does not respond to attribute `#{key_norm}`"
    end

    if key_norm == 'age'
      expect(profile.age).to eq(value.to_i)
    else
      expect(profile.send(key_norm).to_s).to eq(value.to_s)
    end
  end
end
