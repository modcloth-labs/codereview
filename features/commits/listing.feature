Feature: Listing commits
  In order to review commits
  A user
  Should be able to view a list of commits.
  
  Background:
    Given there are commits in the repository
    And there are "no" commits synched

  Scenario: Getting a list of commits
    When I visit the homepage
    And I sync with the repository
    Then I should see a list of commits
    