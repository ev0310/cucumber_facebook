@album
Feature: Albums for facebook user

  Scenario: As facebook developer, I can create new album
    Given I create test user1 with permissions
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

    And these response keys should have value:
      |name                  | New Album     |

    And these response keys should not be nil for "data":
      | created_time |
      | id           |


  Scenario: As facebook developer, I can test error message when creating new album
    Given I create test user1 with permissions
      |user_photos    |

    Given a request is made to "/{user1}/albums"
    When these parameters are supplied in URL:
      |name                | New Album              |
      |is_default          | invalid_param          |
      |user_access_token   |                        |

    Then the POST api call should fail

    And these response keys should have value:
      |message                  | (#100) Param is_default must be a boolean           |
