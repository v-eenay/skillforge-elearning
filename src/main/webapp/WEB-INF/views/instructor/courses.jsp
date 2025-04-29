<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Courses | Instructor | SkillForge</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/instructor-courses.css">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/common/header.jsp" />

    <!-- Courses Header -->
    <div class="courses-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-7">
                    <h1>My Courses</h1>
                    <p>Manage your courses and share your knowledge with students worldwide</p>
                </div>
                <div class="col-md-5 text-md-end">
                    <a href="${pageContext.request.contextPath}/instructor/courses/create" class="btn btn-primary">
                        <i class="fas fa-plus-circle me-2"></i><span>Create New Course</span>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container mb-5">
        <!-- Success Message -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show alert-message" role="alert">
                <i class="fas fa-check-circle me-2"></i> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session" />
        </c:if>

        <!-- Filters -->
        <div class="filters">
            <div class="row align-items-center">
                <div class="col-lg-4 col-md-5 mb-3 mb-md-0">
                    <div class="search-container">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" class="form-control" id="searchCourses" placeholder="Search your courses...">
                    </div>
                </div>
                <div class="col-lg-8 col-md-7">
                    <div class="d-flex flex-wrap justify-content-md-end">
                        <div class="filter-buttons me-md-3 mb-3 mb-md-0">
                            <button type="button" class="btn btn-primary filter-btn active" data-filter="all">
                                <i class="fas fa-th-large"></i> All Courses
                            </button>
                            <button type="button" class="btn btn-outline-secondary filter-btn" data-filter="published">
                                <i class="fas fa-check-circle"></i> Published
                            </button>
                            <button type="button" class="btn btn-outline-secondary filter-btn" data-filter="draft">
                                <i class="fas fa-pencil-alt"></i> Drafts
                            </button>
                        </div>
                        <div class="sort-dropdown">
                            <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" id="sortDropdown">
                                <i class="fas fa-sort-amount-down"></i> Sort By
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item sort-option" href="#" data-sort="newest"><i class="fas fa-calendar-alt"></i> Newest First</a></li>
                                <li><a class="dropdown-item sort-option" href="#" data-sort="oldest"><i class="fas fa-calendar"></i> Oldest First</a></li>
                                <li><a class="dropdown-item sort-option" href="#" data-sort="az"><i class="fas fa-sort-alpha-down"></i> A-Z</a></li>
                                <li><a class="dropdown-item sort-option" href="#" data-sort="za"><i class="fas fa-sort-alpha-up"></i> Z-A</a></li>
                                <li><a class="dropdown-item sort-option" href="#" data-sort="students"><i class="fas fa-users"></i> Most Students</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- No Results Message (hidden by default) -->
        <div id="noResults" class="alert alert-info text-center alert-message" style="display: none;">
            <i class="fas fa-search me-2"></i> No courses match your search criteria.
        </div>

        <!-- Courses Grid -->
        <div class="row" id="coursesContainer">
            <!-- Create Course Card -->
            <div class="col-lg-4 col-md-6 mb-4">
                <a href="${pageContext.request.contextPath}/instructor/courses/create" class="text-decoration-none">
                    <div class="create-course-card">
                        <i class="fas fa-plus-circle"></i>
                        <h4>Create New Course</h4>
                        <p>Share your expertise and knowledge with students around the world</p>
                        <button class="btn btn-primary">
                            <i class="fas fa-rocket me-2"></i> Get Started
                        </button>
                    </div>
                </a>
            </div>

            <!-- Dynamic Course Cards -->
            <c:forEach items="${courses}" var="course">
                <div class="col-lg-4 col-md-6 mb-4 course-item" data-status="${course.status}" data-created="${course.createdAt}" data-students="0">
                    <div class="course-card">
                        <div class="course-thumbnail">
                            <c:choose>
                                <c:when test="${not empty course.thumbnail}">
                                    <img src="${pageContext.request.contextPath}${course.thumbnail.startsWith('/') ? '' : '/'}${course.thumbnail}" alt="${course.title}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/course-thumbnail.svg';">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/images/course-thumbnail.svg" alt="${course.title}">
                                </c:otherwise>
                            </c:choose>
                            <span class="course-status status-${course.status.toString().toLowerCase()}">
                                <c:choose>
                                    <c:when test="${course.status == 'active'}">Published</c:when>
                                    <c:when test="${course.status == 'inactive'}">Inactive</c:when>
                                    <c:otherwise>Draft</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="course-content">
                            <h3 class="course-title">
                                <a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}" class="text-decoration-none text-dark">
                                    ${course.title}
                                </a>
                            </h3>
                            <div class="course-category">
                                <i class="fas fa-tag"></i> ${course.category.name}
                            </div>
                            <div class="course-stats">
                                <span><i class="fas fa-users"></i> 0 students</span>
                                <span><i class="fas fa-calendar-alt"></i> ${course.createdAt}</span>
                            </div>
                            <div class="course-actions">
                                <a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}" class="btn btn-outline-secondary">
                                    <i class="fas fa-eye me-1"></i> View
                                </a>
                                <a href="${pageContext.request.contextPath}/instructor/courses/edit?id=${course.courseId}" class="btn btn-outline-primary">
                                    <i class="fas fa-edit me-1"></i> Edit
                                </a>
                                <div class="dropdown">
                                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                        <i class="fas fa-ellipsis-v"></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}"><i class="fas fa-eye"></i> View Details</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/courses/view?id=${course.courseId}"><i class="fas fa-external-link-alt"></i> Preview as Student</a></li>

                                        <c:choose>
                                            <c:when test="${course.status == 'active'}">
                                                <li><a class="dropdown-item" href="#"><i class="fas fa-chart-bar"></i> Analytics</a></li>
                                                <li><a class="dropdown-item" href="#"><i class="fas fa-users"></i> Students</a></li>
                                                <li><a class="dropdown-item" href="#"><i class="fas fa-comments"></i> Discussions</a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item text-warning" href="${pageContext.request.contextPath}/instructor/courses/toggle-status?id=${course.courseId}"><i class="fas fa-pause-circle"></i> Unpublish</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/instructor/courses/toggle-status?id=${course.courseId}"><i class="fas fa-check-circle"></i> Publish</a></li>
                                            </c:otherwise>
                                        </c:choose>

                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item text-danger" href="#"><i class="fas fa-trash"></i> Delete</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- If no courses are available, show this instead of the grid -->
            <c:if test="${empty courses}">
                <div class="no-courses">
                    <i class="fas fa-graduation-cap"></i>
                    <h3>No Courses Yet</h3>
                    <p>You haven't created any courses yet. Start sharing your knowledge and expertise with students around the world!</p>
                    <a href="${pageContext.request.contextPath}/instructor/courses/create" class="btn btn-primary">
                        <i class="fas fa-plus-circle me-2"></i>Create Your First Course
                    </a>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/common/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Instructor JS -->
    <script src="${pageContext.request.contextPath}/assets/js/instructor.js"></script>
</body>
</html>
