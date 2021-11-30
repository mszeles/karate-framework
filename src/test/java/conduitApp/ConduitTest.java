package conduitApp;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

//@KarateOptions(tags = {"@debug"})
class ConduitTest {

    @Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }

}
