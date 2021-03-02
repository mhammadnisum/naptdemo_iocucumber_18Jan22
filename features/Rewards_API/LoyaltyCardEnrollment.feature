@oAuth
Feature: Card feature

  Background:
    Given that param "base_url.url" is set to value "http://localhost:8080"

  @post @CCRT-504 @CardEnrollment
  Scenario: POST initialization access token for api's
    Given that param "headers.Content-Type" is set to value with bearer token  "application/x-www-form-urlencoded"
    And that param "headers.Authorization" is set to value "Basic ZWNvbV9XUy9RQTpXU2Vjb20xMjM="
    And I read the JSON from file "/src/main/resources/testData/CardEnrollment/body.txt" into Dictionary Key "PostUsers"
    When I make a "POST" REST Call with URL "https://webauth-qa-rk01v.wsgc.com/oauth/token" and Body from Dictionary Key "PostUsers" to get oauth
    Then I verify that the response code is "200" for the response with Dictionary Key "PostUsers" and get oAuth


  @post @CCRT-420 @CreateLoyaltyAccount
  Scenario Outline: POST Create Loyalty Account Scenario
    Given that param "headers.Content-Type" is set to value with bearer token  "application/json"
    And that param "headers.Authorization" is set to value "access_token"
    And I read the JSON from file "<testData_Path>" and replace partner id with random generated into Dictionary Key "CREATE_ACCOUNT"
    When I make a "POST" REST Call with URL "/loyalty/v1/loyaltyCards" with random generated partner id and Body from Dictionary Key "CREATE_ACCOUNT"
    Then I verify that the post response code value is "<StatusCode>" for the response with Dictionary Key "CREATE_ACCOUNT" and get "<ResponseObject>" and "<responseMessage>"
    Examples:
      | testData_Path                                                             | StatusCode | ResponseObject | responseMessage             |
      | /src/main/resources/testData/CreateLoyaltyAccount/create_api_payload.json | 201        | status         | processed card successfully |


  @get  @GetLoyaltyCardAccount
  Scenario: Get loyalty card account by loyalty card id
    Given that param "headers.Content-Type" is set to value with bearer token  "application/json"
    And that param "headers.Authorization" is set to value "access_token"
    When I make a "GET" REST Call with URL "/loyalty/v1/loyaltyCards" from Dictionary Key "GET_ACCOUNT"
    Then I verify that the get response code value is "200" for the response with Dictionary Key "GET_ACCOUNT"

  @get  @LookupLoyaltyCardAccount
  Scenario: Lookup loyalty card account
    Given that param "headers.Content-Type" is set to value with bearer token  "application/json"
    And that param "headers.Authorization" is set to value "access_token"
    When I make a "LOOKUP" REST Call with URL "/loyalty/v1/loyaltyCards" from Dictionary Key "LOOKUP_ACCOUNT"
    Then I verify that the lookup response code value is "200" for the response with Dictionary Key "LOOKUP_ACCOUNT"