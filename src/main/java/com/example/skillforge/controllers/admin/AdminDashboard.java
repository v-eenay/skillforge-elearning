package com.example.skillforge.controllers.admin;

import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.services.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminDashboard", value = "/admin/dashboard")
public class AdminDashboard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get recent users (limit to 5)
        List<UserModel> recentUsers = AuthService.getRecentUsers(5);
        request.setAttribute("recentUsers", recentUsers);

        // Get total user count
        List<UserModel> allUsers = AuthService.getAllUsers();
        request.setAttribute("totalUsers", allUsers.size());

        // Forward to the dashboard view
        request.getRequestDispatcher("/WEB-INF/views/admin/admin-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}