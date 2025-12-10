Feature: Manage event recipients
  As a logged-in user
  I want to add and remove recipients from events
  So that each event has the correct guest list

  Background:
    Given a user exists with email "user@example.com" and password "password"
    And I am logged in as "user@example.com"

  Scenario: Add a recipient to an event
    Given a recipient exists with name "Alice" for user "user@example.com"
    And an event named "Birthday Party" on "2025-12-25" for user "user@example.com"
    When I visit the event page for "Birthday Party"
    Then I should see "Add a Recipient to Event"
    And I should see "Alice"
    When I click on "Add"
    Then I should see "Recipient added"
    And I should see "Alice"

  Scenario: Remove a recipient from an event
    Given a recipient exists with name "Alice" for user "user@example.com"
    And an event named "Birthday Party" on "2025-12-25" for user "user@example.com"
    And "Alice" is added to the event "Birthday Party"
    When I visit the event page for "Birthday Party"
    And I click on "Remove"
    Then I should see "Recipient removed"
    And I should not see "Alice" in the event recipients list
    And I should see "Alice" in the available recipients list

  Scenario: Recipients already added should not appear in the Add list
    Given a recipient exists with name "Alice" for user "user@example.com"
    And a recipient exists with name "Bob" for user "user@example.com"
    And an event named "Party" on "2025-10-10" for user "user@example.com"
    And "Alice" is added to the event "Party"
    When I visit the event page for "Party"
    Then I should see "Bob"
    And I should see "Alice" in the event recipients list
    And I should not see "Alice" in the available recipients list

  Scenario: Delete an event that already has recipients
    Given a recipient exists with name "Alice" for user "user@example.com"
    And an event named "Holiday Dinner" on "2025-12-20" for user "user@example.com"
    And "Alice" is added to the event "Holiday Dinner"
    When I visit the event page for "Holiday Dinner"
    And I click on "Delete"
    Then I should see "Event deleted"
    And I should not see "Holiday Dinner"
