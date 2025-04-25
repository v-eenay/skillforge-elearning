package com.example.skillforge.listeners;

import com.example.skillforge.utils.CategoryInitializer;
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
            // Initialize static fields in DatabaseSetupUtil
            Class.forName("com.example.skillforge.utils.DatabaseSetupUtil");

            // Initialize database
            boolean success = DatabaseSetupUtil.initializeDatabase();
            if (success) {
                LOGGER.info("Database and tables initialized successfully");

                // Initialize default categories
                try {
                    CategoryInitializer.initializeDefaultCategories();
                    LOGGER.info("Default categories initialized successfully");
                } catch (Exception e) {
                    LOGGER.log(Level.WARNING, "Error initializing default categories, but continuing startup", e);
                }
            } else {
                LOGGER.warning("Failed to initialize database and tables, but continuing startup");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error initializing database and tables, but continuing startup", e);
            // Don't rethrow the exception - we want the application to start even if database initialization fails
        }
        LOGGER.info("Database initialization process completed");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nothing to do when the context is destroyed
    }
}
