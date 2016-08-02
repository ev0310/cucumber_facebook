@feed
Feature: post and read feeds

  Scenario: As facebook developer, I publish a new feed on test user profile
    Given I create test user1 with permissions
      |read_stream    |
      |publish_actions|
      |user_posts     |
    Given I create test user2 with permissions
      |read_stream    |
      |publish_actions|
      |user_posts     |

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

# sending feed to  2nd user

    Given a request is made to "/{user2}/feed"
    When these parameters are supplied in URL:
      |installed                | true              |
      |message                  | test 2            |
      |user_access_token        |                   |
    Then the POST api call should succeed

    Given a request is made to "/{user2}/feed"
    When these parameters are supplied in URL:
      |user_access_token        |                   |
    Then the GET api call should succeed

    And these response keys should have value for "data":
      |message                  | test 2           |

    And these response keys should not be nil for "data":
      | created_time |
      | id           |


  Scenario: As facebook developer, I can change name of test user
    Given I create test user1 with permissions
      |read_stream    |
      |publish_actions|
      |user_posts     |
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

  Scenario: As facebook developer, I can create new album
    Given I create test user1 with permissions
    |read_stream    |
    |publish_actions|
    |user_posts     |
    |user_photos    |

    Given a request is made to "/{user1}/albums"
    When these parameters are supplied in URL:
      |name                | New Album              |
      |user_access_token   |                        |

    Then the POST api call should succeed

    Given a request is made to "/{user1}/albums"
    When these parameters are supplied in URL:
      |user_access_token   |                   |
    Then the GET api call should succeed