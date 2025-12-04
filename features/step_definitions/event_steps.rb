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

Given(/^"([^"]*)" is added to the event "([^"]*)"$/) do |recipient_name, event_name|
  recipient = Recipient.find_by!(name: recipient_name)
  event = Event.find_by!(name: event_name)

  event.recipients << recipient unless event.recipients.include?(recipient)
end

When(/^I try to add "([^"]*)" to the event "([^"]*)"$/) do |recipient_name, event_name|
  event = Event.find_by!(name: event_name)
  recipient = Recipient.find_by!(name: recipient_name)

  within("#available-recipients") do
    find("li", text: recipient.name).click_button("Add")
  end
end

Then(/^I should (not )?see "([^"]*)" in the event recipients list$/) do |negation, name|
  within("#event-recipients") do
    if negation
      expect(page).not_to have_text(name)
    else
      expect(page).to have_text(name)
    end
  end
end

Then(/^I should (not )?see "([^"]*)" in the available recipients list$/) do |negation, name|
  within("#available-recipients") do
    if negation
      expect(page).not_to have_text(name)
    else
      expect(page).to have_text(name)
    end
  end
end
