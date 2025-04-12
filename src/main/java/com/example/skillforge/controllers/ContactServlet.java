package com.example.skillforge.controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ContactServlet", value = "/contact")
public class ContactServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        // In a real application, you would process the contact form submission here
        // For example, sending an email or storing in database
        
        // Add a success message
        request.setAttribute("success", "Your message has been sent successfully. We'll get back to you soon!");
        
        // Forward back to the contact page
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }
}