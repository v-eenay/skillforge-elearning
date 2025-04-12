package com.example.skillforge.filters;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Check for static resources that might not exist
        if (requestURI.contains("/css/") || 
            requestURI.contains("/js/") || 
            requestURI.contains("/images/")) {
            chain.doFilter(request, response);
            return;
        }
        
        // Public pages that don't require authentication
        if (requestURI.equals(contextPath + "/") ||
            requestURI.contains("/login") ||
            requestURI.contains("/register") ||
            requestURI.contains("/css/") ||
            requestURI.contains("/js/") ||
            requestURI.contains("/images/")) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(contextPath + "/auth/login");
            return;
        }
        
        // Get user role from session
        String userRole = (String) session.getAttribute("userRole");
        
        // Role-based access control
        if (requestURI.contains("/admin/") && !"admin".equals(userRole)) {
            httpResponse.sendRedirect(contextPath + "/access-denied");
            return;
        } else if (requestURI.contains("/instructor/") && !"instructor".equals(userRole) && !"admin".equals(userRole)) {
            httpResponse.sendRedirect(contextPath + "/access-denied");
            return;
        } else if (requestURI.contains("/student/") && !"student".equals(userRole) && !"admin".equals(userRole)) {
            httpResponse.sendRedirect(contextPath + "/access-denied");
            return;
        }
        
        chain.doFilter(request, response);
    }
}