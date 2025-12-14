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
    Then I should see "Welcome! You have signed up successfully"
    When I click on "View Profile"
    And I click on "Edit Profile"
    And I fill in the profile form with the following details:
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

  Scenario: Successfully update an existing profile
    Given an existing user with a profile
    And I am logged in as that user
    When I visit my profile edit page
    And I fill in the profile form with the following details:
      | name   | Updated Name        |
      | hobbies | Running, coding    |
    And I submit the profile form
    Then the profile should have the following attributes:
      | name   | Updated Name        |
      | hobbies | Running, coding    |

  Scenario: Attempt to update profile with invalid age
    Given an existing user with a profile
    And I am logged in as that user
    When I visit my profile edit page
    And I fill in the profile form with the following details:
      | age | -5 |
    And I submit the profile form
    Then I should see an age error message

