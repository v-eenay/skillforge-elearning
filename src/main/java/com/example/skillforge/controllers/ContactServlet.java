package com.example.skillforge.controllers;

import com.example.skillforge.models.user.ContactModel;
import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.services.ContactService;
import com.example.skillforge.utils.EmailUtil;
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

        // Validate form data
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {

            request.setAttribute("error", "Please fill in all required fields.");
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
            return;
        }

        // Get user ID if logged in
        Integer userId = null;
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            UserModel user = (UserModel) session.getAttribute("user");
            userId = user.getUserId();
        }

        // Submit the contact form
        int contactId = ContactService.submitContactForm(name, email, subject, message, userId);

        if (contactId > 0) {
            // Create a contact model for sending emails
            ContactModel contact = new ContactModel();
            contact.setContactId(contactId);
            contact.setName(name);
            contact.setEmail(email);
            contact.setSubject(subject);
            contact.setMessage(message);
            contact.setUserId(userId);

            // Send confirmation email to the user
            boolean emailSent = EmailUtil.sendContactConfirmation(contact);

            // Send notification email to admin
            boolean adminEmailSent = EmailUtil.sendContactNotification(contact);

            if (emailSent) {
                // Add a success message
                request.setAttribute("success", "Your message has been sent successfully. We've also sent you a confirmation email. We'll get back to you soon!");
            } else {
                // Add a success message without mentioning the email
                request.setAttribute("success", "Your message has been sent successfully. We'll get back to you soon!");
            }

            // Log email status
            getServletContext().log("Contact form submitted. User email sent: " + emailSent + ", Admin notification sent: " + adminEmailSent);
        } else {
            // Add an error message
            request.setAttribute("error", "There was a problem sending your message. Please try again later.");
        }

        // Forward back to the contact page
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }
}