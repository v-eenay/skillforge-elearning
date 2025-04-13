package com.example.skillforge.controllers.admin;

import com.example.skillforge.models.UserModel;
import com.example.skillforge.services.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserManagementServlet", value = "/admin/users")
public class UserManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get all users
        List<UserModel> users = AuthService.getAllUsers();
        request.setAttribute("users", users);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/user-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("userId"));
        
        boolean success = false;
        String message = "";
        
        if ("suspend".equals(action)) {
            success = AuthService.updateUserStatus(userId, UserModel.Status.suspended);
            message = success ? "User suspended successfully." : "Failed to suspend user.";
        } else if ("activate".equals(action)) {
            success = AuthService.updateUserStatus(userId, UserModel.Status.active);
            message = success ? "User activated successfully." : "Failed to activate user.";
        } else if ("delete".equals(action)) {
            success = AuthService.deleteUser(userId);
            message = success ? "User deleted successfully." : "Failed to delete user.";
        }
        
        if (success) {
            request.setAttribute("success", message);
        } else {
            request.setAttribute("error", message);
        }
        
        // Get updated user list
        List<UserModel> users = AuthService.getAllUsers();
        request.setAttribute("users", users);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/user-management.jsp").forward(request, response);
    }
}
