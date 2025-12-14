Feature: Add Gift Ideas
  As a user
  I want to add gift ideas for my recipients
  So that I can keep track of potential gifts

  Background:
    Given the following users exist:
      | email              | password |
      | user@example.com   | password |
      | other@example.com  | password |
    And I am logged in as "user@example.com"
    And I have a recipient named "Mom"

  Scenario: Successfully add a gift idea with all fields
    Given I am on the new gift ideas page for "Mom"
    When I fill in "Title" with "Spa Day Package"
    And I fill in "Notes" with "Relaxing spa treatment at local spa"
    And I fill in "Link" with "https://example.com/spa"
    And I press "Save Gift Idea"
    Then I should see "Gift idea was successfully created"
    And I should see "Spa Day Package"
    And I should see "Relaxing spa treatment at local spa"

  Scenario: Add a gift idea with only required fields
    Given I am on the new gift ideas page for "Mom"
    When I fill in "Title" with "Coffee Maker"
    And I press "Save Gift Idea"
    Then I should see "Gift idea was successfully created"
    And I should see "Coffee Maker"

  Scenario: Fail to add a gift idea without a title
    Given I am on the new gift ideas page for "Mom"
    When I fill in "Notes" with "Some notes"
    And I press "Save Gift Idea"
    Then I should see "Title can't be blank"
    And I should not see "Gift idea was successfully created"

  Scenario: Add multiple gift ideas to the same recipient
    Given I am on the new gift ideas page for "Mom"
    When I fill in "Title" with "Book Collection"
    And I press "Save Gift Idea"
    Then I should see "Gift idea was successfully created"
    When I follow "Add Gift Idea"
    And I fill in "Title" with "Garden Tools"
    And I press "Save Gift Idea"
    Then I should see "Gift idea was successfully created"
    And I should see "Book Collection"
    And I should see "Garden Tools"

  Scenario: Add gift idea with a URL
    Given I am on the new gift ideas page for "Mom"
    When I fill in "Title" with "Smart Watch"
    And I fill in "Link" with "https://amazon.com/watch"
    And I press "Save Gift Idea"
    Then I should see "Gift idea was successfully created"
    And I should see a link to "https://amazon.com/watch"

  Scenario: Deleting a gift idea
    Given "Mom" has the following gift ideas:
      | title          | notes                    |
      | Spa Package    | Relaxing spa day         |
    When I view the gift ideas page for "Mom"
    When I click "Delete" for "Spa Package"
    Then I should not see "Spa Package"


  Scenario: View all gift ideas for a recipient
    Given "Mom" has the following gift ideas:
      | title          | notes                    |
      | Spa Package    | Relaxing spa day         |
      | Book Set       | Mystery novel collection |
      | Garden Tools   | For her garden hobby     |
    When I view the gift ideas page for "Mom"
    Then I should see "Spa Package"
    And I should see "Book Set"
    And I should see "Garden Tools"

    Scenario: Successfully edit a gift idea with
      Given "Mom" has the following gift ideas:
        | title          | notes                    |
        | Spa Package    | Relaxing spa day         |
      When I view the gift ideas page for "Mom"
      When I click "Edit" for "Spa Package"
      When I fill in "Title" with "Deluxe Spa Package"
      When I fill in "Notes" with "1/02/26"
      And I press "Update Gift Idea"
      Then I should see "Gift idea was successfully updated."
      And I should see "Deluxe Spa Package"
      And I should see "1/02/26"


    Scenario: Fails to update with blank title
      Given "Mom" has the following gift ideas:
        | title          | notes                    |
        | Spa Package    | Relaxing spa day         |
      When I view the gift ideas page for "Mom"
      When I click "Edit" for "Spa Package"
      When I fill in "Title" with ""
      And I press "Update Gift Idea"
      Then I should not see "Gift idea was successfully updated."


    Scenario: Backing out with filled out edit fields
      Given "Mom" has the following gift ideas:
        | title          | notes                    |
        | Spa Package    | Relaxing spa day         |
      When I view the gift ideas page for "Mom"
      When I click "Edit" for "Spa Package"
      When I fill in "Title" with "Deluxe Spa Package"
      When I fill in "Notes" with "1/02/26"
      And I click on "Back to Recipient"
      Then I should see "Spa Package"
      And I should see "Relaxing spa day"

