package com.example.skillforge.controllers;

import com.example.skillforge.dao.course.CategoryDAO;
import com.example.skillforge.dao.course.CourseDAO;
import com.example.skillforge.dao.course.ModuleDAO;
import com.example.skillforge.models.course.CategoryModel;
import com.example.skillforge.models.course.CourseModel;
import com.example.skillforge.models.course.ModuleModel;
import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.utils.FileUploadUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
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
            List<CourseModel> courses = CourseDAO.getCoursesByInstructor(user.getUserId());
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("/WEB-INF/views/instructor/courses.jsp").forward(request, response);
        } else if (pathInfo.equals("/create")) {
            // Show course creation form
            List<CategoryModel> categories = CategoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/views/instructor/create-course.jsp").forward(request, response);
        } else if (pathInfo.equals("/view")) {
            // Show course view page
            String courseIdParam = request.getParameter("id");
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

                // Get course modules
                List<ModuleModel> modules = ModuleDAO.getModulesByCourse(courseId);

                // Load lessons for each module
                for (ModuleModel module : modules) {
                    List<com.example.skillforge.models.content.LessonModel> lessons =
                        com.example.skillforge.dao.content.LessonDAO.getLessonsByModule(module.getModuleId());
                    module.setLessons(lessons);
                }

                request.setAttribute("course", course);
                request.setAttribute("modules", modules);
                request.getRequestDispatcher("/WEB-INF/views/instructor/course-view.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
            }
        } else if (pathInfo.equals("/edit")) {
            // Show course edit form
            String courseIdParam = request.getParameter("id");
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

                // Get categories for the dropdown
                List<CategoryModel> categories = CategoryDAO.getAllCategories();

                request.setAttribute("course", course);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/WEB-INF/views/instructor/edit-course.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
            }
        } else if (pathInfo.equals("/toggle-status")) {
            // Handle course publish/unpublish
            System.out.println("Processing toggle-status request via GET");
            try {
                // Get course ID
                String courseIdParam = request.getParameter("id");
                System.out.println("Course ID parameter: " + courseIdParam);
                int courseId = Integer.parseInt(courseIdParam);

                // Get the course from the database
                CourseModel course = CourseDAO.getCourseById(courseId);

                // Check if course exists and belongs to the current instructor
                if (course == null || course.getCreatedBy() != user.getUserId()) {
                    response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                    return;
                }

                // Toggle the status
                CourseModel.Status newStatus = (course.getStatus() == CourseModel.Status.active)
                    ? CourseModel.Status.inactive
                    : CourseModel.Status.active;

                course.setStatus(newStatus);
                course.setUpdatedAt(LocalDateTime.now());

                // Update course in database
                boolean updated = CourseDAO.updateCourse(course);

                if (updated) {
                    // Course updated successfully
                    String statusMessage = (newStatus == CourseModel.Status.active)
                        ? "Course published successfully!"
                        : "Course unpublished successfully!";
                    session.setAttribute("message", statusMessage);
                } else {
                    // Course update failed
                    session.setAttribute("error", "Failed to update course status. Please try again.");
                }

                // Redirect back to the referring page or course list
                String referer = request.getHeader("Referer");
                if (referer != null && !referer.isEmpty()) {
                    response.sendRedirect(referer);
                } else {
                    response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                }
            } catch (Exception e) {
                // Handle exceptions
                System.out.println("Exception during course status update: " + e.getMessage());
                e.printStackTrace();
                session.setAttribute("error", "An error occurred: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
            }
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
                System.out.println("Processing course creation form submission");

                // Get form data
                String title = request.getParameter("title");
                System.out.println("Title: " + title);

                String description = request.getParameter("description");
                System.out.println("Description length: " + (description != null ? description.length() : "null"));

                String categoryIdStr = request.getParameter("categoryId");
                System.out.println("Category ID string: " + categoryIdStr);
                int categoryId = Integer.parseInt(categoryIdStr);

                String level = request.getParameter("level");
                System.out.println("Level: " + level);

                String status = request.getParameter("status"); // draft or active
                System.out.println("Status: " + status);

                String saveAction = request.getParameter("saveAction"); // draft or publish
                System.out.println("Save Action: " + saveAction);

                // If status is null, default to "inactive"
                if (status == null) {
                    status = "inactive";
                    System.out.println("Status was null, defaulting to inactive");
                }

                // If saveAction is publish, override status to active
                if ("publish".equals(saveAction)) {
                    status = "active";
                    System.out.println("Status overridden to active");
                }

                // Optional fields
                String promoVideo = request.getParameter("promoVideo");
                String durationStr = request.getParameter("duration");
                String priceStr = request.getParameter("price");
                String prerequisites = request.getParameter("prerequisites");
                String tags = request.getParameter("tags");

                // Handle thumbnail upload
                System.out.println("Processing thumbnail upload");
                Part thumbnailPart = request.getPart("thumbnailFile");
                System.out.println("Thumbnail part: " + (thumbnailPart != null ? "found" : "null"));
                if (thumbnailPart != null) {
                    System.out.println("Thumbnail size: " + thumbnailPart.getSize());
                    System.out.println("Thumbnail filename: " + thumbnailPart.getSubmittedFileName());
                }

                String thumbnailPath = null;
                try {
                    thumbnailPath = FileUploadUtil.uploadCourseThumbnail(request, "thumbnailFile");
                    System.out.println("Thumbnail path: " + thumbnailPath);
                } catch (Exception e) {
                    System.out.println("Exception during thumbnail upload: " + e.getMessage());
                    e.printStackTrace();
                }

                // If thumbnail upload fails, use a default thumbnail
                if (thumbnailPath == null) {
                    System.out.println("Using default thumbnail");
                    thumbnailPath = "/assets/images/default-course-thumbnail.svg";
                }

                // Create course model
                System.out.println("Creating course model");
                CourseModel course = new CourseModel();
                course.setTitle(title);
                course.setDescription(description);
                course.setCategoryId(categoryId);
                course.setLevel(level);
                course.setThumbnail(thumbnailPath);
                // Convert status string to enum safely
                try {
                    course.setStatus(CourseModel.Status.valueOf(status));
                    System.out.println("Status set to: " + status);
                } catch (IllegalArgumentException e) {
                    System.out.println("Invalid status value: " + status + ", defaulting to inactive");
                    course.setStatus(CourseModel.Status.inactive);
                }
                course.setCreatedBy(user.getUserId());
                course.setCreatedAt(LocalDateTime.now());
                course.setUpdatedAt(LocalDateTime.now());

                // Set optional fields if provided
                if (promoVideo != null && !promoVideo.isEmpty()) {
                    course.setPromoVideo(promoVideo);
                }

                if (durationStr != null && !durationStr.isEmpty()) {
                    course.setDuration(durationStr);
                }

                if (priceStr != null && !priceStr.isEmpty()) {
                    try {
                        course.setPrice(Double.parseDouble(priceStr));
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid price format: " + priceStr);
                    }
                }

                if (prerequisites != null && !prerequisites.isEmpty()) {
                    course.setPrerequisites(prerequisites);
                }

                if (tags != null && !tags.isEmpty()) {
                    course.setTags(tags);
                }

                // Insert course into database
                System.out.println("Inserting course into database");
                int courseId = CourseDAO.insertCourse(course);
                System.out.println("Course ID after insertion: " + courseId);

                if (courseId > 0) {
                    // Course created successfully
                    System.out.println("Course created successfully");
                    session.setAttribute("message", "Course created successfully!");
                    response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                } else {
                    // Course creation failed
                    System.out.println("Course creation failed");
                    request.setAttribute("error", "Failed to create course. Please try again.");
                    List<CategoryModel> categories = CategoryDAO.getAllCategories();
                    request.setAttribute("categories", categories);
                    request.getRequestDispatcher("/WEB-INF/views/instructor/create-course.jsp").forward(request, response);
                }
            } catch (Exception e) {
                // Handle exceptions
                System.out.println("Exception during course creation: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "An error occurred: " + e.getMessage());
                List<CategoryModel> categories = CategoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/WEB-INF/views/instructor/create-course.jsp").forward(request, response);
            }
        } else if (pathInfo != null && pathInfo.equals("/edit")) {
            // Handle course edit form submission
            try {
                // Get course ID
                int courseId = Integer.parseInt(request.getParameter("courseId"));

                // Get the course from the database
                CourseModel course = CourseDAO.getCourseById(courseId);

                // Check if course exists and belongs to the current instructor
                if (course == null || course.getCreatedBy() != user.getUserId()) {
                    response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                    return;
                }

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
                } else if ("draft".equals(saveAction)) {
                    status = "inactive";
                }

                // Optional fields
                String promoVideo = request.getParameter("promoVideo");
                String durationStr = request.getParameter("duration");
                String priceStr = request.getParameter("price");
                String prerequisites = request.getParameter("prerequisites");
                String tags = request.getParameter("tags");

                // Handle thumbnail upload if a new file was provided
                String thumbnailPath = course.getThumbnail(); // Default to existing thumbnail
                Part thumbnailPart = request.getPart("thumbnailFile");
                if (thumbnailPart != null && thumbnailPart.getSize() > 0) {
                    System.out.println("New thumbnail file detected, size: " + thumbnailPart.getSize());
                    String newThumbnailPath = FileUploadUtil.uploadCourseThumbnail(request, "thumbnailFile");
                    if (newThumbnailPath != null) {
                        thumbnailPath = newThumbnailPath;
                        System.out.println("New thumbnail path: " + thumbnailPath);
                    } else {
                        System.out.println("Thumbnail upload failed, keeping existing thumbnail");
                    }
                } else {
                    System.out.println("No new thumbnail file provided, keeping existing thumbnail: " + thumbnailPath);
                }

                // Update course model
                course.setTitle(title);
                course.setDescription(description);
                course.setCategoryId(categoryId);
                course.setLevel(level);
                course.setThumbnail(thumbnailPath);

                // Set optional fields
                if (promoVideo != null) {
                    course.setPromoVideo(promoVideo);
                }

                if (durationStr != null && !durationStr.isEmpty()) {
                    course.setDuration(durationStr);
                }

                if (priceStr != null && !priceStr.isEmpty()) {
                    try {
                        course.setPrice(Double.parseDouble(priceStr));
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid price format: " + priceStr);
                    }
                }

                if (prerequisites != null) {
                    course.setPrerequisites(prerequisites);
                }

                if (tags != null) {
                    course.setTags(tags);
                }

                // Convert status string to enum safely
                try {
                    course.setStatus(CourseModel.Status.valueOf(status));
                } catch (IllegalArgumentException e) {
                    System.out.println("Invalid status value: " + status + ", defaulting to inactive");
                    course.setStatus(CourseModel.Status.inactive);
                }
                course.setUpdatedAt(LocalDateTime.now());

                // Update course in database
                boolean updated = CourseDAO.updateCourse(course);

                if (updated) {
                    // Course updated successfully
                    session.setAttribute("message", "Course updated successfully!");
                    response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                } else {
                    // Course update failed
                    request.setAttribute("error", "Failed to update course. Please try again.");
                    List<CategoryModel> categories = CategoryDAO.getAllCategories();
                    request.setAttribute("categories", categories);
                    request.setAttribute("course", course);
                    request.getRequestDispatcher("/WEB-INF/views/instructor/edit-course.jsp").forward(request, response);
                }
            } catch (Exception e) {
                // Handle exceptions
                request.setAttribute("error", "An error occurred: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
            }
        } else if (pathInfo != null && pathInfo.equals("/toggle-status")) {
            // Handle course publish/unpublish
            System.out.println("Processing toggle-status request via POST");
            try {
                // Get course ID
                String courseIdParam = request.getParameter("id");
                System.out.println("Course ID parameter (POST): " + courseIdParam);
                int courseId = Integer.parseInt(courseIdParam);

                // Get the course from the database
                CourseModel course = CourseDAO.getCourseById(courseId);

                // Check if course exists and belongs to the current instructor
                if (course == null || course.getCreatedBy() != user.getUserId()) {
                    response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                    return;
                }

                // Toggle the status
                CourseModel.Status newStatus = (course.getStatus() == CourseModel.Status.active)
                    ? CourseModel.Status.inactive
                    : CourseModel.Status.active;

                course.setStatus(newStatus);
                course.setUpdatedAt(LocalDateTime.now());

                // Update course in database
                boolean updated = CourseDAO.updateCourse(course);

                if (updated) {
                    // Course updated successfully
                    String statusMessage = (newStatus == CourseModel.Status.active)
                        ? "Course published successfully!"
                        : "Course unpublished successfully!";
                    session.setAttribute("message", statusMessage);
                } else {
                    // Course update failed
                    session.setAttribute("error", "Failed to update course status. Please try again.");
                }

                // Redirect back to the referring page or course list
                String referer = request.getHeader("Referer");
                if (referer != null && !referer.isEmpty()) {
                    response.sendRedirect(referer);
                } else {
                    response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                }
            } catch (Exception e) {
                // Handle exceptions
                System.out.println("Exception during course status update: " + e.getMessage());
                e.printStackTrace();
                session.setAttribute("error", "An error occurred: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
            }
        } else {
            // Handle 404
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
