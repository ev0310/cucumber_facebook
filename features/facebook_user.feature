@test_user
Feature: Create and delete new test facebook user

  Scenario: As facebook developer, I'm creating a new test facebook user
    Given a request is made to "/{client_id}/accounts/test-users"
    When these parameters are supplied in URL:
      |installed       | true              |
      |access_token    |                   |
    Then the POST api call should succeed
    And I save Facebook user1

  Scenario: As facebook developer, I can delete all facebook test users
    And delete all test users

