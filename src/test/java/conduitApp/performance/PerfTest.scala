package conduitApp.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

    val protocol = karateProtocol()

    //protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
    //protocol.runner.karateEnv("perf")

    val create = scenario("Create and delete article").exec(karateFeature("classpath:conduitApp/performance/data/CreateArticle.feature"))

    setUp(
        create.inject(
            atOnceUsers(5)
        ).protocols(protocol),
    )

}