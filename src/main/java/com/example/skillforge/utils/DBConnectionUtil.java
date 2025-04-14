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
        try(InputStream in = DBConnectionUtil.class.getClassLoader().getResourceAsStream("application.properties")) {
            Properties prop = new Properties();
            prop.load(in);
            driver = prop.getProperty("db.driver");
            url = prop.getProperty("db.url");
            username = prop.getProperty("db.username");
            password = prop.getProperty("db.password");
            Class.forName(driver);

            // Initialize database on first load
            initializeDatabase();
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
        // Ensure database is initialized before returning connection
        if (!initialized) {
            initializeDatabase();
        }
        return DriverManager.getConnection(url, username, password);
    }

    /**
     * Initialize the database and tables
     */
    private static void initializeDatabase() {
        if (!initialized) {
            try {
                // Initialize database using DatabaseSetupUtil
                boolean success = DatabaseSetupUtil.initializeDatabase();
                if (success) {
                    LOGGER.info("Database initialized successfully");
                    initialized = true;
                } else {
                    LOGGER.warning("Database initialization failed");
                }
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error initializing database", e);
            }
        }
    }

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
