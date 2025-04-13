<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillForge - Learn from Industry Experts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/modern.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/auth.css" rel="stylesheet">
    <style>
        .dropdown-menu {
            z-index: 1030;
            position: absolute;
            background-color: #fff;
            border: 1px solid rgba(0,0,0,.15);
            border-radius: 0.25rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            overflow: hidden;
            width: max-content;
            min-width: 10rem;
        }
        .nav-item.dropdown {
            position: relative;
        }
        .dropdown-item {
            display: block;
            width: 100%;
            padding: 0.5rem 1rem;
            clear: both;
            text-align: inherit;
            white-space: nowrap;
            background-color: transparent;
        }
    </style>
</head>
<body>
    <header class="navbar py-3 shadow-sm">
        <div class="container">
            <div class="row align-items-center w-100">
                <div class="col-md-4">
                    <h1 class="mb-0"><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-gradient fw-bold">SkillForge</a></h1>
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
                                <li class="nav-item ms-3 dropdown">
                                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <%
                                            com.example.skillforge.models.UserModel headerUser = (com.example.skillforge.models.UserModel) session.getAttribute("user");
                                            String profileImage = headerUser.getProfileImage();
                                            String userName = headerUser.getUserName();
                                            String firstLetter = headerUser.getName().substring(0, 1);
                                        %>
                                        <% if (profileImage != null && !profileImage.isEmpty()) { %>
                                            <img src="${pageContext.request.contextPath}<%= profileImage %>" alt="Profile" class="rounded-circle me-2" width="32" height="32" style="object-fit: cover;">
                                        <% } else { %>
                                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px; font-size: 0.9rem;">
                                                <%= firstLetter %>
                                            </div>
                                        <% } %>
                                        <span><%= userName %></span>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown" style="position: absolute; top: 100%; right: 0;">
                                        <div class="py-2">
                                            <% String userRole = (String) session.getAttribute("userRole"); %>
                                            <% if ("admin".equals(userRole)) { %>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users me-2"></i>Manage Users</a>
                                            <% } else if ("instructor".equals(userRole)) { %>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/instructor/dashboard"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/instructor/profile"><i class="fas fa-user me-2"></i>My Profile</a>
                                            <% } else { %>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/student/dashboard"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/student/profile"><i class="fas fa-user me-2"></i>My Profile</a>
                                            <% } %>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
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
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Fix dropdown menu behavior
            const profileDropdown = document.getElementById('profileDropdown');
            if (profileDropdown) {
                const dropdownMenu = profileDropdown.nextElementSibling;

                // Ensure dropdown is properly hidden initially
                dropdownMenu.style.display = 'none';

                // Toggle dropdown on click
                profileDropdown.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();

                    if (dropdownMenu.style.display === 'none') {
                        dropdownMenu.style.display = 'block';
                    } else {
                        dropdownMenu.style.display = 'none';
                    }
                });

                // Close dropdown when clicking outside
                document.addEventListener('click', function(e) {
                    if (!profileDropdown.contains(e.target) && !dropdownMenu.contains(e.target)) {
                        dropdownMenu.style.display = 'none';
                    }
                });
            }
        });
    </script>
    <main>