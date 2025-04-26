package com.example.skillforge.controllers.admin;

import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.services.AuthService;
import com.example.skillforge.utils.FileUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
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
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get the latest user data from the database
        UserModel updatedUser = AuthService.getUserById(user.getUserId());
        if (updatedUser != null) {
            request.setAttribute("userProfile", updatedUser);
        } else {
            request.setAttribute("userProfile", user);
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
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get form data
            String name = request.getParameter("name");
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String bio = request.getParameter("bio");

            // Handle profile image upload
            String profileImagePath = FileUploadUtil.uploadProfileImage(request, "profileImage");
            if (profileImagePath != null && !profileImagePath.isEmpty()) {
                // Delete old profile image if it exists and is not the default
                if (user.getProfileImage() != null && !user.getProfileImage().isEmpty()
                        && !user.getProfileImage().contains("default-profile")) {
                    FileUploadUtil.deleteProfileImage(request, user.getProfileImage());
                }
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

        // Redirect back to profile page
        response.sendRedirect(request.getContextPath() + "/admin/profile/edit");
    }
}
