Feature: Articles

#Executes before each scenario
Background: Define url
    Given url 'http://localhost:3000/api/'
    * def tokenResponse = call read('classpath:helpers/CreateToken.feature')
    * def token = tokenResponse.authToken

#@ignore
Scenario: Create a new article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"tagList": [], "title": "Blabla", "description": "description", "body": body}}
    When method Post
    Then status 200
    And match response.article.title == "Blabla"

Scenario: Create and delete article
    Given header Authorization = 'Token ' + token
    Given path 'articles'
    And request {"article": {"tagList": [], "title": "Delete me", "description": "description", "body": body}}
    When method Post
    Then status 200
    * def articleId = response.article.slug

    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == "Delete me"

    Given header Authorization = 'Token ' + token
    Given path 'articles', articleId
    When method Delete
    Then status 204

    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != "Delete me"