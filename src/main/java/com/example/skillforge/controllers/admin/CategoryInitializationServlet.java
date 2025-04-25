package com.example.skillforge.controllers.admin;

import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.utils.CategoryInitializer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Logger;

/**
 * Servlet for initializing default categories
 * This servlet can be accessed by administrators to initialize default categories
 */
@WebServlet(name = "CategoryInitializationServlet", value = "/admin/initialize-categories")
public class CategoryInitializationServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CategoryInitializationServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        
        if (user == null || user.getRole() != UserModel.Role.admin) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Forward to the JSP page
        request.getRequestDispatcher("/WEB-INF/views/admin/initialize-categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        
        if (user == null || user.getRole() != UserModel.Role.admin) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        LOGGER.info("Starting category initialization process");
        
        try {
            // Initialize default categories
            CategoryInitializer.initializeDefaultCategories();
            
            // Set success message
            session.setAttribute("categoryInitMessage", "Default categories have been successfully initialized.");
            session.setAttribute("categoryInitSuccess", true);
        } catch (Exception e) {
            // Set error message
            session.setAttribute("categoryInitMessage", "Category initialization failed: " + e.getMessage());
            session.setAttribute("categoryInitSuccess", false);
            LOGGER.severe("Error initializing categories: " + e.getMessage());
        }
        
        // Redirect back to the page
        response.sendRedirect(request.getContextPath() + "/admin/initialize-categories");
    }
}
