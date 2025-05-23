package com.example.skillforge.controllers.instructor;

import com.example.skillforge.dao.course.CategoryDAO;
import com.example.skillforge.models.course.CategoryModel;
import com.example.skillforge.models.user.UserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject;

/**
 * Controller for handling category operations
 */
@WebServlet("/instructor/categories/*")
public class CategoryController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an instructor
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        System.out.println("CategoryController.doPost() - User: " + (user != null ? user.getName() + ", Role: " + user.getRole() : "null"));

        if (user == null || user.getRole() != UserModel.Role.instructor) {
            System.out.println("CategoryController.doPost() - Unauthorized access attempt");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String pathInfo = request.getPathInfo();
        System.out.println("CategoryController.doPost() - Path info: " + pathInfo);

        if (pathInfo != null && pathInfo.equals("/create")) {
            // Create a new category
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            System.out.println("CategoryController.doPost() - Creating category with name: " + name + ", description: " + description);

            if (name == null || name.trim().isEmpty()) {
                System.out.println("CategoryController.doPost() - Category name is required");
                sendJsonResponse(response, false, "Category name is required");
                return;
            }

            CategoryModel category = new CategoryModel();
            category.setName(name);
            category.setDescription(description != null ? description : "");

            int categoryId = CategoryDAO.insertCategory(category);

            if (categoryId > 0) {
                // Category created successfully
                category.setCategoryId(categoryId);
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Category created successfully");
                jsonResponse.put("category", new JSONObject()
                        .put("id", category.getCategoryId())
                        .put("name", category.getName())
                        .put("description", category.getDescription())
                );

                System.out.println("CategoryController.doPost() - Category created successfully with ID: " + categoryId);
                System.out.println("CategoryController.doPost() - Response JSON: " + jsonResponse.toString());

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.print(jsonResponse.toString());
                out.flush();
            } else {
                System.out.println("CategoryController.doPost() - Failed to create category");
                sendJsonResponse(response, false, "Failed to create category");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("success", success);
        jsonResponse.put("message", message);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}
