Feature: Listing commits
  In order to review commits
  A user
  Should be able to view a list of commits.
  
  Background:
    Given there are commits in the repository
    And there are no commits synched

  Scenario: Getting a list of commits
    When I visit the homepage
    Then I should see no commits

    When I sync with the repository
    Then I should see a list of new commits
    
    And there are no commits recorded in review state
    And there are no commits recorded in accept state
    And there are no commits recorded in reject state
