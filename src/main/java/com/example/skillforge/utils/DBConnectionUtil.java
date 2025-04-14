package com.example.skillforge.utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class for database connections
 * This class provides methods for getting database connections
 */
public class DBConnectionUtil {
    private static final Logger LOGGER = Logger.getLogger(DBConnectionUtil.class.getName());
    private static String driver;
    private static String url;
    private static String username;
    private static String password;
    private static boolean initialized = false;

    static {
        try {
            InputStream in = DBConnectionUtil.class.getClassLoader().getResourceAsStream("config/application.properties");

            // If application.properties is not found in config directory, try the root resources directory
            if (in == null) {
                in = DBConnectionUtil.class.getClassLoader().getResourceAsStream("application.properties");
                if (in == null) {
                    throw new IOException("Could not find application.properties in either config/ or root resources directory");
                } else {
                    LOGGER.info("Using application.properties from root resources directory");
                }
            } else {
                LOGGER.info("Using application.properties from config directory");
            }

            Properties prop = new Properties();
            prop.load(in);
            in.close();

            driver = prop.getProperty("db.driver");
            url = prop.getProperty("db.url");
            username = prop.getProperty("db.username");
            password = prop.getProperty("db.password");
            Class.forName(driver);

            // Database initialization is now handled by DatabaseInitializationListener
            initialized = true;
        } catch (IOException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error loading database properties", e);
            throw new RuntimeException(e);
        }
    }

    /**
     * Get a database connection
     * @return a connection to the database
     * @throws SQLException if there is an error getting the connection
     */
    public static Connection getConnection() throws SQLException {
        // Database initialization is now handled by DatabaseInitializationListener
        return DriverManager.getConnection(url, username, password);
    }

    // Database initialization is now handled by DatabaseInitializationListener

    /**
     * Main method for testing
     * @param args command line arguments
     */
    public static void main(String[] args) {
        System.out.println("Driver: " + driver);
        System.out.println("URL: " + url);
        System.out.println("Username: " + username);
        System.out.println("Password: " + (password != null ? "[HIDDEN]" : "null"));
        System.out.println("Database initialized: " + initialized);

        try {
            Connection connection = getConnection();
            System.out.println("Connection successful: " + !connection.isClosed());
            connection.close();
        } catch (SQLException e) {
            System.err.println("Connection failed: " + e.getMessage());
        }
    }
}
