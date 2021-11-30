@ignore
Feature: work with DB
Background: connect to db
    * def dbHandler = Java.type('helpers.DbHandler')

Scenario: Seed database with a new job
    * eval dbHandler.addNewJobWithName("QA")

Scenario: Get level for job
    * def level = dbHandler.getMinAndMaxLevelsForJob("QA")
    * print level
    And match level.minLvl == '10'
    And match level.maxLvl == '20'
