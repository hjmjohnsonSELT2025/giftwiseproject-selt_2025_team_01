Feature: User authentication
  As a visitor
  I want to sign up, log in, and log out
  So that I can securely manage my recipients

  Scenario: Signing up with valid data
    Given I am on the signup page
    When I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign Up"
    Then I should see "Edit Profile to get started!"


  Scenario: Logging in with valid credentials
    Given a user exists with email "newuser@example.com" and password "password"
    Given I am on the login page
    When I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "password"
    And I press "Log In"
    Then I should see "Recipients"

  Scenario: Securely logging out
    Given a user exists with email "user@example.com" and password "password"
    And I am logged in as "user@example.com"
    When I click on "Log Out"
    Then I should see "logged out"
    And I should not see "Log out"
    And I should see "Log In"

