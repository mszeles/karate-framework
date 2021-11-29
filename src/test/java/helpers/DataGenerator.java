package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class DataGenerator {
    private static Faker faker = new Faker();
    
    public static String getRandomEmail() {
        return faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.hu";
    }

    public static String getRandomUsername() {
        return faker.name().lastName().toLowerCase();
    }

    public String nonStaticExample() {
        return faker.name().firstName();
    }

    public static JSONObject getRandomArticleValues() {
        String title = faker.gameOfThrones().character();
        String description = faker.gameOfThrones().city();
        String body = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("description", description);
        json.put("body", body);
        return json;
    }
}
