@test_user
Feature: Create and delete new test facebook user
  Make friends
  Change name of newly created test user

#  Keeping this scenario as example only since we moved it into nested steps in
#  common_steps.rb
#  Scenario: As facebook developer, I'm creating a new test facebook user
#    Given a request is made to "/{client_id}/accounts/test-users"
#    When these parameters are supplied in URL:
#      |installed       | true              |
#      |access_token    |                   |
#    And I make test Facebook user1


  Scenario: As facebook developer, I can change name of test user
    Given I create test user1 with permissions
    Given a request is made to "/{user1}"
    When these parameters are supplied in URL:
      |name                | Lucy              |
      |user_access_token   |                   |
    Then the POST api call should succeed

    Given a request is made to "/{user1}"
    When these parameters are supplied in URL:
      |user_access_token   |                   |
    Then the GET api call should succeed
    And these response keys should have value:
      | name | Lucy|

  Scenario: As facebook developer, I can make friends
    Given I create test user1 with permissions
    Given I create test user2 with permissions with name Mike

    When a request is made to "/{user1}/friends"
    When these parameters are supplied in URL:
      |uid                 | user2             |
      |user_access_token   |                   |
    Then the POST api call should succeed

    When a request is made to "/{user2}/friends"
    When these parameters are supplied in URL:
      |uid                 | user1             |
      |user_access_token   |                   |
    Then the POST api call should succeed

    When a request is made to "/{user1}/friends"
    When these parameters are supplied in URL:
      |user_access_token   |                   |
    Then the GET api call should succeed

    And these response keys should have value for "data":
      |name                  | Mike           |
