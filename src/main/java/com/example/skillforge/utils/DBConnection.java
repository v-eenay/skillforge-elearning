package com.example.skillforge.utils;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    private static String url;
    private static String user;
    private static String password;

    static {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("application.properties")) {
                Properties prop = new Properties();
                prop.load(input);
                url = prop.getProperty("db.url");
                user = prop.getProperty("db.username");
                password = prop.getProperty("db.password");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url,user,password);
    }
}
