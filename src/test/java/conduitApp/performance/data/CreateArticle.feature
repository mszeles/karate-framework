@parallel=false
Feature: Articles

#Executes before each scenario
Background: Define url
    Given url apiUrl
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequestBody.article.title = __gatling.Title
    * set articleRequestBody.article.description = __gatling.Description
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body

@debug
Scenario: Create and delete article
    * configure headers = {"Authorization": #('Token ' + __gatling.token)}
    Given path 'articles'
    And request articleRequestBody
    #Will replace url in gatling report with the specified name
    And header karate-name = 'Title requested: ' + __gatling.Title
    When method Post
    Then status 200
    * def articleId = response.article.slug

    #Simulating user think time. Only stops when using gatling
    * karate.pause(5000)

    Given path 'articles', articleId
    When method Delete
    Then status 204
