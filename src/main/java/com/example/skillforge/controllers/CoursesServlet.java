package com.example.skillforge.controllers;

import com.example.skillforge.dao.course.CategoryDAO;
import com.example.skillforge.dao.course.CourseDAO;
import com.example.skillforge.models.course.CategoryModel;
import com.example.skillforge.models.course.CourseModel;
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
                }
            }

            if (sortParam != null && !sortParam.isEmpty()) {
                sortBy = sortParam;
            }

            // Get courses based on filters
            List<CourseModel> allCourses;
            if (categoryId > 0) {
                allCourses = CourseDAO.getCoursesByCategory(categoryId);
                // Set the selected category for the UI
                for (CategoryModel category : categories) {
                    if (category.getCategoryId() == categoryId) {
                        request.setAttribute("selectedCategory", category);
                        break;
                    }
                }
            } else {
                allCourses = CourseDAO.getAllCourses();
            }

            // Filter by search term if provided
            if (searchParam != null && !searchParam.isEmpty()) {
                String searchTerm = searchParam.toLowerCase();
                allCourses.removeIf(course ->
                    !course.getTitle().toLowerCase().contains(searchTerm) &&
                    !course.getDescription().toLowerCase().contains(searchTerm) &&
                    !course.getCategory().getName().toLowerCase().contains(searchTerm));
                request.setAttribute("searchTerm", searchParam);
            }

            // Filter out inactive courses
            allCourses.removeIf(course -> course.getStatus() != CourseModel.Status.active);

            // Sort courses
            switch (sortBy) {
                case "oldest":
                    allCourses.sort((c1, c2) -> c1.getCreatedAt().compareTo(c2.getCreatedAt()));
                    break;
                case "az":
                    allCourses.sort((c1, c2) -> c1.getTitle().compareToIgnoreCase(c2.getTitle()));
                    break;
                case "za":
                    allCourses.sort((c1, c2) -> c2.getTitle().compareToIgnoreCase(c1.getTitle()));
                    break;
                case "popular":
                    // Sort by enrollment count (would need to implement this)
                    // For now, just use newest as default
                default: // "newest"
                    allCourses.sort((c1, c2) -> c2.getCreatedAt().compareTo(c1.getCreatedAt()));
                    break;
            }

            // Calculate pagination
            int totalCourses = allCourses.size();
            int totalPages = (int) Math.ceil((double) totalCourses / COURSES_PER_PAGE);

            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }

            // Get courses for current page
            int startIndex = (currentPage - 1) * COURSES_PER_PAGE;
            int endIndex = Math.min(startIndex + COURSES_PER_PAGE, totalCourses);

            List<CourseModel> paginatedCourses;
            if (startIndex < totalCourses) {
                paginatedCourses = allCourses.subList(startIndex, endIndex);
            } else {
                paginatedCourses = List.of(); // Empty list
            }

            // Set attributes for the view
            request.setAttribute("courses", paginatedCourses);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalCourses", totalCourses);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("categoryId", categoryId);

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

                // Set attributes for the view
                request.setAttribute("course", course);
                request.setAttribute("isEnrolled", isEnrolled);
                request.setAttribute("enrollmentCount", enrollmentCount);

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
