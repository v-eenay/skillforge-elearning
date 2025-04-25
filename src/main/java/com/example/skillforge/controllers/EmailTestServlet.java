package com.example.skillforge.controllers;

import com.example.skillforge.utils.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet for testing email configuration
 */
@WebServlet(name = "EmailTestServlet", value = "/admin/test-email")
public class EmailTestServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Email Test</title>");
        out.println("<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">");
        out.println("</head><body>");
        out.println("<div class=\"container mt-5\">");
        out.println("<h1>Test Email Configuration</h1>");
        out.println("<form method=\"post\" class=\"mt-4\">");
        out.println("<div class=\"mb-3\">");
        out.println("<label for=\"email\" class=\"form-label\">Email address to test:</label>");
        out.println("<input type=\"email\" class=\"form-control\" id=\"email\" name=\"email\" required>");
        out.println("</div>");
        out.println("<button type=\"submit\" class=\"btn btn-primary\">Send Test Email</button>");
        out.println("</form>");
        out.println("</div>");
        out.println("</body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        boolean success = EmailUtil.testEmailConfiguration(email);
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Email Test Result</title>");
        out.println("<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\">");
        out.println("</head><body>");
        out.println("<div class=\"container mt-5\">");
        
        if (success) {
            out.println("<div class=\"alert alert-success\" role=\"alert\">");
            out.println("<h4 class=\"alert-heading\">Success!</h4>");
            out.println("<p>Test email sent successfully to " + email + "</p>");
            out.println("<p>Please check your inbox (and spam folder) to confirm receipt.</p>");
            out.println("</div>");
        } else {
            out.println("<div class=\"alert alert-danger\" role=\"alert\">");
            out.println("<h4 class=\"alert-heading\">Failed!</h4>");
            out.println("<p>Failed to send test email to " + email + "</p>");
            out.println("<p>Please check the server logs for more details.</p>");
            out.println("</div>");
        }
        
        out.println("<a href=\"" + request.getContextPath() + "/admin/test-email\" class=\"btn btn-primary\">Try Again</a>");
        out.println("</div>");
        out.println("</body></html>");
    }
}
