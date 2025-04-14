package com.example.skillforge.listeners;

import com.example.skillforge.utils.DatabaseSetupUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet context listener that initializes the database when the server starts
 */
@WebListener
public class DatabaseInitializationListener implements ServletContextListener {
    private static final Logger LOGGER = Logger.getLogger(DatabaseInitializationListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.info("Server starting up - checking database and tables...");
        try {
            boolean success = DatabaseSetupUtil.initializeDatabase();
            if (success) {
                LOGGER.info("Database and tables initialized successfully");
            } else {
                LOGGER.severe("Failed to initialize database and tables");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error initializing database and tables", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nothing to do when the context is destroyed
    }
}
