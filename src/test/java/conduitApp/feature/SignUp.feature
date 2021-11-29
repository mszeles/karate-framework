Feature: Articles

#Executes before each scenario
Background: Define url
    Given url apiUrl
    * def dataGenerator = Java.type('helpers.DataGenerator')

    @debug
Scenario: New user Sign Up
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()

    #call non-static java method example
    * def jsFunction =
    """
        function() {
            var DataGenerator = Java.type('helpers.DataGenerator')
            var generator = new DataGenerator()
            return generator.nonStaticExample()
        }
    """
    * def randomUsername2 = call jsFunction
    Given path 'users'
    And request
    """
        {
            "user": {
                "email": #(randomEmail), 
                "password": "signup", 
                "username": #(randomUsername)
            }
        }
    """
    When method Post
    Then status 200
    And match response ==
    """
        {
            "user": {
                "username": #(randomUsername),
                "email": #(randomEmail),
                "token": "#string",
                "bio": "##string",
                "image": "##string"
            }
        }        
    """