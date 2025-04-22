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
    <style>
        .courses-header {
            background-color: #f8f9fa;
            padding: 30px 0;
            margin-bottom: 30px;
            border-bottom: 1px solid #e9ecef;
        }

        .course-card {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 30px;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }

        .course-thumbnail {
            height: 180px;
            overflow: hidden;
            position: relative;
        }

        .course-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .course-card:hover .course-thumbnail img {
            transform: scale(1.05);
        }

        .course-status {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-draft {
            background-color: #f8f9fa;
            color: #6c757d;
        }

        .status-active {
            background-color: #d4edda;
            color: #155724;
        }

        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }

        .course-content {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .course-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: #343a40;
        }

        .course-category {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 10px;
        }

        .course-stats {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 0.9rem;
            color: #6c757d;
        }

        .course-actions {
            margin-top: auto;
            display: flex;
            justify-content: space-between;
        }

        .course-actions .btn {
            padding: 6px 12px;
            font-size: 0.9rem;
        }

        .course-actions .dropdown-menu {
            min-width: 200px;
        }

        .course-actions .dropdown-item {
            padding: 8px 15px;
        }

        .course-actions .dropdown-item i {
            width: 20px;
            text-align: center;
            margin-right: 5px;
        }

        .create-course-card {
            border: 2px dashed #dee2e6;
            border-radius: 10px;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .create-course-card:hover {
            border-color: #4e73df;
            background-color: #f8f9fa;
        }

        .create-course-card i {
            font-size: 3rem;
            color: #4e73df;
            margin-bottom: 15px;
        }

        .create-course-card h4 {
            color: #343a40;
            margin-bottom: 10px;
        }

        .create-course-card p {
            color: #6c757d;
            margin-bottom: 20px;
        }

        .filters {
            margin-bottom: 30px;
        }

        .alert-message {
            margin-bottom: 30px;
        }

        .no-courses {
            text-align: center;
            padding: 50px 0;
            background-color: #f8f9fa;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        .no-courses i {
            font-size: 3rem;
            color: #6c757d;
            margin-bottom: 20px;
        }

        .no-courses h3 {
            color: #343a40;
            margin-bottom: 10px;
        }

        .no-courses p {
            color: #6c757d;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/common/header.jsp" />

    <!-- Courses Header -->
    <div class="courses-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h1>My Courses</h1>
                    <p class="text-muted">Manage and create courses as an instructor</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="${pageContext.request.contextPath}/instructor/courses/create" class="btn btn-primary">
                        <i class="fas fa-plus-circle me-2"></i>Create New Course
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container mb-5">
        <!-- Success Message -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show alert-message" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session" />
        </c:if>

        <!-- Filters -->
        <div class="filters">
            <div class="row">
                <div class="col-md-4">
                    <div class="input-group">
                        <input type="text" class="form-control" id="searchCourses" placeholder="Search courses...">
                        <button class="btn btn-outline-secondary" type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                <div class="col-md-8 text-md-end">
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-primary filter-btn active" data-filter="all">All</button>
                        <button type="button" class="btn btn-outline-secondary filter-btn" data-filter="published">Published</button>
                        <button type="button" class="btn btn-outline-secondary filter-btn" data-filter="draft">Drafts</button>
                    </div>
                    <div class="btn-group ms-2">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" id="sortDropdown">
                            Sort By
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item sort-option" href="#" data-sort="newest">Newest First</a></li>
                            <li><a class="dropdown-item sort-option" href="#" data-sort="oldest">Oldest First</a></li>
                            <li><a class="dropdown-item sort-option" href="#" data-sort="az">A-Z</a></li>
                            <li><a class="dropdown-item sort-option" href="#" data-sort="za">Z-A</a></li>
                            <li><a class="dropdown-item sort-option" href="#" data-sort="students">Most Students</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- No Results Message (hidden by default) -->
        <div id="noResults" class="alert alert-info text-center" style="display: none;">
            <i class="fas fa-search me-2"></i> No courses match your search criteria.
        </div>

        <!-- Courses Grid -->
        <div class="row" id="coursesContainer">
            <!-- Create Course Card -->
            <div class="col-md-4 mb-4">
                <a href="${pageContext.request.contextPath}/instructor/courses/create" class="text-decoration-none">
                    <div class="create-course-card">
                        <i class="fas fa-plus-circle"></i>
                        <h4>Create New Course</h4>
                        <p>Share your knowledge and skills with students around the world</p>
                        <button class="btn btn-primary">Get Started</button>
                    </div>
                </a>
            </div>

            <!-- Dynamic Course Cards -->
            <c:forEach items="${courses}" var="course">
                <div class="col-md-4 mb-4 course-item" data-status="${course.status}" data-created="${course.createdAt}" data-students="0">
                    <div class="course-card">
                        <div class="course-thumbnail">
                            <c:choose>
                                <c:when test="${not empty course.thumbnail}">
                                    <img src="${pageContext.request.contextPath}${course.thumbnail}" alt="${course.title}">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://placebeard.it/300/180?image=${course.courseId % 10 + 1}" alt="${course.title}">
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
                                <i class="fas fa-folder me-1"></i> ${course.category.name}
                            </div>
                            <div class="course-stats">
                                <span><i class="fas fa-users me-1"></i> 0 students</span>
                                <span><i class="fas fa-clock me-1"></i> Created ${course.createdAt}</span>
                            </div>
                            <div class="course-actions">
                                <a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}" class="btn btn-outline-secondary me-1">
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
                    <i class="fas fa-book"></i>
                    <h3>No courses yet</h3>
                    <p>You haven't created any courses yet. Start sharing your knowledge today!</p>
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
