Feature: Articles

#Executes before each scenario
Background: Define url
    Given url apiUrl

Scenario: New user Sign Up
    Given def userData = {"email": "signup@signup.hu", "username":"signup"}
    Given path 'users'
    And request
    """
        {
            "user": {
                "email": #('Test' + userData.email), 
                "password": "signup", 
                "username": #('Test' + userData.username)
            }
        }
    """
    When method Post
    Then status 200