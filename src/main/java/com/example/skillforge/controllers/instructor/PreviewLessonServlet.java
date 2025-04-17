package com.example.skillforge.controllers.instructor;

import com.example.skillforge.dao.content.ContentBlockDAO;
import com.example.skillforge.dao.content.LessonDAO;
import com.example.skillforge.dao.course.CourseDAO;
import com.example.skillforge.dao.course.ModuleDAO;
import com.example.skillforge.models.content.ContentBlockModel;
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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for previewing a lesson as a student
 */
@WebServlet(name = "PreviewLessonServlet", urlPatterns = {"/instructor/preview-lesson"})
public class PreviewLessonServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(PreviewLessonServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        
        // Check if user is logged in and is an instructor
        if (user == null || !user.getRole().equals(UserModel.Role.instructor)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        // Get lesson ID from request parameter
        String lessonIdParam = request.getParameter("id");
        if (lessonIdParam == null || lessonIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
            return;
        }
        
        try {
            int lessonId = Integer.parseInt(lessonIdParam);
            LessonModel lesson = LessonDAO.getLessonById(lessonId);
            
            if (lesson == null) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }
            
            // Get the module and course to check ownership
            ModuleModel module = ModuleDAO.getModuleById(lesson.getModuleId());
            if (module == null) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }
            
            CourseModel course = CourseDAO.getCourseById(module.getCourseId());
            
            // Check if course exists and belongs to the current instructor
            if (course == null || course.getCreatedBy() != user.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }
            
            // Get content blocks for the lesson
            List<ContentBlockModel> contentBlocks = ContentBlockDAO.getContentBlocksByLesson(lessonId);
            
            request.setAttribute("lesson", lesson);
            request.setAttribute("module", module);
            request.setAttribute("course", course);
            request.setAttribute("contentBlocks", contentBlocks);
            request.setAttribute("previewMode", true);
            
            // Forward to the student lesson view (we'll create this JSP)
            request.getRequestDispatcher("/WEB-INF/views/instructor/preview-lesson.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid lesson ID: {0}", lessonIdParam);
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
        }
    }
}
