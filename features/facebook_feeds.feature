@feed
Feature: post and read feeds

  Scenario: As facebook developer, I publish a new feed on test user profile
    Given I create test user1
    Given I create test user2

    Given a request is made to "/{user1}/feed"
    When these parameters are supplied in URL:
      |installed                | true              |
      |message                  | test              |
      |user_access_token        |                   |
    Then the POST api call should succeed

    Given a request is made to "/{user1}/feed"
    When these parameters are supplied in URL:
      |user_access_token        |                   |
    Then the GET api call should succeed

    And these response keys should have value for "data":
      |message                  | test              |

    And these response keys should not be nil for "data":
      | created_time |
      | id           |


