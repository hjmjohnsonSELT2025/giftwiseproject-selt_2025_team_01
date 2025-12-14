Feature: AI-Generated Gift Suggestions
  As a user
  I want to request AI-generated gift suggestions for a recipient
  So that I get relevant ideas automatically

  Background:
    Given the following users exist:
      | email              | password |
      | user@example.com   | password |
    And I am logged in as "user@example.com"

  Scenario: Modify AI suggestion before saving
    Given I have a recipient named "Friend"
    And I am on the new gift ideas page for "Friend"
    When I click "AI Gift Idea"
    And I wait for the AI suggestion to load
    And I fill in "Title" with "Customized Gift Basket"
    And I fill in "Notes" with "Added personal touch to AI suggestion"
    And I press "Save Gift Idea"
    Then I should see "Gift idea was successfully created"
    And I should see "Customized Gift Basket"
    And I should see "Added personal touch to AI suggestion"

  Scenario: AI suggestion avoids recipient dislikes
    Given I have a recipient with the following details:
      | name     | Nephew                |
      | hobbies  | Video games           |
      | dislikes | Educational books     |
    And I am on the new gift ideas page for "Nephew"
    When I click "AI Gift Idea"
    And I wait for the AI suggestion to load
    Then the AI suggestion should not mention "Educational books"

  Scenario: Cancel form after generating AI suggestion
    Given I have a recipient named "Niece"
    And I am on the new gift ideas page for "Niece"
    When I click "AI Gift Idea"
    And I wait for the AI suggestion to load
    And I click on "Back to Recipient"
    Then I should be on the recipient page for "Niece"
    And the AI suggestion should not be saved

  Scenario: Generate AI suggestion considers relationship
    Given I have a recipient with the following details:
      | name         | Boss        |
      | relationship | Professional|
    And I am on the new gift ideas page for "Boss"
    When I click "AI Gift Idea"
    And I wait for the AI suggestion to load
    Then the AI suggestion should be appropriate for a professional relationship