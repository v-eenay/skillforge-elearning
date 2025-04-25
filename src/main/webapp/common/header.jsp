<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillForge - Learn from Industry Experts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/modern.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/auth.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/dropdown.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/dashboard.css" rel="stylesheet">
</head>
<body>
    <header class="navbar py-3 shadow-sm" style="position: relative; z-index: 1; overflow: visible;">
        <div class="container">
            <div class="row align-items-center w-100">
                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                        <img src="${pageContext.request.contextPath}/assets/images/logo.svg" alt="SkillForge Logo" height="30">
                    </a>
                </div>
                <div class="col-md-8">
                    <nav class="d-flex justify-content-end">
                        <ul class="nav">
                            <li class="nav-item"><a href="${pageContext.request.contextPath}/" class="nav-link">Home</a></li>
                            <li class="nav-item"><a href="${pageContext.request.contextPath}/courses" class="nav-link">Courses</a></li>
                            <li class="nav-item"><a href="${pageContext.request.contextPath}/instructors" class="nav-link">Instructors</a></li>
                            <li class="nav-item"><a href="${pageContext.request.contextPath}/about" class="nav-link">About</a></li>
                            <li class="nav-item"><a href="${pageContext.request.contextPath}/contact" class="nav-link">Contact</a></li>
                            <% if (session.getAttribute("user") == null) { %>
                                <li class="nav-item ms-3"><a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline-primary btn-sm rounded-pill">Login</a></li>
                                <li class="nav-item ms-2"><a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary btn-sm rounded-pill">Sign Up</a></li>
                            <% } else { %>
                                <li class="nav-item ms-3" style="position: relative; z-index: 99999;">
                                    <div class="profile-dropdown" id="profileDropdownContainer" style="position: relative; z-index: 99999;">
                                        <a class="profile-dropdown-toggle" href="#" id="profileDropdownToggle">
                                            <%
                                                com.example.skillforge.models.user.UserModel headerUser = (com.example.skillforge.models.user.UserModel) session.getAttribute("user");
                                                String profileImage = headerUser.getProfileImage();
                                                String userName = headerUser.getUserName();
                                                String firstLetter = headerUser.getName().substring(0, 1);
                                            %>
                                            <% if (profileImage != null && !profileImage.isEmpty()) { %>
                                                <img src="${pageContext.request.contextPath}<%= profileImage.startsWith("/") ? "" : "/" %><%= profileImage %>" alt="Profile" class="profile-image" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-profile.svg';">
                                            <% } else { %>
                                                <img src="${pageContext.request.contextPath}/assets/images/default-profile.svg" alt="Default Profile" class="profile-image">
                                            <% } %>
                                            <span class="profile-name"><%= userName %></span>
                                            <i class="fas fa-chevron-down dropdown-icon"></i>
                                        </a>
                                        <div class="profile-dropdown-menu" id="profileDropdownMenu" style="z-index: 100000;">
                                            <% String userRole = (String) session.getAttribute("userRole"); %>
                                            <% if ("admin".equals(userRole)) { %>
                                                <a class="profile-dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                                                <a class="profile-dropdown-item" href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i>Manage Users</a>
                                            <% } else if ("instructor".equals(userRole)) { %>
                                                <a class="profile-dropdown-item" href="${pageContext.request.contextPath}/instructor/dashboard"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                                                <a class="profile-dropdown-item" href="${pageContext.request.contextPath}/instructor/courses/"><i class="fas fa-book"></i>My Courses</a>
                                                <a class="profile-dropdown-item" href="${pageContext.request.contextPath}/instructor/profile"><i class="fas fa-user"></i>My Profile</a>
                                            <% } else { %>
                                                <a class="profile-dropdown-item" href="${pageContext.request.contextPath}/student/dashboard"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                                                <a class="profile-dropdown-item" href="${pageContext.request.contextPath}/student/profile"><i class="fas fa-user"></i>My Profile</a>
                                            <% } %>
                                            <div class="profile-dropdown-divider"></div>
                                            <a class="profile-dropdown-item danger" href="${pageContext.request.contextPath}/auth/logout"><i class="fas fa-sign-out-alt"></i>Logout</a>
                                        </div>
                                    </div>
                                </li>
                            <% } %>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- Load Bootstrap JS early to avoid conflicts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/dropdown.js"></script>
    <main>