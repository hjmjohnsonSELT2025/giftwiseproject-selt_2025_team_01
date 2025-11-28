Feature: Manage Recipients
  As a logged-in user
  I want to manage recipient profiles
  So that I can track people I buy gifts for

  Background:
    Given a user exists with email "user@example.com" and password "password"
    And I am logged in as "user@example.com"


  Scenario: Add a recipient with full information
    When I go to the recipients page
    And I click on "Add Recipient"
    And I fill in "Name" with "Mom"
    And I fill in "Age" with "55"
    And I fill in "Relationship" with "mother"
    And I fill in "Hobbies" with "Cooking, Gardening"
    And I fill in "Dislikes" with "Loud noise"
    And I press "Create Recipient"
    Then I should see "Recipient added"
    And I should see "Mom"
    And I should see "55"
    And I should see "mother"
    And I should see "Cooking, Gardening"
    And I should see "Loud noise"


  Scenario: Recipient information is permanently saved
    Given a recipient exists with name "Mom" for user "user@example.com"
    When I go to the recipients page
    Then I should see "Mom"


  Scenario: Delete recipient profile
    Given a recipient exists with name "Mom" for user "user@example.com"
    And I go to the recipients page
    And I click on "Mom"
    When I click on "Delete"
    Then I should see "Recipient deleted"
    And I should not see "Mom"