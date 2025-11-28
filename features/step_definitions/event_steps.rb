# file: features/step_definitions/event_steps.rb
require 'capybara/cucumber'
require 'rspec/expectations'

When(/^I go to the events page$/) do
  visit events_path
end

Given(/^an event named "([^"]*)" on "([^"]*)" for user "([^"]*)"$/) do |name, date_str, email|
  user = User.find_by!(email: email)
  Event.create!(
    user: user,
    name: name,
    date: Date.parse(date_str)
  )
end

When(/^I visit the event page for "([^"]*)"$/) do |name|
  event = Event.find_by!(name: name)
  visit event_path(event)
end
