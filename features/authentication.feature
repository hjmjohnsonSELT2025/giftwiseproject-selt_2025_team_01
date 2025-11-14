Feature: User authentication
  As a visitor
  I want to sign up, log in, and log out
  So that I can securely manage my recipients

  Scenario: Signing up with valid data
    Given I am on the signup page
    When I fill in "Email" with "newuser@example.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "Welcome"
    And I should see "Recipients"


  Scenario: Logging in with valid credentials
