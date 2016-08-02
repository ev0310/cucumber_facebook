@album
Feature: Albums for facebook user

  Scenario: As facebook developer, I can create new album
    Given I create test user1 with permissions:
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

    And these response keys should have value for "data":
      |name                  | New Album           |

    And these response keys should not be nil for "data":
      | created_time |
      | id           |

