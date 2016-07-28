@test_user
Feature: Create and delete new test facebook user

  Scenario: As facebook developer, I'm creating a new test facebook user
    Given a request is made to "/{client_id}/accounts/test-users"
    When these parameters are supplied in URL:
      |installed       | true              |
      |access_token    |                   |
    And I make test Facebook user1


