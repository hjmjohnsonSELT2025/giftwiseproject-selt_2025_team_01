Feature: Manage Recipients
  As a logged-in user
  I want to manage recipient profiles
  So that I can track people I buy gifts for

  Background:
    Given a user exists with email "user@example.com" and password "password"
    And I am logged in as "user@example.com"


  Scenario: Add a recipients with data
    When I go to the recipients page
    And I click on "Add Recipient"
    And I fill in "Name" with "Mom"
    And I press "Create Recipient"
    Then I should see "Recipient added"
    And I should see "Mom"


  Scenario: Recipient information is permanently saved
    Given a recipient exists with name "Mom" for user "user@example.com"
    When I go to the recipients page
    Then I should see "Mom"


  Scenario: Delete recipient profile
    Given a recipient exists with name "Mom" for user "user@example.com"
    And I am on the recipients page
    When I click "Delete" for recipient "Mom"
    Then I should not see "Mom"
    And I should see "Recipient deleted"