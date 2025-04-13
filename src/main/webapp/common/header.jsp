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
    <style>
        /* Custom dropdown styles */
        .custom-dropdown {
            position: relative;
            display: inline-block;
        }

        .custom-dropdown-menu {
            display: none;
            position: absolute;
            right: 0;
            top: 100%;
            background-color: #fff;
            min-width: 200px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            z-index: 9999;
            border-radius: 0.25rem;
            border: 1px solid rgba(0, 0, 0, 0.15);
            padding: 0.5rem 0;
            margin-top: 0.5rem;
        }

        .custom-dropdown-item {
            display: block;
            width: 100%;
            padding: 0.5rem 1rem;
            clear: both;
            font-weight: 400;
            color: #212529;
            text-align: inherit;
            text-decoration: none;
            white-space: nowrap;
            background-color: transparent;
            border: 0;
        }

        .custom-dropdown-item:hover {
            background-color: #f8f9fa;
            color: #16181b;
        }

        .custom-dropdown-divider {
            height: 0;
            margin: 0.5rem 0;
            overflow: hidden;
            border-top: 1px solid #e9ecef;
        }

        .custom-dropdown-item.danger {
            color: #dc3545;
        }

        .custom-dropdown-item.danger:hover {
            background-color: #f8d7da;
        }

        /* Show the dropdown menu when the parent has the show class */
        .custom-dropdown.show .custom-dropdown-menu {
            display: block;
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
                                <li class="nav-item ms-3">
                                    <div class="custom-dropdown" id="profileDropdownContainer">
                                        <a class="nav-link d-flex align-items-center" href="#" id="profileDropdownToggle">
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
                                            <i class="fas fa-chevron-down ms-2" style="font-size: 0.75rem;"></i>
                                        </a>
                                        <div class="custom-dropdown-menu" id="profileDropdownMenu">
                                            <% String userRole = (String) session.getAttribute("userRole"); %>
                                            <% if ("admin".equals(userRole)) { %>
                                                <a class="custom-dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                                                <a class="custom-dropdown-item" href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users me-2"></i>Manage Users</a>
                                            <% } else if ("instructor".equals(userRole)) { %>
                                                <a class="custom-dropdown-item" href="${pageContext.request.contextPath}/instructor/dashboard"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                                                <a class="custom-dropdown-item" href="${pageContext.request.contextPath}/instructor/profile"><i class="fas fa-user me-2"></i>My Profile</a>
                                            <% } else { %>
                                                <a class="custom-dropdown-item" href="${pageContext.request.contextPath}/student/dashboard"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                                                <a class="custom-dropdown-item" href="${pageContext.request.contextPath}/student/profile"><i class="fas fa-user me-2"></i>My Profile</a>
                                            <% } %>
                                            <div class="custom-dropdown-divider"></div>
                                            <a class="custom-dropdown-item danger" href="${pageContext.request.contextPath}/auth/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
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

    <script>
        // Execute immediately to ensure dropdown functionality
        (function() {
            // Disable Bootstrap's built-in dropdown for our custom one
            if (typeof bootstrap !== 'undefined') {
                var bsDropdowns = [].slice.call(document.querySelectorAll('.custom-dropdown'));
                bsDropdowns.forEach(function(dropdown) {
                    var bsDropdown = bootstrap.Dropdown.getInstance(dropdown);
                    if (bsDropdown) {
                        bsDropdown.dispose();
                    }
                });
            }

            // Setup our custom dropdown when DOM is ready
            document.addEventListener('DOMContentLoaded', function() {
                const dropdownToggle = document.getElementById('profileDropdownToggle');
                const dropdownContainer = document.getElementById('profileDropdownContainer');
                const dropdownMenu = document.getElementById('profileDropdownMenu');

                if (dropdownToggle && dropdownContainer && dropdownMenu) {
                    // Toggle dropdown on click
                    dropdownToggle.addEventListener('click', function(e) {
                        e.preventDefault();
                        e.stopPropagation();
                        dropdownContainer.classList.toggle('show');
                    });

                    // Close dropdown when clicking outside
                    document.addEventListener('click', function(e) {
                        if (!dropdownContainer.contains(e.target)) {
                            dropdownContainer.classList.remove('show');
                        }
                    });

                    // Prevent dropdown from closing when clicking inside it
                    dropdownMenu.addEventListener('click', function(e) {
                        // Only prevent propagation if not clicking on a link
                        if (!e.target.closest('a')) {
                            e.stopPropagation();
                        }
                    });
                }
            });
        })();
    </script>
    <main>