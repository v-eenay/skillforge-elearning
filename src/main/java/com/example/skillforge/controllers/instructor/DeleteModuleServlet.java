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
 * Servlet for deleting a module
 */
@WebServlet(name = "DeleteModuleServlet", urlPatterns = {"/instructor/delete-module"})
public class DeleteModuleServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(DeleteModuleServlet.class.getName());

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
        String confirmParam = request.getParameter("confirm");
        
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
            
            // Check if confirmation is required
            if (!"true".equals(confirmParam)) {
                // Show confirmation page
                request.setAttribute("module", module);
                request.setAttribute("course", course);
                
                // For now, just redirect to course view since we don't have a confirmation page yet
                response.sendRedirect(request.getContextPath() + "/instructor/courses/view?id=" + course.getCourseId());
                return;
            }
            
            // Delete module
            boolean deleted = ModuleDAO.deleteModule(moduleId);
            
            if (deleted) {
                // Module deleted successfully
                session.setAttribute("success", "Module deleted successfully!");
            } else {
                // Module deletion failed
                session.setAttribute("error", "Failed to delete module. Please try again.");
            }
            
            // Redirect back to course view
            response.sendRedirect(request.getContextPath() + "/instructor/courses/view?id=" + course.getCourseId());
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid module ID: {0}", moduleIdParam);
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle POST requests the same way as GET
        doGet(request, response);
    }
}
