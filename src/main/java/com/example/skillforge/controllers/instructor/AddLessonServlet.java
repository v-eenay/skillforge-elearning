package com.example.skillforge.controllers.instructor;

import com.example.skillforge.dao.content.LessonDAO;
import com.example.skillforge.dao.course.CourseDAO;
import com.example.skillforge.dao.course.ModuleDAO;
import com.example.skillforge.models.content.LessonModel;
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
 * Servlet for adding a new lesson to a module
 */
@WebServlet(name = "AddLessonServlet", urlPatterns = {"/instructor/add-lesson"})
public class AddLessonServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AddLessonServlet.class.getName());

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
        String moduleIdParam = request.getParameter("moduleId");
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
            
            // Get existing lessons for the module
            module.setLessons(LessonDAO.getLessonsByModule(moduleId));
            
            request.getRequestDispatcher("/WEB-INF/views/instructor/add-lesson.jsp").forward(request, response);
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
        String content = request.getParameter("content");
        String durationParam = request.getParameter("duration");
        String resourceLink = request.getParameter("resourceLink");
        String afterAction = request.getParameter("afterAction");
        
        // Validate required fields
        if (moduleIdParam == null || moduleIdParam.isEmpty() || title == null || title.trim().isEmpty()) {
            request.setAttribute("error", "Module ID and lesson title are required.");
            doGet(request, response);
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
            
            // Create new lesson
            LessonModel lesson = new LessonModel();
            lesson.setModuleId(moduleId);
            lesson.setTitle(title);
            lesson.setContent(content);
            
            // Set duration if provided
            if (durationParam != null && !durationParam.isEmpty()) {
                try {
                    int duration = Integer.parseInt(durationParam);
                    lesson.setDuration(duration);
                } catch (NumberFormatException e) {
                    // Use default duration (0)
                    lesson.setDuration(0);
                }
            }
            
            // Set resource link if provided
            if (resourceLink != null && !resourceLink.isEmpty()) {
                lesson.setResourceLink(resourceLink);
            }
            
            try {
                // Insert lesson
                LOGGER.info("Inserting lesson: " + lesson.getTitle() + " for module ID: " + lesson.getModuleId());
                int lessonId = LessonDAO.insertLesson(lesson);
                
                if (lessonId > 0) {
                    // Lesson created successfully
                    LOGGER.info("Lesson created successfully with ID: " + lessonId);
                    lesson.setLessonId(lessonId);
                    session.setAttribute("success", "Lesson '" + lesson.getTitle() + "' created successfully!");
                    
                    // Handle after action
                    if ("addAnother".equals(afterAction)) {
                        // Redirect back to add lesson page
                        response.sendRedirect(request.getContextPath() + "/instructor/add-lesson?moduleId=" + moduleId);
                    } else {
                        // Default: return to course view
                        response.sendRedirect(request.getContextPath() + "/instructor/courses/view?id=" + course.getCourseId());
                    }
                } else {
                    // Lesson creation failed
                    LOGGER.warning("Failed to create lesson. LessonDAO.insertLesson returned 0.");
                    request.setAttribute("error", "Failed to create lesson. Please try again.");
                    doGet(request, response);
                }
            } catch (Exception e) {
                // Log the exception
                LOGGER.log(Level.SEVERE, "Exception while creating lesson", e);
                request.setAttribute("error", "An error occurred while creating the lesson: " + e.getMessage());
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid module ID: {0}", moduleIdParam);
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
        }
    }
}
