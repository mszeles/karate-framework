package conduitApp.performance.createTokens;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import com.intuit.karate.Runner;

public class CreateTokens {
    private static final List<String> tokens = new ArrayList<>();
    private static final AtomicInteger counter = new AtomicInteger();
    private static String[] emails = {
        "karatedemo1@test.hu",
        "karatedemo2@test.hu",
        "karatedemo3@test.hu"
    };

    public static String getNextToken() {
        return tokens.get(counter.getAndIncrement() % tokens.size());
    }

    public static void createAccessTokens() {
        Map<String, Object> account = new HashMap<>();
        for (String email : emails) {
            account.put("userEmail", email);
            account.put("userPassword", "password");
            Map<String, Object> result = Runner.runFeature("classpath:helpers/CreateToken.feature", account, true);
            tokens.add(result.get("authToken").toString());
        }
    }
}
