package conduitApp.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

    val protocol = karateProtocol(
        //Merging the DELETE calls in the report
        "/api/articles/{articleId}" -> Nil
    )

    //protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
    //protocol.runner.karateEnv("perf")

    val csvFeeder = csv("articles.csv").circular
    val create = scenario("Create and delete article").feed(csvFeeder).exec(karateFeature("classpath:conduitApp/performance/data/CreateArticle.feature"))

    setUp(
        create.inject(
            atOnceUsers(1),
            nothingFor(4 seconds),
            constantUsersPerSec(1) during (10 seconds),
            constantUsersPerSec(2) during (10 seconds),
            rampUsersPerSec(2) to 10 during (20 seconds),
            nothingFor(5 seconds),
            constantUsersPerSec(1) during (5 seconds)
            // nothingFor(2 seconds),  //Pause for a given duration.
            // atOnceUsers(5), //Injects a given number of users at once.
            // rampUsers(10) during (5 seconds), //Injects a given number of users distributed evenly on a time window of a given duration.
            // constantUsersPerSec(20) during (15 seconds), //Injects users at a constant rate, defined in users per second, during a given duration. Users will be injected at regular intervals.
            // constantUsersPerSec(20) during (15 seconds) randomized, //Injects users at a constant rate, defined in users per second, during a given duration. Users will be injected at randomized intervals.
            // rampUsersPerSec(10) to 20 during (10 minutes),  //Injects users from starting rate to target rate, defined in users per second, during a given duration. Users will be injected at regular intervals.
            // rampUsersPerSec(10) to 20 during (10 minutes) randomized, //Injects users from starting rate to target rate, defined in users per second, during a given duration. Users will be injected at randomized intervals.

        ).protocols(protocol),
    )

}