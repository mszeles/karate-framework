Feature: Articles

#Executes before each scenario
Background: Define url
    Given url apiUrl
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()

Scenario: New user Sign Up

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

    #In theory the service should return the below listed errors, but in reality it is returning 404 api/users not found. I leave it to have an example
    #of scenario outline and error validation
    @ignore
    Scenario Outline: Validate Sign Up error messages
        Given path 'users'
        And request
        """
            {
                "user": {
                    "email": "<email>", 
                    "password": "<password>", 
                    "username": "<username>"
                }
            }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>
        Examples:
            | email             | password  | username          | errorResponse
            | #(randomEmail)    | test      | test              | {"errors": {"username": ["has already been takne"]}}
            | test@test.hu      | test      | #(randomUsername) | {"errors": {"email": ["has already been takne"]}}
