package com.example.skillforge.controllers.instructor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet for handling instructor messages
 */
@WebServlet(name = "InstructorMessagesServlet", value = "/instructor/messages")
public class InstructorMessagesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the instructor messages page
        request.getRequestDispatcher("/WEB-INF/views/instructor/instructor-messages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle message sending or other actions (to be implemented)
        // For now, just redirect back to the messages page
        response.sendRedirect(request.getContextPath() + "/instructor/messages");
    }
}
