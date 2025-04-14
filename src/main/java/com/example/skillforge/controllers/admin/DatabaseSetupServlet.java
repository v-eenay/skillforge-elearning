package com.example.skillforge.controllers.admin;

import com.example.skillforge.utils.DatabaseSetupUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet for initializing the database
 * This servlet can be accessed by administrators to initialize the database and tables
 */
@WebServlet(name = "DatabaseSetupServlet", value = "/admin/setup-database")
public class DatabaseSetupServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Check if user is admin (in a real application, you would check session)
        // For simplicity, we're not implementing authentication here
        
        out.println("<html><body>");
        out.println("<h1>Database Setup</h1>");
        out.println("<p>Click the button below to initialize the database and tables.</p>");
        out.println("<form method='post'>");
        out.println("<button type='submit'>Initialize Database</button>");
        out.println("</form>");
        out.println("</body></html>");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Check if user is admin (in a real application, you would check session)
        // For simplicity, we're not implementing authentication here
        
        out.println("<html><body>");
        out.println("<h1>Database Setup Result</h1>");
        
        boolean success = DatabaseSetupUtil.initializeDatabase();
        
        if (success) {
            out.println("<p style='color: green;'>Database initialization successful!</p>");
        } else {
            out.println("<p style='color: red;'>Database initialization failed. Check server logs for details.</p>");
        }
        
        out.println("<a href='" + request.getContextPath() + "/admin/dashboard'>Return to Dashboard</a>");
        out.println("</body></html>");
    }
}
