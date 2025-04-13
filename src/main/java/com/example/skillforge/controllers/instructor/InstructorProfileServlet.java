package com.example.skillforge.controllers.instructor;

import com.example.skillforge.models.UserModel;
import com.example.skillforge.services.AuthService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "InstructorProfileServlet", value = "/instructor/profile")
public class InstructorProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        
        if (user != null) {
            // Get the latest user data from the database
            UserModel updatedUser = AuthService.getUserById(user.getUserId());
            if (updatedUser != null) {
                request.setAttribute("userProfile", updatedUser);
            } else {
                request.setAttribute("userProfile", user);
            }
        }
        
        request.getRequestDispatcher("/WEB-INF/views/instructor/instructor-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        
        if (user != null) {
            // Get form data
            String name = request.getParameter("name");
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String profileImage = request.getParameter("profileImage");
            String bio = request.getParameter("bio");
            
            // Update user model
            user.setName(name);
            user.setUserName(userName);
            user.setEmail(email);
            user.setProfileImage(profileImage);
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
            
            request.setAttribute("userProfile", user);
        }
        
        request.getRequestDispatcher("/WEB-INF/views/instructor/instructor-profile.jsp").forward(request, response);
    }
}
