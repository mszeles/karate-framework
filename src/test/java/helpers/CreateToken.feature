Feature: Create token

    Scenario: Create token
        Given url 'http://localhost:3000/api/'
        Given path 'users/login'
        And request {"user": {"email": "#(email)", "password": "#(password)"}}
        When method Post
        Then status 200
        * def authToken = response.user.token