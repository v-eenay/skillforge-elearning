package com.example.skillforge.controllers;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/auth/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String name = request.getParameter("name");
        String userName = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role"); // student or instructor
        String bio = request.getParameter("bio");
        
        // Validate form data
        if (name == null || userName == null || email == null || password == null || role == null) {
            request.setAttribute("error", "All required fields must be filled");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Default profile image (can be updated later by user)
        String profileImage = "/assets/images/default-profile.jpg";
        
        try {
            // Register the user
            int userId = com.example.skillforge.services.AuthService.registerUser(
                name, userName, email, password, role, profileImage, bio);
            
            if (userId > 0) {
                // Registration successful, redirect to login page
                response.sendRedirect(request.getContextPath() + "/auth/login");
            } else {
                // Registration failed
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Handle exceptions (e.g., duplicate username/email)
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}