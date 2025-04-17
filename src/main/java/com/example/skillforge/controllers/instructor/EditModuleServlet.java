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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for editing an existing module
 */
@WebServlet(name = "EditModuleServlet", urlPatterns = {"/instructor/edit-module"})
public class EditModuleServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(EditModuleServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        
        // Check if user is logged in and is an instructor
        if (user == null || !user.getRole().equals(UserModel.Role.instructor)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        // Get module ID from request parameter
        String moduleIdParam = request.getParameter("id");
        if (moduleIdParam == null || moduleIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
            return;
        }
        
        try {
            int moduleId = Integer.parseInt(moduleIdParam);
            ModuleModel module = ModuleDAO.getModuleById(moduleId);
            
            if (module == null) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }
            
            // Get the course to check ownership
            CourseModel course = CourseDAO.getCourseById(module.getCourseId());
            
            // Check if course exists and belongs to the current instructor
            if (course == null || course.getCreatedBy() != user.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }
            
            request.setAttribute("module", module);
            request.setAttribute("course", course);
            
            // For now, just redirect to course view since we don't have an edit module page yet
            response.sendRedirect(request.getContextPath() + "/instructor/courses/view?id=" + course.getCourseId());
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid module ID: {0}", moduleIdParam);
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
        String moduleIdParam = request.getParameter("moduleId");
        String title = request.getParameter("title");
        String orderIndexParam = request.getParameter("orderIndex");
        
        // Validate required fields
        if (moduleIdParam == null || moduleIdParam.isEmpty() || title == null || title.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
            return;
        }
        
        try {
            int moduleId = Integer.parseInt(moduleIdParam);
            ModuleModel module = ModuleDAO.getModuleById(moduleId);
            
            if (module == null) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }
            
            // Get the course to check ownership
            CourseModel course = CourseDAO.getCourseById(module.getCourseId());
            
            // Check if course exists and belongs to the current instructor
            if (course == null || course.getCreatedBy() != user.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }
            
            // Update module
            module.setTitle(title);
            
            // Set order index if provided
            if (orderIndexParam != null && !orderIndexParam.isEmpty()) {
                try {
                    int orderIndex = Integer.parseInt(orderIndexParam);
                    module.setOrderIndex(orderIndex);
                } catch (NumberFormatException e) {
                    // Keep existing order index
                }
            }
            
            // Update module
            boolean updated = ModuleDAO.updateModule(module);
            
            if (updated) {
                // Module updated successfully
                session.setAttribute("success", "Module updated successfully!");
            } else {
                // Module update failed
                session.setAttribute("error", "Failed to update module. Please try again.");
            }
            
            // Redirect back to course view
            response.sendRedirect(request.getContextPath() + "/instructor/courses/view?id=" + course.getCourseId());
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid module ID: {0}", moduleIdParam);
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
        }
    }
}
