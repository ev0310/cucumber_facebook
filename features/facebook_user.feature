Feature: Create and delete new test facebook user

  Scenario: As facebook developer, I'm creating a new test facebook user
    Given a "POST" request is made to "/{client_id}/accounts/test-users"
    When these parameters are supplied in URL:
      |installed       | true              |
      |access_token    |                   |
    Then the api call should succeed

  Scenario: As facebook developer, I can get all facebook test users
    Given a "GET" request is made to "/{client_id}/accounts/test-users"
    When these parameters are supplied in URL:
      |access_token    |                   |
    Then the api call should succeed
    And I save all users ids

  Scenario: As facebook developer, I can delete all facebook test users
    Given a "DELETE" request is made to "/accounts/test-users"
    When these parameters are supplied in URL:
      |access_token    | |
