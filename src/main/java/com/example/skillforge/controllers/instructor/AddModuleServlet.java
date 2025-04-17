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
 * Servlet for adding a new module to a course
 */
@WebServlet(name = "AddModuleServlet", urlPatterns = {"/instructor/add-module"})
public class AddModuleServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AddModuleServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        // Check if user is logged in and is an instructor
        if (user == null || !user.getRole().equals(UserModel.Role.instructor)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // Get course ID from request parameter
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
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        // Check if user is logged in and is an instructor
        if (user == null || !user.getRole().equals(UserModel.Role.instructor)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // Get form data
        String courseIdParam = request.getParameter("courseId");
        String title = request.getParameter("title");
        String orderIndexParam = request.getParameter("orderIndex");
        String afterAction = request.getParameter("afterAction");

        // Validate required fields
        if (courseIdParam == null || courseIdParam.isEmpty() || title == null || title.trim().isEmpty()) {
            request.setAttribute("error", "Course ID and module title are required.");
            doGet(request, response);
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

            // Create new module
            ModuleModel module = new ModuleModel();
            module.setCourseId(courseId);
            module.setTitle(title);

            // Set order index if provided
            if (orderIndexParam != null && !orderIndexParam.isEmpty()) {
                try {
                    int orderIndex = Integer.parseInt(orderIndexParam);
                    module.setOrderIndex(orderIndex);
                } catch (NumberFormatException e) {
                    // Use default order index (end of list)
                    List<ModuleModel> modules = ModuleDAO.getModulesByCourse(courseId);
                    module.setOrderIndex(modules.size() + 1);
                }
            } else {
                // Use default order index (end of list)
                List<ModuleModel> modules = ModuleDAO.getModulesByCourse(courseId);
                module.setOrderIndex(modules.size() + 1);
            }

            try {
                // Insert module
                LOGGER.info("Inserting module: " + module.getTitle() + " for course ID: " + module.getCourseId() + " with order index: " + module.getOrderIndex());
                int moduleId = ModuleDAO.insertModule(module);

                if (moduleId > 0) {
                    // Module created successfully
                    LOGGER.info("Module created successfully with ID: " + moduleId);
                    module.setModuleId(moduleId);
                    session.setAttribute("success", "Module '" + module.getTitle() + "' created successfully!");

                    // Handle after action
                    if ("addLesson".equals(afterAction)) {
                        // Redirect to add lesson page
                        response.sendRedirect(request.getContextPath() + "/instructor/add-lesson?moduleId=" + moduleId);
                    } else if ("addAnother".equals(afterAction)) {
                        // Redirect back to add module page
                        response.sendRedirect(request.getContextPath() + "/instructor/add-module?courseId=" + courseId);
                    } else {
                        // Default: return to course view
                        response.sendRedirect(request.getContextPath() + "/instructor/courses/view?id=" + courseId);
                    }
                } else {
                    // Module creation failed
                    LOGGER.warning("Failed to create module. ModuleDAO.insertModule returned 0.");
                    request.setAttribute("error", "Failed to create module. Please try again.");
                    doGet(request, response);
                }
            } catch (Exception e) {
                // Log the exception
                LOGGER.log(Level.SEVERE, "Exception while creating module", e);
                request.setAttribute("error", "An error occurred while creating the module: " + e.getMessage());
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid course ID: {0}", courseIdParam);
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
        }
    }
}
