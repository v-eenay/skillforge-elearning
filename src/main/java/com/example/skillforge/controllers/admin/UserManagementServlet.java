package com.example.skillforge.controllers.admin;

import com.example.skillforge.models.UserModel;
import com.example.skillforge.services.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserManagementServlet", value = "/admin/users")
public class UserManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check for any messages in the session and transfer them to request attributes
        transferSessionMessagesToRequest(request);

        String action = request.getParameter("action");

        if ("view".equals(action)) {
            // View a specific user's profile
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                UserModel user = AuthService.getUserById(userId);

                if (user != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/WEB-INF/views/admin/user-profile-view.jsp").forward(request, response);
                    return;
                } else {
                    request.setAttribute("error", "User not found.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid user ID.");
            }
        }

        // Default: show all users
        List<UserModel> users = AuthService.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/views/admin/user-management.jsp").forward(request, response);
    }

    /**
     * Helper method to transfer session messages to request attributes
     * @param request The HTTP request
     */
    private void transferSessionMessagesToRequest(HttpServletRequest request) {
        HttpSession session = request.getSession();

        // Transfer success message if present
        if (session.getAttribute("success") != null) {
            request.setAttribute("success", session.getAttribute("success"));
            session.removeAttribute("success");
        }

        // Transfer error message if present
        if (session.getAttribute("error") != null) {
            request.setAttribute("error", session.getAttribute("error"));
            session.removeAttribute("error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("userId"));
        String returnTo = request.getParameter("returnTo"); // Optional parameter to determine where to redirect

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

        // Store message in session for redirect
        if (success) {
            request.getSession().setAttribute("success", message);
        } else {
            request.getSession().setAttribute("error", message);
        }

        // If it's a delete action or the returnTo parameter is not "profile", redirect to the user list
        if ("delete".equals(action) || !"profile".equals(returnTo)) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } else {
            // For other actions when viewing a profile, redirect back to the user profile
            response.sendRedirect(request.getContextPath() + "/admin/users?action=view&userId=" + userId);
        }
    }
}
