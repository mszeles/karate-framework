Feature: Tests for home page
    Background: Definee url
        Given url 'http://localhost:3000/api/'

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['tag1', ' tag 2']
        And match response.tags !contains 'truck'
        And match response.tags == "#array"
        And match each response.tags == '#string'

    Scenario: Get articles
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        #Articles feature file always adds new article so this asertion is not ok anymore
        #And match response.articles == '#[1]'
        #And match response.articlesCount == 1