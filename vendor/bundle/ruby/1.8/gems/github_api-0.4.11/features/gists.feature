Feature: Accessing Gists Main API
  In order to interact with github gists
  GithubAPI gem
  Should return the expected results depending on passed parameters

  Background:
    Given I have "Github::Gists" instance

  Scenario: Lists all user's gists
    When I am looking for "gists" with the following params:
      | user          |
      | peter-murach  |
    And I make request within a cassette named "gists/gists/user_all"
    Then the response should be "200"
    And the response type should be "JSON"

  Scenario: Lists all public gists
    When I am looking for "gists" with the following params:
      | user |
      | nil  |
    And I make request within a cassette named "gists/gists/public_all"
    Then the response should be "200"
    And the response type should be "JSON"

  Scenario: Gets a single gist
    When I am looking for "gist" with the following params:
      | gist_id |
      | 1738161 |
    And I make request within a cassette named "gists/gist"
    Then the response should be "200"
    And the response type should be "JSON"
