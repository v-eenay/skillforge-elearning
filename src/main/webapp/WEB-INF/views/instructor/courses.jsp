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
    <jsp:include page="../common/header.jsp" />
    
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
                        <input type="text" class="form-control" placeholder="Search courses...">
                        <button class="btn btn-outline-secondary" type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                <div class="col-md-8 text-md-end">
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-outline-secondary active">All</button>
                        <button type="button" class="btn btn-outline-secondary">Published</button>
                        <button type="button" class="btn btn-outline-secondary">Drafts</button>
                    </div>
                    <div class="btn-group ms-2">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                            Sort By
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="#">Newest First</a></li>
                            <li><a class="dropdown-item" href="#">Oldest First</a></li>
                            <li><a class="dropdown-item" href="#">A-Z</a></li>
                            <li><a class="dropdown-item" href="#">Z-A</a></li>
                            <li><a class="dropdown-item" href="#">Most Students</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Courses Grid -->
        <div class="row">
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
            
            <!-- Sample Course Cards (These would be dynamically generated) -->
            <div class="col-md-4 mb-4">
                <div class="course-card">
                    <div class="course-thumbnail">
                        <img src="https://via.placeholder.com/300x180" alt="Course Thumbnail">
                        <span class="course-status status-active">Published</span>
                    </div>
                    <div class="course-content">
                        <h3 class="course-title">Advanced Java Programming</h3>
                        <div class="course-category">
                            <i class="fas fa-folder me-1"></i> Programming
                        </div>
                        <div class="course-stats">
                            <span><i class="fas fa-users me-1"></i> 45 students</span>
                            <span><i class="fas fa-star me-1"></i> 4.8 (24 reviews)</span>
                        </div>
                        <div class="course-actions">
                            <a href="#" class="btn btn-outline-primary">
                                <i class="fas fa-edit me-1"></i> Edit
                            </a>
                            <div class="dropdown">
                                <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-ellipsis-v"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="#"><i class="fas fa-eye"></i> Preview</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="fas fa-chart-bar"></i> Analytics</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="fas fa-users"></i> Students</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="fas fa-comments"></i> Discussions</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="#"><i class="fas fa-trash"></i> Delete</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4 mb-4">
                <div class="course-card">
                    <div class="course-thumbnail">
                        <img src="https://via.placeholder.com/300x180" alt="Course Thumbnail">
                        <span class="course-status status-draft">Draft</span>
                    </div>
                    <div class="course-content">
                        <h3 class="course-title">Web Development Fundamentals</h3>
                        <div class="course-category">
                            <i class="fas fa-folder me-1"></i> Web Development
                        </div>
                        <div class="course-stats">
                            <span><i class="fas fa-users me-1"></i> 0 students</span>
                            <span><i class="fas fa-clock me-1"></i> Last edited 2 days ago</span>
                        </div>
                        <div class="course-actions">
                            <a href="#" class="btn btn-outline-primary">
                                <i class="fas fa-edit me-1"></i> Edit
                            </a>
                            <div class="dropdown">
                                <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-ellipsis-v"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="#"><i class="fas fa-eye"></i> Preview</a></li>
                                    <li><a class="dropdown-item" href="#"><i class="fas fa-check-circle"></i> Publish</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="#"><i class="fas fa-trash"></i> Delete</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- If no courses are available, show this instead of the grid -->
            <c:if test="${empty courses}">
                <div class="no-courses" style="display: none;">
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
    <jsp:include page="../common/footer.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
