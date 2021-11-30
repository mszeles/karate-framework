package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.minidev.json.JSONObject;

public class DbHandler {
    private static String connectionUrl = "jdbc:mysql://localhost:3306/Pubs?user=root&password=password";

    public static void addNewJobWithName(String jobName) {
        try (Connection connect = DriverManager.getConnection(connectionUrl)) {
            connect.createStatement().execute("insert into Jobs (job_desc, min_lvl, max_lvl) values ('" + jobName + "', 10, 20)");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static JSONObject getMinAndMaxLevelsForJob(String jobName) {
        JSONObject json = new JSONObject();
        try (Connection connect = DriverManager.getConnection(connectionUrl)) {
            ResultSet rs = connect.createStatement().executeQuery("select * from Jobs where job_desc = '" + jobName + "'");
            rs.next();
            json.put("minLvl", rs.getString("min_lvl"));
            json.put("maxLvl", rs.getString("max_lvl"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return json;
    }
}
