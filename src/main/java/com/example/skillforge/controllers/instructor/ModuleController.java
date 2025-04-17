package com.example.skillforge.controllers.instructor;

import com.example.skillforge.dao.course.CourseDAO;
import com.example.skillforge.dao.course.ModuleDAO;
import com.example.skillforge.models.course.CourseModel;
import com.example.skillforge.models.course.ModuleModel;
import com.example.skillforge.models.user.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Controller for handling module-related operations
 */
@WebServlet(name = "ModuleController", urlPatterns = {"/instructor/module/*"})
public class ModuleController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ModuleController.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        // Check if user is logged in and is an instructor
        if (user == null || !user.getRole().equals("instructor")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }

        if (pathInfo.equals("/add")) {
            // Show add module form
            String courseIdParam = request.getParameter("courseId");
            if (courseIdParam == null || courseIdParam.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }

            try {
                int courseId = Integer.parseInt(courseIdParam);
                CourseModel course = CourseDAO.getCourseById(courseId);

                // Check if course exists and belongs to the current instructor
                if (course == null || course.getCreatedBy() != user.getUserId()) {
                    response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                    return;
                }

                // Get existing modules for the course
                List<ModuleModel> modules = ModuleDAO.getModulesByCourse(courseId);

                // Calculate next order index
                int nextOrderIndex = modules.size() + 1;

                request.setAttribute("course", course);
                request.setAttribute("modules", modules);
                request.setAttribute("nextOrderIndex", nextOrderIndex);

                request.getRequestDispatcher("/WEB-INF/views/instructor/add-module.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                LOGGER.log(Level.WARNING, "Invalid course ID: {0}", courseIdParam);
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
            }
        } else {
            // Default: redirect to courses
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // This is just a placeholder for the actual implementation
        // For now, we'll just redirect back to the course view page

        String courseIdParam = request.getParameter("courseId");
        if (courseIdParam != null && !courseIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses/view?id=" + courseIdParam);
        } else {
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
        }
    }
}
