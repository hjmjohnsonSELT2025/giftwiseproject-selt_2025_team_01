Feature: User profile management
  In order to manage my personal information
  As a signed in user
  I want to create, view and edit my profile fields (name, age, occupation, hobbies, likes, dislikes)

  Background:
    Given a user exists with email "sue@example.com" and password "password"
    And I am signed in as "sue@example.com"

  Scenario: Create profile from the Create Profile page
    When I visit the new profile page
    And I fill in "Name" with "Sue Smith"
    And I fill in "Age" with "30"
    And I fill in "Occupation" with "Engineer"
    And I fill in "Hobbies" with "Hiking, Reading"
    And I fill in "Likes" with "Coffee, Cats"
    And I fill in "Dislikes" with "Traffic"
    And I click "Create Profile"
    Then I should be on the home page
    And I should be signed in as "sue@example.com"
    And I should see "View Profile"

  Scenario: View profile from home page
    Given the user has a profile with:
      | name       | Sue Smith           |
      | age        | 30                  |
      | occupation | Engineer            |
      | hobbies    | Hiking, Reading     |
      | likes      | Coffee, Cats        |
      | dislikes   | Traffic             |
    When I visit the home page
    And I click "View Profile"
    Then I should be on the profile page for "sue@example.com"
    And I should see "Sue Smith"
    And I should see "30"
    And I should see "Engineer"
    And I should see "Hiking, Reading"
    And I should see "Coffee, Cats"
    And I should see "Traffic"
    And I should see a button "Edit Profile"
    And I should see a button "Back"

  Scenario: Edit profile and save changes
    Given the user has a profile with:
      | name       | Sue Smith           |
      | age        | 30                  |
      | occupation | Engineer            |
    When I visit the home page
    And I click "View Profile"
    And I click "Edit Profile"
    And I fill in "Occupation" with "Senior Engineer"
    And I fill in "Hobbies" with "Hiking, Reading, Cooking"
    And I click "Save Profile"
    Then I should be on the profile page for "sue@example.com"
    And I should see "Senior Engineer"
    And I should see "Hiking, Reading, Cooking"

  Scenario: Back button returns to home page
    Given the user has a profile
    When I visit the profile page for "sue@example.com"
    And I click "Back"
    Then I should be on the home page
