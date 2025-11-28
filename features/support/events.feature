Feature: Manage Events
  As a user
  I want to create, edit, delete, and view events
  So that I can organize gift planning around multiple occasions

  Background:
    Given a user exists with email "user@example.com" and password "password"
    And I am logged in as "user@example.com"
    And I go to the events page

  Scenario: Create an event with name, date, and theme
    When I click on "Add Event"
    And I fill in "Name" with "Birthday Party"
    And I fill in "Date" with "2025-12-25"
    And I fill in "Theme" with "Blue"
    And I press "Create Event"
    Then I should see "Event created!"
    And I should see "Birthday Party"
    And I should see "2025-12-25"

  Scenario: Edit an existing event
    Given an event named "Anniversary" on "2025-01-01" for user "user@example.com"
    When I go to the events page
    And I click on "Anniversary – 2025-01-01"
    And I click on "Edit"
    And I fill in "Name" with "Updated Anniversary"
    And I press "Update Event"
    Then I should see "Event updated!"
    And I should see "Updated Anniversary"

  Scenario: Delete an event
    Given an event named "Disposable Event" on "2025-06-15" for user "user@example.com"
    When I visit the event page for "Disposable Event"
    And I click on "Delete"
    Then I should see "Event deleted"
    And I should not see "Disposable Event"

  Scenario: View upcoming and past events
    Given an event named "Past Event" on "2024-01-01" for user "user@example.com"
    And an event named "Future Event" on "2026-01-01" for user "user@example.com"
    When I go to the events page
    Then I should see "Past Event"
    And I should see "Future Event"
