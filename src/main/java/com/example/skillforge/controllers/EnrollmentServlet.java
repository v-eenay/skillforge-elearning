package com.example.skillforge.controllers;

import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.services.EnrollmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet for handling course enrollments
 */
@WebServlet("/enrollment/*")
public class EnrollmentServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        if (user == null) {
            // Redirect to login page
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        // Get path info
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List user's enrollments
            request.setAttribute("enrollments", EnrollmentService.getUserEnrollments(user.getUserId()));
            request.getRequestDispatcher("/WEB-INF/views/enrollment/my-courses.jsp").forward(request, response);
        } else if (pathInfo.equals("/enroll")) {
            // Handle enrollment
            String courseIdParam = request.getParameter("courseId");
            if (courseIdParam == null || courseIdParam.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }
            
            try {
                int courseId = Integer.parseInt(courseIdParam);
                
                // Check if user is already enrolled
                if (EnrollmentService.isUserEnrolled(user.getUserId(), courseId)) {
                    session.setAttribute("message", "You are already enrolled in this course.");
                } else {
                    // Enroll user in course
                    int enrollmentId = EnrollmentService.enrollUserInCourse(user.getUserId(), courseId);
                    if (enrollmentId > 0) {
                        session.setAttribute("message", "You have successfully enrolled in this course.");
                    } else {
                        session.setAttribute("error", "Failed to enroll in this course. Please try again.");
                    }
                }
                
                // Redirect back to course page
                response.sendRedirect(request.getContextPath() + "/courses/view?id=" + courseId);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/courses");
            }
        } else if (pathInfo.equals("/unenroll")) {
            // Handle unenrollment
            String courseIdParam = request.getParameter("courseId");
            if (courseIdParam == null || courseIdParam.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/enrollment");
                return;
            }
            
            try {
                int courseId = Integer.parseInt(courseIdParam);
                
                // Check if user is enrolled
                if (!EnrollmentService.isUserEnrolled(user.getUserId(), courseId)) {
                    session.setAttribute("error", "You are not enrolled in this course.");
                } else {
                    // Unenroll user from course
                    boolean success = EnrollmentService.unenrollUserFromCourse(user.getUserId(), courseId);
                    if (success) {
                        session.setAttribute("message", "You have successfully unenrolled from this course.");
                    } else {
                        session.setAttribute("error", "Failed to unenroll from this course. Please try again.");
                    }
                }
                
                // Redirect back to enrollments page
                response.sendRedirect(request.getContextPath() + "/enrollment");
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/enrollment");
            }
        } else {
            // Handle 404
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
