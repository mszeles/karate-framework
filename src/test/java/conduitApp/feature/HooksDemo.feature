Feature: Hooks

Background:
#    * def result = callonce read('classpat:helpers/Dummy.feature')
#    * def username = result.username


   #after hooks

   # 'afterScenario' and 'afterFeature' only work in the "top-level" feature
   #  and are NOT supported in 'called' features
   # one limitation of afterScenario and afterFeature is that any feature steps involved will NOT appear
   # in the JSON report output and HTML reports
   * configure afterFeature = 
   """
       function() { 
           karate.log('After feature')
           //karate.call('classpat:helpers/Dummy.feature') 
        }
   """

    * configure afterScenario = 
    """
        function() { 
            karate.log('After scenario')
            //karate.call('classpat:helpers/Dummy.feature') 
         }
    """



Scenario:
    * print 'This is the first scenario'

Scenario: Second scenario
    * print 'This is the second scenario'