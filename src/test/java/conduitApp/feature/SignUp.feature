Feature: Articles

#Executes before each scenario
Background: Define url
    Given url apiUrl

Scenario: New user Sign Up
    Given path 'users'
    And request {"user": {"email": "signup@signup.hu", "password": "signup", "username":"signup"}}
    When method Post
    Then status 200