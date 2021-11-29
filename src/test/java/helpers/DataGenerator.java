package helpers;

import com.github.javafaker.Faker;

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
}
