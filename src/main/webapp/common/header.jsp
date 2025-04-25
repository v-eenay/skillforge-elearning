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
    <link href="${pageContext.request.contextPath}/assets/css/header-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/modern-header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/modern-footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/modern-profile.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/messages.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/modern-home.css" rel="stylesheet">
</head>
<body>
    <header class="modern-header">
        <div class="container">
            <div class="row align-items-center w-100">
                <div class="col-md-4 col-6 d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                        <img src="${pageContext.request.contextPath}/assets/images/logo.svg" alt="SkillForge Logo">
                    </a>
                    <button class="mobile-menu-toggle ms-auto d-md-none">
                        <i class="fas fa-bars"></i>
                    </button>
                </div>
                <div class="col-md-8 col-6">
                    <nav class="d-flex justify-content-end">
                        <ul class="nav nav-desktop">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/" class="nav-link <%= request.getRequestURI().equals("/") || request.getRequestURI().equals("/index.jsp") ? "active" : "" %>">Home</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/courses" class="nav-link <%= request.getRequestURI().contains("/courses") ? "active" : "" %>">Courses</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/instructors" class="nav-link <%= request.getRequestURI().contains("/instructors") ? "active" : "" %>">Instructors</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/about" class="nav-link <%= request.getRequestURI().contains("/about") ? "active" : "" %>">About</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/contact" class="nav-link <%= request.getRequestURI().contains("/contact") ? "active" : "" %>">Contact</a>
                            </li>
                            <% if (session.getAttribute("user") == null) { %>
                                <li class="nav-item ms-3"><a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline-primary btn-sm">Login</a></li>
                                <li class="nav-item ms-2"><a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary btn-sm">Sign Up</a></li>
                            <% } else { %>
                                <%
                                    com.example.skillforge.models.user.UserModel headerUser = (com.example.skillforge.models.user.UserModel) session.getAttribute("user");
                                    String profileImage = headerUser.getProfileImage();
                                    String userName = headerUser.getUserName();
                                    String userRole = (String) session.getAttribute("userRole");
                                    String currentURI = request.getRequestURI();
                                    String contextPath = request.getContextPath();
                                %>
                                <li class="nav-item">
                                    <div class="header-icons-container">
                                        <div class="header-icons">
                                        <% if ("admin".equals(userRole)) { %>
                                            <!-- Admin Icons -->
                                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="header-icon-link <%= currentURI.startsWith(contextPath + "/admin/dashboard") ? "active" : "" %>">
                                                <i class="fas fa-tachometer-alt"></i>
                                                <span class="icon-tooltip">Dashboard</span>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/users" class="header-icon-link <%= currentURI.startsWith(contextPath + "/admin/users") ? "active" : "" %>">
                                                <i class="fas fa-users"></i>
                                                <span class="icon-tooltip">Manage Users</span>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/messages" class="header-icon-link <%= currentURI.startsWith(contextPath + "/admin/messages") ? "active" : "" %>">
                                                <i class="fas fa-envelope"></i>
                                                <span class="badge">3</span>
                                                <span class="icon-tooltip">Messages</span>
                                            </a>
                                        <% } else if ("instructor".equals(userRole)) { %>
                                            <!-- Instructor Icons -->
                                            <a href="${pageContext.request.contextPath}/instructor/dashboard" class="header-icon-link <%= currentURI.startsWith(contextPath + "/instructor/dashboard") ? "active" : "" %>">
                                                <i class="fas fa-tachometer-alt"></i>
                                                <span class="icon-tooltip">Dashboard</span>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/instructor/courses/" class="header-icon-link <%= (currentURI.startsWith(contextPath + "/instructor/courses") || currentURI.startsWith(contextPath + "/instructor/course")) ? "active" : "" %>">
                                                <i class="fas fa-book"></i>
                                                <span class="icon-tooltip">My Courses</span>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/instructor/messages" class="header-icon-link <%= currentURI.startsWith(contextPath + "/instructor/messages") ? "active" : "" %>">
                                                <i class="fas fa-envelope"></i>
                                                <span class="badge">5</span>
                                                <span class="icon-tooltip">Messages</span>
                                            </a>
                                        <% } else { %>
                                            <!-- Student Icons -->
                                            <a href="${pageContext.request.contextPath}/student/dashboard" class="header-icon-link <%= currentURI.startsWith(contextPath + "/student/dashboard") ? "active" : "" %>">
                                                <i class="fas fa-tachometer-alt"></i>
                                                <span class="icon-tooltip">Dashboard</span>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/student/courses" class="header-icon-link <%= currentURI.startsWith(contextPath + "/student/courses") ? "active" : "" %>">
                                                <i class="fas fa-book"></i>
                                                <span class="icon-tooltip">My Courses</span>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/student/messages" class="header-icon-link <%= currentURI.startsWith(contextPath + "/student/messages") ? "active" : "" %>">
                                                <i class="fas fa-envelope"></i>
                                                <span class="badge">2</span>
                                                <span class="icon-tooltip">Messages</span>
                                            </a>
                                        <% } %>

                                        <!-- Profile Icon (for all users) -->
                                        <a href="${pageContext.request.contextPath}/<%= userRole %>/profile" class="header-icon-link <%= currentURI.startsWith(contextPath + "/" + userRole + "/profile") ? "active" : "" %>">
                                            <% if (profileImage != null && !profileImage.isEmpty()) { %>
                                                <img src="${pageContext.request.contextPath}<%= profileImage.startsWith("/") ? "" : "/" %><%= profileImage %>" alt="Profile" class="user-avatar" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-profile.svg';">
                                            <% } else { %>
                                                <img src="${pageContext.request.contextPath}/assets/images/default-profile.svg" alt="Default Profile" class="user-avatar">
                                            <% } %>
                                            <span class="icon-tooltip">Profile</span>
                                        </a>

                                        <!-- Logout Icon (for all users) -->
                                        <a href="${pageContext.request.contextPath}/auth/logout" class="header-icon-link">
                                            <i class="fas fa-sign-out-alt"></i>
                                            <span class="icon-tooltip">Logout</span>
                                        </a>
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

    <!-- Header JavaScript -->
    <script>
        // Use a more efficient way to handle scroll events with requestAnimationFrame
        let scrollTimeout;
        let lastKnownScrollPosition = 0;
        let ticking = false;

        function handleScroll(scrollPos) {
            const header = document.querySelector('.modern-header');
            if (scrollPos > 10) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        }

        // Wait for the page to fully load before adding event listeners
        window.addEventListener('load', function() {
            // Initial check for scroll position
            handleScroll(window.scrollY);

            // Throttled scroll event
            window.addEventListener('scroll', function() {
                lastKnownScrollPosition = window.scrollY;

                if (!ticking) {
                    window.requestAnimationFrame(function() {
                        handleScroll(lastKnownScrollPosition);
                        ticking = false;
                    });

                    ticking = true;
                }
            }, { passive: true });

            // Mobile menu toggle
            const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
            if (mobileMenuToggle) {
                mobileMenuToggle.addEventListener('click', function() {
                    const header = document.querySelector('.modern-header');
                    header.classList.toggle('mobile-menu-open');
                });
            }
        });
    </script>

    <main>