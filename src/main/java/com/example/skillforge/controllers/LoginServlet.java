package com.example.skillforge.controllers;
import com.example.skillforge.models.UserModel;
import com.example.skillforge.services.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/auth/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get login credentials from request
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate input
        if ((username == null && email == null) || password == null) {
            request.setAttribute("error", "Please provide valid credentials");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        try {
            // Authenticate user
            UserModel user = AuthService.loginUser(username, email, password);
            
            if (user != null) {
                // Authentication successful
                // Create session and store user information
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("userName", user.getUserName());
                session.setAttribute("userRole", user.getRole().toString());
                
                // Redirect based on user role
                switch (user.getRole()) {
                    case admin:
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                        break;
                    case instructor:
                        response.sendRedirect(request.getContextPath() + "/instructor/dashboard");
                        break;
                    case student:
                        response.sendRedirect(request.getContextPath() + "/student/dashboard");
                        break;
                    default:
                        response.sendRedirect(request.getContextPath() + "/");
                        break;
                }
            } else {
                // Authentication failed
                request.setAttribute("error", "Invalid username/email or password");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Handle exceptions
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}