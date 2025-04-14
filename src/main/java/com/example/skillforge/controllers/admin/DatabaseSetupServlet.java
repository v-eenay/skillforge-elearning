package com.example.skillforge.controllers.admin;

import com.example.skillforge.utils.DatabaseSetupUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Logger;

/**
 * Servlet for initializing the database
 * This servlet can be accessed by administrators to initialize the database and tables
 */
@WebServlet(name = "DatabaseSetupServlet", value = "/admin/setup-database")
public class DatabaseSetupServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(DatabaseSetupServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Add database information to the request
        request.setAttribute("dbName", DatabaseSetupUtil.getDbName());
        request.setAttribute("dbUrl", DatabaseSetupUtil.getUrl());
        request.setAttribute("dbUsername", DatabaseSetupUtil.getUsername());

        // Check if there's a message from a previous operation
        String message = (String) request.getSession().getAttribute("dbSetupMessage");
        Boolean success = (Boolean) request.getSession().getAttribute("dbSetupSuccess");

        if (message != null) {
            request.setAttribute("message", message);
            request.setAttribute("success", success);
            // Clear the session attributes
            request.getSession().removeAttribute("dbSetupMessage");
            request.getSession().removeAttribute("dbSetupSuccess");
        }

        // Forward to the JSP page
        request.getRequestDispatcher("/WEB-INF/views/admin/database-setup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Starting database initialization process");

        boolean success = DatabaseSetupUtil.initializeDatabase();
        String message;

        if (success) {
            message = "Database and tables have been successfully initialized. The system is ready to use.";
            LOGGER.info(message);
        } else {
            message = "Database initialization failed. Please check the server logs for more details.";
            LOGGER.warning(message);
        }

        // Set attributes for the result page
        request.setAttribute("success", success);
        request.setAttribute("message", message);

        // Forward to the result JSP page
        request.getRequestDispatcher("/WEB-INF/views/admin/database-setup-result.jsp").forward(request, response);
    }
}
