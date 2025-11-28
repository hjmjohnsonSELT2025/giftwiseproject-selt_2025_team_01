# file: giftwise/features/profiles.feature
Feature: Profile attributes on signup
  As a user
  I want my account profile to include name, age, occupation, hobbies, likes, and dislikes
  So that those attributes are stored when I create an account

  Scenario: Sign up stores profile attributes
    Given I am on the sign up page
    When I sign up with the following email and password:
      | email      | alice@example.com     |
      | password   | password123           |
      | password_confirmation | password123 |
    Then I click the edit profile button
    When I fill in the profile form with the following details:
        | name       | Alice Example         |
        | age        | 30                    |
        | occupation | Software Engineer     |
        | hobbies    | Hiking, Reading       |
        | likes      | Coffee, Cats          |
        | dislikes   | Spam, Loud Noises     |
    And I submit the profile form
    Then a profile should be created with the following attributes:
      | name       | Alice Example         |
      | age        | 30                    |
      | occupation | Software Engineer     |
      | hobbies    | Hiking, Reading       |
      | likes      | Coffee, Cats          |
      | dislikes   | Spam, Loud Noises     |