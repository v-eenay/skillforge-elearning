<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="SkillForge Logo" height="40">
                SkillForge
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/courses">Courses</a>
                    </li>
                    <c:if test="${user.role == 'instructor'}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="instructorDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Instructor
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="instructorDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/instructor">Dashboard</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/instructor/courses">My Courses</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/instructor/courses/create">Create Course</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/instructor/students">Students</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/instructor/earnings">Earnings</a></li>
                            </ul>
                        </li>
                    </c:if>
                    <c:if test="${user.role == 'admin'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin">Admin</a>
                        </li>
                    </c:if>
                </ul>
                
                <div class="d-flex align-items-center">
                    <c:choose>
                        <c:when test="${empty user}">
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary me-2">Log In</a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Sign Up</a>
                        </c:when>
                        <c:otherwise>
                            <div class="dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <c:choose>
                                        <c:when test="${not empty user.profileImage}">
                                            <img src="${user.profileImage}" alt="Profile" class="rounded-circle me-2" width="32" height="32">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px;">
                                                ${fn:substring(user.name, 0, 1)}
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    ${user.name}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">My Profile</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/settings">Settings</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                                </ul>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
</header>
