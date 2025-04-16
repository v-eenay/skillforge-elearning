package com.example.skillforge.controllers;

import com.example.skillforge.dao.course.CategoryDAO;
import com.example.skillforge.dao.course.CourseDAO;
import com.example.skillforge.models.course.CategoryModel;
import com.example.skillforge.models.course.CourseModel;
import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.utils.FileUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/instructor/courses/*")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 50)   // 50 MB
public class InstructorController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        // Check if user is logged in and is an instructor
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null || !user.getRole().equals(UserModel.Role.instructor)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (pathInfo == null || pathInfo.equals("/")) {
            // List instructor's courses
            request.getRequestDispatcher("/WEB-INF/views/instructor/courses.jsp").forward(request, response);
        } else if (pathInfo.equals("/create")) {
            // Show course creation form
            List<CategoryModel> categories = CategoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/views/instructor/create-course.jsp").forward(request, response);
        } else {
            // Handle 404
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        // Check if user is logged in and is an instructor
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null || !user.getRole().equals(UserModel.Role.instructor)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (pathInfo != null && pathInfo.equals("/create")) {
            // Handle course creation form submission
            try {
                // Get form data
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String level = request.getParameter("level");
                String status = request.getParameter("status"); // draft or active
                String saveAction = request.getParameter("saveAction"); // draft or publish

                // If saveAction is publish, override status to active
                if ("publish".equals(saveAction)) {
                    status = "active";
                }

                // Optional fields
                String promoVideo = request.getParameter("promoVideo");
                String durationStr = request.getParameter("duration");
                String priceStr = request.getParameter("price");
                String prerequisites = request.getParameter("prerequisites");
                String tags = request.getParameter("tags");

                // Handle thumbnail upload
                String thumbnailPath = FileUploadUtil.uploadCourseThumbnail(request, "thumbnailFile");

                // Create course model
                CourseModel course = new CourseModel();
                course.setTitle(title);
                course.setDescription(description);
                course.setCategoryId(categoryId);
                course.setLevel(level);
                course.setThumbnail(thumbnailPath);
                course.setStatus(CourseModel.Status.valueOf(status));
                course.setCreatedBy(user.getUserId());
                course.setCreatedAt(LocalDateTime.now());
                course.setUpdatedAt(LocalDateTime.now());

                // Insert course into database
                int courseId = CourseDAO.insertCourse(course);

                if (courseId > 0) {
                    // Course created successfully
                    session.setAttribute("message", "Course created successfully!");
                    response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                } else {
                    // Course creation failed
                    request.setAttribute("error", "Failed to create course. Please try again.");
                    List<CategoryModel> categories = CategoryDAO.getAllCategories();
                    request.setAttribute("categories", categories);
                    request.getRequestDispatcher("/WEB-INF/views/instructor/create-course.jsp").forward(request, response);
                }
            } catch (Exception e) {
                // Handle exceptions
                request.setAttribute("error", "An error occurred: " + e.getMessage());
                List<CategoryModel> categories = CategoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/WEB-INF/views/instructor/create-course.jsp").forward(request, response);
            }
        } else {
            // Handle 404
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
