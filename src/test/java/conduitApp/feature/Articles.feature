@parallel=false
Feature: Articles

#Executes before each scenario
Background: Define url
    Given url apiUrl
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def articleValidator = read('classpath:conduitApp/json/articleValidator.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
    * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

@debug
Scenario: Create a new article
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 200
    And match response.article.title == articleRequestBody.article.title

Scenario: Create and delete article
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 200
    * def articleId = response.article.slug

    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title == articleRequestBody.article.title

    Given path 'articles', articleId
    When method Delete
    Then status 204

    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].title != "Delete me"

Scenario: Favorite articles
    Given path 'articles'
    When method Get
    Then status 200
    * def slugIdOfFirstArticle = response.articles[0].slug
    * def favoritesCountOfFirstArticle = response.articles[0].favoritesCount

    Given path 'articles/' + slugIdOfFirstArticle + '/favorite'
    When method Post
    Then status 200
    And match response.article == articleValidator

    Given path 'articles'
    When method Get
    Then status 200
    And match favoritesCountOfFirstArticle == (response.articles[0].favoritesCount - 1)

    Given path 'articles'
    Given params { favorited: "test"}
    When method Get
    Then status 200
    And match each response.articles == articleValidator
    And match response.articles[*].slug contains slugIdOfFirstArticle

Scenario: Comment articles
    #* def timeValidator = read('classpath:helpers/timeValidator.js')
    Given path 'articles'
    When method Get
    Then status 200
    * def slugIdOfFirstArticle = response.articles[0].slug
    * def articlesCount = response.articles.length

    Given path 'articles/' + slugIdOfFirstArticle + '/comments'
    When method Get
    Then status 200
    And match each response.comments ==
    """
        {
            "id": "#number",
            "body": "#string",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
    """
    * def commentCount = response.comments.length

    Given path 'articles/' + slugIdOfFirstArticle + '/comments'
    And request {"comment": {"body":"A comment"}}
    When method Post
    Then status 200
    * def commentId = response.comment.id

    Given path 'articles/' + slugIdOfFirstArticle + '/comments'
    When method Get
    Then status 200
    And match (commentCount + 1) == response.comments.length

    Given path 'articles/' + slugIdOfFirstArticle + '/comments/' + commentId
    When method Delete
    Then status 204

    Given path 'articles/' + slugIdOfFirstArticle + '/comments'
    When method Get
    Then status 200
    And match commentCount == response.comments.length
Scenario: Conditional logic
    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount
    #you have to pass objects not value
    * def article = response.articles[0]
    #* if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)
    * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favoritesCount

    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].favoritesCount == 1

#In order to pass this test, you have to create a new article, then after a few seconds you should favorite the article
@ignore
Scenario: Retry call
    * configure retry = { count: 10, interval: 5000}
    Given params { limit: 10, offset: 0}
    Given path 'articles'
    And retry until response.articles[0].favoritesCount == 1
    When method Get
    Then status 200

    * def favoritesCount = response.articles[0].favoritesCount
    #you have to pass objects not value
    * def article = response.articles[0]
    #* if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature', article)
    * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature', article).likesCount : favoritesCount

    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].favoritesCount == 1
Scenario: Sleep call
    * def sleep = function(pause) {java.lang.Thread.sleep(pause)}
    Given params { limit: 10, offset: 0}
    Given path 'articles'
    When method Get
    * eval sleep(5000)
    Then status 200
