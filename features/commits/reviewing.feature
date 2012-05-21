Feature: Reviewing commits
  A user
  Should be able to mark review commits

  Background:
    Given there are commits in the repository
    # And the commits have been synched
    And I visit the homepage
    And I reset and sync with the repository

  @javascript
  Scenario: Skipping a commit from review
    When I skip a commit from review
    Then there are no commits recorded in review state
    And there are no commits recorded in reject state
    And there are 1 commits recorded in accept state

  @javascript
  Scenario: Putting a commit in review
    When I review a commit
    Then I should see the Accept button for the commit
    Then I should see the Reject button for the commit
    And there are 1 commits recorded in review state
    And there are no commits recorded in reject state
    And there are no commits recorded in accept state
    
  @javascript
  Scenario: Rejecting a commit
    When I reject a commit
    
    And there are 1 commits recorded in review state
    And there are 1 commits recorded in reject state
    And there are no commits recorded in accept state

  @javascript
  Scenario: Accepting a commit
    When I accept a commit
    
    And there are no commits recorded in review state
    And there are no commits recorded in reject state
    And there are 1 commits recorded in accept state

  @wip
  Scenario: Restarting on a rejected commit
    When I reject a commit
  