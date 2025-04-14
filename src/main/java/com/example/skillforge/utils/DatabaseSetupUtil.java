package com.example.skillforge.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class for setting up the database and tables
 * This class checks if the database and tables exist and creates them if they don't
 */
public class DatabaseSetupUtil {
    private static final Logger LOGGER = Logger.getLogger(DatabaseSetupUtil.class.getName());
    private static String driver;
    private static String url;
    private static String username;
    private static String password;
    private static String dbName = "skillforge";

    static {
        try {
            // Try to load properties from different locations
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

            Class.forName(driver);
        } catch (IOException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Error loading database properties", e);
            throw new RuntimeException(e);
        }
    }

    /**
     * Find the properties file in different locations
     * @return InputStream for the properties file, or null if not found
     */
    private static InputStream findPropertiesFile() {
        InputStream in = null;

        // Try config directory first
        in = DatabaseSetupUtil.class.getClassLoader().getResourceAsStream("config/application.properties");
        if (in != null) {
            LOGGER.info("Using application.properties from config directory");
            return in;
        }

        // Try root resources directory
        in = DatabaseSetupUtil.class.getClassLoader().getResourceAsStream("application.properties");
        if (in != null) {
            LOGGER.info("Using application.properties from root resources directory");
            return in;
        }

        // Try template file
        in = DatabaseSetupUtil.class.getClassLoader().getResourceAsStream("config/application.properties.template");
        if (in != null) {
            LOGGER.info("Using application.properties.template from config directory");
            return in;
        }

        LOGGER.warning("Could not find application.properties in any location");
        return null;
    }

    /**
     * Initialize the database and tables
     * This method checks if the database exists and creates it if it doesn't
     * It also checks if all required tables exist and creates them if they don't
     * @return true if initialization was successful, false otherwise
     */
    public static boolean initializeDatabase() {
        try {
            LOGGER.info("Starting database initialization");

            // First check if database exists, create if it doesn't
            if (!databaseExists()) {
                createDatabase();
            }

            // Always check tables and create missing ones
            boolean tablesExist = tablesExist();
            if (!tablesExist) {
                LOGGER.info("Some tables are missing, creating tables");
                createTables();
            } else {
                LOGGER.info("All required tables already exist");
            }

            // Verify tables again after creation attempt
            if (!tablesExist()) {
                LOGGER.severe("Failed to create all required tables");
                return false;
            }

            LOGGER.info("Database initialization completed successfully");
            return true;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error initializing database", e);
            return false;
        }
    }

