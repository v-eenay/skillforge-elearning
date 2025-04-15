package com.example.skillforge.controllers;

import com.example.skillforge.dao.course.CategoryDAO;
import com.example.skillforge.models.course.CategoryModel;
import com.example.skillforge.models.user.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
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
            // This will be implemented later

            // For now, just redirect back to courses page with a success message
            session.setAttribute("message", "Course created successfully!");
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
        } else {
            // Handle 404
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
