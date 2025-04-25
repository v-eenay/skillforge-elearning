package com.example.skillforge.controllers.admin;

import com.example.skillforge.models.UserModel;
import com.example.skillforge.services.AuthService;
import com.example.skillforge.utils.FileUploadUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet for handling admin profile
 */
@WebServlet(name = "AdminProfileServlet", urlPatterns = {"/admin/profile", "/admin/profile/edit"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10,  // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class AdminProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        String requestURI = request.getRequestURI();

        // Check if user is logged in and is an admin
        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (user != null) {
            // Get the latest user data from the database
            UserModel updatedUser = AuthService.getUserById(user.getUserId());
            if (updatedUser != null) {
                request.setAttribute("userProfile", updatedUser);
            } else {
                request.setAttribute("userProfile", user);
            }
        }

        // Determine which page to show based on the URL
        if (requestURI.contains("/profile/edit")) {
            request.getRequestDispatcher("/WEB-INF/views/admin/admin-profile.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/admin/admin-profile-view.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        // Check if user is logged in and is an admin
        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (user != null) {
            try {
                // Get form data
                String name = request.getParameter("name");
                String userName = request.getParameter("userName");
                String email = request.getParameter("email");
                String bio = request.getParameter("bio");

                // Handle profile image upload
                String profileImagePath = FileUploadUtil.uploadProfileImage(request, "profileImage");
                if (profileImagePath != null && !profileImagePath.isEmpty()) {
                    user.setProfileImage(profileImagePath);
                }

                // Update user model
                user.setName(name);
                user.setUserName(userName);
                user.setEmail(email);
                user.setBio(bio);

                // Update in database
                boolean updated = AuthService.updateUserProfile(user);

                if (updated) {
                    // Update session
                    session.setAttribute("user", user);
                    session.setAttribute("message", "Profile updated successfully!");
                } else {
                    session.setAttribute("error", "Failed to update profile. Please try again.");
                }
            } catch (Exception e) {
                session.setAttribute("error", "An error occurred: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            session.setAttribute("error", "You must be logged in to update your profile.");
        }

        // Redirect back to profile page
        response.sendRedirect(request.getContextPath() + "/admin/profile/edit");
    }
}
