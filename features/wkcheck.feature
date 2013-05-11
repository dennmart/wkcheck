Feature: Show pending lessons and reviews from WaniKani
  As a WaniKani user
  I want to see how many pending lessons and reviews I have

  Scenario: Saving API Key to file
    Given the file ".wkcheck.yml" doesn't exist in the home directory
    When I successfully run `wkcheck --api-key WKAPIKEYHERE`
    Then the file ".wkcheck.yml" should exist in the home directory
    And contain the API key "WKAPIKEYHERE"
    And the stdout should contain "WaniKani API Key saved"

  Scenario: Not saving the API key to file first
    Given the file ".wkcheck.yml" doesn't exist in the home directory
    When I run `wkcheck`
    Then it should fail with:
      """
      You must first save your WaniKani API Key using the --api-key flag.
      """
