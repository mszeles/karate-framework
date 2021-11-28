Feature: Articles
Background: Define url
    Given url 'http://localhost:3000/api/'
    Given path 'users/login'
    And request {"user": {"email": "test@test.hu", "password": "test"}}
    When method Post
    Then status 200
    * def token = response.user.token

Scenario: Create a new article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"tagList": [], "title": "Blabla", "description": "description", "body": body}}
    When method Post
    Then status 200
    And match response.article.title == "Blabla"
