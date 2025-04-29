package com.example.skillforge.controllers;

import com.example.skillforge.dao.course.CategoryDAO;
import com.example.skillforge.dao.course.CourseDAO;
import com.example.skillforge.dao.course.ModuleDAO;
import com.example.skillforge.dao.content.LessonDAO;
import com.example.skillforge.models.course.CategoryModel;
import com.example.skillforge.models.course.CourseModel;
import com.example.skillforge.models.course.ModuleModel;
import com.example.skillforge.models.content.LessonModel;
import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.services.EnrollmentService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CoursesServlet", value = "/courses/*")
public class CoursesServlet extends HttpServlet {
    private static final int COURSES_PER_PAGE = 9; // Number of courses to display per page

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get path info
        String pathInfo = request.getPathInfo();

        // Get user from session (if logged in)
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (pathInfo == null || pathInfo.equals("/")) {
            // List all courses with pagination and filtering

            // Get all categories for the tabs
            List<CategoryModel> categories = CategoryDAO.getAllCategories();
            request.setAttribute("categories", categories);

            // Get filter parameters
            String categoryParam = request.getParameter("category");
            String searchParam = request.getParameter("search");
            String pageParam = request.getParameter("page");
            String sortParam = request.getParameter("sort");

            // Set default values
            int categoryId = 0; // 0 means all categories
            int currentPage = 1;
            String sortBy = "newest"; // Default sort order

            // Parse parameters
            if (categoryParam != null && !categoryParam.isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryParam);
                } catch (NumberFormatException e) {
                    // Ignore and use default
                    categoryId = 0; // Reset to default if invalid
                }
            }

            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) {
                        currentPage = 1;
                    }
                } catch (NumberFormatException e) {
                    // Ignore and use default
                    currentPage = 1; // Reset to default if invalid
                }
            }

            if (sortParam != null && !sortParam.isEmpty()) {
                // Validate sortBy parameter to prevent potential issues
                List<String> validSorts = List.of("newest", "oldest", "az", "za", "popular");
                if (validSorts.contains(sortParam.toLowerCase())) {
                    sortBy = sortParam.toLowerCase();
                }
            }

            // Get total count of courses matching filters (for pagination)
            int totalCourses = CourseDAO.countCourses(categoryId, searchParam);
            int totalPages = (int) Math.ceil((double) totalCourses / COURSES_PER_PAGE);

            // Adjust currentPage if it's out of bounds after filtering
            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            } else if (currentPage < 1) {
                currentPage = 1;
            }

            // Get courses for the current page using the new DAO method
            List<CourseModel> paginatedCourses = CourseDAO.getPaginatedCourses(categoryId, searchParam, sortBy, currentPage, COURSES_PER_PAGE);

            // Set the selected category for the UI if applicable
            if (categoryId > 0) {
                CategoryModel selectedCategory = CategoryDAO.getCategoryById(categoryId);
                request.setAttribute("selectedCategory", selectedCategory);
            }

            // Set attributes for the view
            request.setAttribute("courses", paginatedCourses);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalCourses", totalCourses);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("categoryId", categoryId);
            request.setAttribute("searchTerm", searchParam != null ? searchParam : ""); // Ensure searchTerm is not null

            // Forward to courses list page
            request.getRequestDispatcher("/WEB-INF/views/courses.jsp").forward(request, response);
        } else if (pathInfo.equals("/view")) {
            // Show course details
            String courseIdParam = request.getParameter("id");
            if (courseIdParam == null || courseIdParam.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }

            try {
                int courseId = Integer.parseInt(courseIdParam);
                CourseModel course = CourseDAO.getCourseById(courseId);

                // Check if course exists and is active
                if (course == null || course.getStatus() != CourseModel.Status.active) {
                    response.sendRedirect(request.getContextPath() + "/courses");
                    return;
                }

                // Check if user is enrolled
                boolean isEnrolled = false;
                if (user != null) {
                    isEnrolled = EnrollmentService.isUserEnrolled(user.getUserId(), courseId);
                }

                // Get enrollment count
                int enrollmentCount = EnrollmentService.getEnrollmentCount(courseId);

                // Get modules and lessons for the course
                List<ModuleModel> modules = ModuleDAO.getModulesByCourse(courseId);

                // For each module, get its lessons
                for (ModuleModel module : modules) {
                    List<LessonModel> lessons = LessonDAO.getLessonsByModule(module.getModuleId());
                    module.setLessons(lessons);
                }

                // Set attributes for the view
                request.setAttribute("course", course);
                request.setAttribute("isEnrolled", isEnrolled);
                request.setAttribute("enrollmentCount", enrollmentCount);
                request.setAttribute("modules", modules);

                // Forward to course details page
                request.getRequestDispatcher("/WEB-INF/views/course-details.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/courses");
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
