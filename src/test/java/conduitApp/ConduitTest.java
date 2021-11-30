package conduitApp;

import static org.junit.jupiter.api.Assertions.*;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
//import com.intuit.karate.junit5.Karate.Test;

import org.junit.jupiter.api.Test;

//@KarateOptions(tags = {"@debug"})
class ConduitTest {

    // @Test
    // Karate testAll() {
    //     return Karate.run().relativeTo(getClass());
    // }

    @Test
    public void testParallel() {
        Results results = Runner.path("classpath:conduitApp")
                .outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
