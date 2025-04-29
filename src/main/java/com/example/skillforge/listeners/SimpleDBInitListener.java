package com.example.skillforge.listeners;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * A simplified database initialization listener that doesn't rely on other utility classes
 */
@WebListener
public class SimpleDBInitListener implements ServletContextListener {
    private static final Logger LOGGER = Logger.getLogger(SimpleDBInitListener.class.getName());
    private String driver;
    private String url;
    private String username;
    private String password;
    private String dbName = "skillforge";

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.info("Server starting up - initializing database connection...");
        try {
            // Load database properties
            loadDatabaseProperties();

            // Check if database exists, create if it doesn't
            if (!databaseExists()) {
                createDatabase();
            }

            LOGGER.info("Database initialization completed successfully");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error initializing database, but continuing startup", e);
            // Don't rethrow the exception - we want the application to start even if database initialization fails
        }
        LOGGER.info("Database initialization process completed");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nothing to do when the context is destroyed
    }

    /**
     * Load database properties from application.properties file
     */
    private void loadDatabaseProperties() throws IOException, ClassNotFoundException {
        InputStream in = findPropertiesFile();

        if (in != null) {
            Properties prop = new Properties();
            prop.load(in);
            in.close();

            driver = prop.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");

            // Extract base URL without database name
            String fullUrl = prop.getProperty("db.url", "jdbc:mysql://localhost:3306/skillforge");
            int dbNameIndex = fullUrl.lastIndexOf("/");
            if (dbNameIndex > 0 && dbNameIndex < fullUrl.length() - 1) {
                url = fullUrl.substring(0, dbNameIndex);
                dbName = fullUrl.substring(dbNameIndex + 1);

                // Remove any parameters from dbName
                int paramIndex = dbName.indexOf("?");
                if (paramIndex > 0) {
                    dbName = dbName.substring(0, paramIndex);
                }
            } else {
                url = "jdbc:mysql://localhost:3306";
            }

            username = prop.getProperty("db.username", "root");
            password = prop.getProperty("db.password", "");
        } else {
            // Use default values if properties file not found
            LOGGER.warning("No properties file found. Using default database settings.");
            driver = "com.mysql.cj.jdbc.Driver";
            url = "jdbc:mysql://localhost:3306";
            dbName = "skillforge";
            username = "root";
            password = "";
        }

        // Load the JDBC driver
        Class.forName(driver);
        LOGGER.info("Database driver loaded: " + driver);
    }

    /**
     * Find the properties file in different locations
     * @return InputStream for the properties file, or null if not found
     */
    private InputStream findPropertiesFile() {
        InputStream in = null;

        // Try all possible locations for the properties file
        String[] possiblePaths = {
            "config/application.properties",
            "application.properties",
            "/config/application.properties",
            "/application.properties",
            "WEB-INF/classes/config/application.properties",
            "WEB-INF/classes/application.properties",
            "config/application.properties.template"
        };

        ClassLoader classLoader = getClass().getClassLoader();
        for (String path : possiblePaths) {
            in = classLoader.getResourceAsStream(path);
            if (in != null) {
                LOGGER.info("Found application.properties at: " + path);
                return in;
            }
        }

        // If still not found, try absolute path
        try {
            String configPath = System.getProperty("catalina.base") + "/webapps/skillforge_war_exploded/WEB-INF/classes/config/application.properties";
            LOGGER.info("Trying absolute path: " + configPath);
            java.io.File file = new java.io.File(configPath);
            if (file.exists()) {
                in = new java.io.FileInputStream(file);
                LOGGER.info("Found application.properties at absolute path: " + configPath);
                return in;
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error trying absolute path", e);
        }

        LOGGER.warning("Could not find application.properties in any location");
        return null;
    }

    /**
     * Check if the database exists
     * @return true if the database exists, false otherwise
     */
    private boolean databaseExists() {
        try (Connection connection = DriverManager.getConnection(url, username, password);
             ResultSet resultSet = connection.getMetaData().getCatalogs()) {

            while (resultSet.next()) {
                String databaseName = resultSet.getString(1);
                if (databaseName.equalsIgnoreCase(dbName)) {
                    LOGGER.info("Database '" + dbName + "' already exists");
                    return true;
                }
            }

            LOGGER.info("Database '" + dbName + "' does not exist");
            return false;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking if database exists", e);
            return false;
        }
    }

    /**
     * Create the database
     */
    private void createDatabase() {
        try (Connection connection = DriverManager.getConnection(url, username, password);
             Statement statement = connection.createStatement()) {

            String sql = "CREATE DATABASE " + dbName;
            statement.executeUpdate(sql);
            LOGGER.info("Database '" + dbName + "' created successfully");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating database", e);
        }
    }
}
