<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
    <div class="position-sticky pt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.endsWith('/admin-dashboard.jsp') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt me-2"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.endsWith('/user-management.jsp') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users me-2"></i>
                    User Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.endsWith('/contacts.jsp') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/contacts">
                    <i class="fas fa-envelope me-2"></i>
                    Contact Messages
                </a>
            </li>
        </ul>
        
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>System</span>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.endsWith('/database-setup.jsp') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/setup-database">
                    <i class="fas fa-database me-2"></i>
                    Database Setup
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${pageContext.request.servletPath.endsWith('/initialize-categories.jsp') ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/initialize-categories">
                    <i class="fas fa-tags me-2"></i>
                    Initialize Categories
                </a>
            </li>
        </ul>
    </div>
</nav>
