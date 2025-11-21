Feature: Create Events
  As a logged-in user
  I want to create events
  So that I can plan gifts for occasions like Christmas

  Background:
    Given a user exists with email "user@example.com" and password "password"
    And I am logged in as "user@example.com"
    And I am on the recipients page


  Scenario: Create an event successfully
    When I go to the events page
    And I click on "Add Event"
    And I fill in "Name" with "Christmas"
    And I fill in "Date" with "2025-12-25"
    And I fill in "Description" with "Family Christmas gift exchange"
    And I press "Create Event"
    Then I should see "Event was successfully created."
    And I should see "Christmas"
    And I should see "2025-12-25"
    And I should see "Family"

  Scenario: Show validation error when name is missing
    When I go to the events page
    And I click on "Add Event"
    And I fill in "Name" with ""
    And I fill in "Date" with "2025-12-25"
    And I press "Create Event"
    Then I should see "Name can't be blank"