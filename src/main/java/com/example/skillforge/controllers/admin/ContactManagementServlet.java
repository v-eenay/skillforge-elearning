package com.example.skillforge.controllers.admin;

import com.example.skillforge.models.ContactModel;
import com.example.skillforge.services.ContactService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

/**
 * Servlet for managing contact form submissions (admin only)
 */
@WebServlet(name = "ContactManagementServlet", value = "/admin/contacts")
public class ContactManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get status filter parameter
        String statusParam = request.getParameter("status");
        List<ContactModel> contacts;
        
        if (statusParam != null && !statusParam.isEmpty()) {
            try {
                ContactModel.Status status;
                if (statusParam.equals("new")) {
                    status = ContactModel.Status.new_status;
                } else {
                    status = ContactModel.Status.valueOf(statusParam);
                }
                contacts = ContactService.getContactsByStatus(status);
                request.setAttribute("currentStatus", statusParam);
            } catch (IllegalArgumentException e) {
                // Invalid status parameter, get all contacts
                contacts = ContactService.getAllContacts();
            }
        } else {
            // No status parameter, get all contacts
            contacts = ContactService.getAllContacts();
        }
        
        request.setAttribute("contacts", contacts);
        request.getRequestDispatcher("/WEB-INF/views/admin/contact-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get action parameter
        String action = request.getParameter("action");
        
        if (action != null && !action.isEmpty()) {
            // Get contact ID parameter
            String contactIdParam = request.getParameter("contactId");
            
            if (contactIdParam != null && !contactIdParam.isEmpty()) {
                try {
                    int contactId = Integer.parseInt(contactIdParam);
                    
                    if (action.equals("markAsRead")) {
                        // Mark contact as read
                        boolean success = ContactService.updateContactStatus(contactId, ContactModel.Status.read);
                        if (success) {
                            request.setAttribute("success", "Contact marked as read.");
                        } else {
                            request.setAttribute("error", "Failed to mark contact as read.");
                        }
                    } else if (action.equals("markAsReplied")) {
                        // Mark contact as replied
                        boolean success = ContactService.updateContactStatus(contactId, ContactModel.Status.replied);
                        if (success) {
                            request.setAttribute("success", "Contact marked as replied.");
                        } else {
                            request.setAttribute("error", "Failed to mark contact as replied.");
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid contact ID.");
                }
            } else {
                request.setAttribute("error", "Contact ID is required.");
            }
        }
        
        // Redirect back to the contact management page
        response.sendRedirect(request.getContextPath() + "/admin/contacts");
    }
}
