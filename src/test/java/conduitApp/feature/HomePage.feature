Feature: Tests for home page
    Background: Definee url
        Given url apiUrl
        * def articleValidator = read('classpath:conduitApp/json/articleValidator.json')

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['tag1', ' tag 2']
        And match response.tags !contains 'truck'
        And match response.tags contains any ['fish', 'tag3']
        And match response.tags contains only ['tag1', ' tag 2', 'tag3']
        And match response.tags == "#array"
        And match each response.tags == '#string'

    Scenario: Get articles
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].createdAt contains '2021'
        #each articles
        And match response.articles[*].author.bio contains null
        #bio can be anywhere inside articles
        And match response.articles[*]..bio contains null
        And match each response..following == false
        #Fuzzy mathcing
        And match each response..following == '#boolean'
        And match each response..favoritesCount == '#number'
        #bio type is either string or null
        And match each response..bio == '##string'
        #Fuzzy mathcing end
        #Schema Validation
        And match each response.articles == articleValidator

        #Articles feature file always adds new article so this asertion is not ok anymore
        #And match response == {"articles": "#array", "articlesCount": 5}
        #And match response.articles == '#[1]'
        #And match response.articlesCount == 1

    Scenario: Number to string
        * def foo = 10
        * def json = {"bar": #(foo + '')}
        * match json == {"bar": '10'}
        
    Scenario: String to number
        * def foo = '10'
        * def json = {"bar": #(foo*1)}
        #~~ converts double to number
        * def json2 = {"bar": #(~~parseInt(foo))}
        * match json == {"bar": 10}
        * match json2 == {"bar": 10}
    
    