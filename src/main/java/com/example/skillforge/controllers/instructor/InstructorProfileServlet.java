package com.example.skillforge.controllers.instructor;

import com.example.skillforge.models.UserModel;
import com.example.skillforge.services.AuthService;
import com.example.skillforge.utils.FileUploadUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "InstructorProfileServlet", urlPatterns = {"/instructor/profile", "/instructor/profile/edit"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 50)   // 50 MB
public class InstructorProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        String requestURI = request.getRequestURI();

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
            request.getRequestDispatcher("/WEB-INF/views/instructor/instructor-profile.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/instructor/instructor-profile-view.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user != null) {
            try {
                // Get form data
                String name = request.getParameter("name");
                String userName = request.getParameter("userName");
                String email = request.getParameter("email");
                String bio = request.getParameter("bio");

                // Handle profile image upload
                String profileImagePath = FileUploadUtil.uploadProfileImage(request, "profileImage");

                // If a new image was uploaded, update the profile image path
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
                    request.setAttribute("success", "Profile updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update profile. Please try again.");
                }
            } catch (Exception e) {
                request.setAttribute("error", "An error occurred: " + e.getMessage());
                e.printStackTrace();
            }

            request.setAttribute("userProfile", user);
        } else {
            request.setAttribute("error", "You must be logged in to update your profile.");
        }

        // After successful update, redirect to the view profile page
        response.sendRedirect(request.getContextPath() + "/instructor/profile");
    }
}
