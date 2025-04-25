package com.example.skillforge.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet for handling admin messages
 */
@WebServlet(name = "AdminMessagesServlet", value = "/admin/messages")
public class AdminMessagesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the admin messages page
        request.getRequestDispatcher("/WEB-INF/views/admin/admin-messages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle message sending or other actions (to be implemented)
        // For now, just redirect back to the messages page
        response.sendRedirect(request.getContextPath() + "/admin/messages");
    }
}