    /**
     * Check if the database exists
     * @return true if the database exists, false otherwise
     * @throws SQLException if there is an error checking the database
     */
    private static boolean databaseExists() throws SQLException {
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
        }
    }

    /**
     * Create the database
     * @throws SQLException if there is an error creating the database
     */
    private static void createDatabase() throws SQLException {
        try (Connection connection = DriverManager.getConnection(url, username, password);
             Statement statement = connection.createStatement()) {

            String sql = "CREATE DATABASE " + dbName;
            statement.executeUpdate(sql);
            LOGGER.info("Database '" + dbName + "' created successfully");
        }
    }

    /**
     * Check if all required tables exist
     * @return true if all tables exist, false otherwise
     * @throws SQLException if there is an error checking the tables
     */
    private static boolean tablesExist() throws SQLException {
        List<String> requiredTables = getRequiredTables();
        List<String> existingTables = getExistingTables();

        for (String table : requiredTables) {
            if (!existingTables.contains(table.toLowerCase())) {
                LOGGER.info("Table '" + table + "' does not exist");
                return false;
            }
        }

        LOGGER.info("All required tables exist");
        return true;
    }

    /**
     * Get a list of all required tables
     * @return a list of required table names
     */
    private static List<String> getRequiredTables() {
        List<String> tables = new ArrayList<>();
        tables.add("user"); // Core user entity
        tables.add("contact"); // Contact form submissions
        return tables;
    }

    /**
     * Get a list of all existing tables in the database
     * @return a list of existing table names
     * @throws SQLException if there is an error getting the tables
     */
    private static List<String> getExistingTables() throws SQLException {
        List<String> tables = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(url + "/" + dbName, username, password)) {
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet resultSet = metaData.getTables(null, null, "%", new String[]{"TABLE"});

            while (resultSet.next()) {
                tables.add(resultSet.getString("TABLE_NAME").toLowerCase());
            }
        }
        return tables;
    }

    /**
     * Create all tables using the schema.sql file
     * @throws SQLException if there is an error creating the tables
     */
    private static void createTables() throws SQLException {
        try (Connection connection = DriverManager.getConnection(url + "/" + dbName, username, password);
             Statement statement = connection.createStatement()) {

            // Read schema.sql file
            String schema = readSchemaFile();

            // Split the schema into individual statements
            String[] statements = schema.split(";");

            // Execute each statement
            for (String sql : statements) {
                sql = sql.trim();
                if (!sql.isEmpty()) {
                    try {
                        // Skip USE statement as we're already connected to the database
                        if (!sql.toLowerCase().startsWith("use ")) {
                            LOGGER.info("Executing SQL: " + sql);
                            statement.executeUpdate(sql);
                        }
                    } catch (SQLException e) {
                        // Log the error but continue with other statements
                        LOGGER.log(Level.WARNING, "Error executing SQL statement: " + sql, e);
                    }
                }
            }

            // Verify tables were created
            List<String> requiredTables = getRequiredTables();
            List<String> existingTables = getExistingTables();

            boolean allTablesCreated = true;
            for (String table : requiredTables) {
                if (!existingTables.contains(table.toLowerCase())) {
                    LOGGER.severe("Failed to create table '" + table + "'");
                    allTablesCreated = false;
                } else {
                    LOGGER.info("Table '" + table + "' exists");
                }
            }

            if (allTablesCreated) {
                LOGGER.info("All tables created successfully");
            } else {
                LOGGER.severe("Some tables were not created");
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading schema file", e);
            throw new SQLException("Error reading schema file", e);
        }
    }

    /**
     * Read the schema.sql file
     * @return the contents of the schema.sql file as a string
     * @throws IOException if there is an error reading the file
     */
    private static String readSchemaFile() throws IOException {
        StringBuilder schema = new StringBuilder();
        InputStream in = DatabaseSetupUtil.class.getClassLoader().getResourceAsStream("sql/schema.sql");

        // If schema.sql is not found in sql directory, try the root resources directory
        if (in == null) {
            in = DatabaseSetupUtil.class.getClassLoader().getResourceAsStream("schema.sql");
            if (in == null) {
                throw new IOException("Could not find schema.sql in either sql/ or root resources directory");
            } else {
                LOGGER.info("Using schema.sql from root resources directory");
            }
        } else {
            LOGGER.info("Using schema.sql from sql directory");
        }

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(in))) {

            String line;
            boolean inCommentBlock = false;

            while ((line = reader.readLine()) != null) {
                String trimmedLine = line.trim();

                // Skip empty lines
                if (trimmedLine.isEmpty()) {
                    continue;
                }

                // Check for comment block start
                if (trimmedLine.startsWith("/*")) {
                    inCommentBlock = true;
                    continue;
                }

                // Check for comment block end
                if (trimmedLine.endsWith("*/")) {
                    inCommentBlock = false;
                    continue;
                }

                // Skip lines in comment block or single-line comments
                if (inCommentBlock || trimmedLine.startsWith("--")) {
                    continue;
                }

                // Add valid SQL line
                schema.append(line).append("\n");
            }
        }
        return schema.toString();
    }

    /**
     * Main method for testing
     * @param args command line arguments
     */
    public static void main(String[] args) {
        boolean success = initializeDatabase();
        if (success) {
            System.out.println("Database initialization successful");
        } else {
            System.out.println("Database initialization failed");
        }
    }
}
