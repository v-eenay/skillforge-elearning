<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructor Dashboard | SkillForge</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .dashboard-card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        
        .dashboard-card .card-body {
            padding: 25px;
        }
        
        .dashboard-card .card-title {
            font-weight: 600;
            margin-bottom: 15px;
            color: #4e73df;
        }
        
        .dashboard-card .card-text {
            color: #6c757d;
            margin-bottom: 20px;
        }
        
        .dashboard-card .btn {
            border-radius: 5px;
            padding: 8px 20px;
            font-weight: 500;
        }
        
        .dashboard-card .card-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: #4e73df;
        }
        
        .stats-card {
            border-left: 4px solid;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 20px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }
        
        .stats-card.primary {
            border-left-color: #4e73df;
        }
        
        .stats-card.success {
            border-left-color: #1cc88a;
        }
        
        .stats-card.info {
            border-left-color: #36b9cc;
        }
        
        .stats-card.warning {
            border-left-color: #f6c23e;
        }
        
        .stats-card .stats-title {
            text-transform: uppercase;
            font-size: 0.8rem;
            font-weight: 600;
            color: #6c757d;
            margin-bottom: 5px;
        }
        
        .stats-card .stats-value {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0;
        }
        
        .stats-card.primary .stats-value {
            color: #4e73df;
        }
        
        .stats-card.success .stats-value {
            color: #1cc88a;
        }
        
        .stats-card.info .stats-value {
            color: #36b9cc;
        }
        
        .stats-card.warning .stats-value {
            color: #f6c23e;
        }
        
        .welcome-banner {
            background-color: #4e73df;
            color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        
        .welcome-banner h2 {
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .welcome-banner p {
            opacity: 0.9;
            margin-bottom: 20px;
        }
        
        .welcome-banner .btn {
            background-color: white;
            color: #4e73df;
            font-weight: 600;
            padding: 8px 20px;
            border-radius: 5px;
        }
        
        .welcome-banner .btn:hover {
            background-color: #f8f9fa;
        }
        
        .recent-activity {
            margin-top: 30px;
        }
        
        .activity-item {
            padding: 15px;
            border-left: 3px solid #4e73df;
            background-color: white;
            margin-bottom: 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }
        
        .activity-item .activity-time {
            font-size: 0.8rem;
            color: #6c757d;
        }
        
        .activity-item .activity-title {
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .activity-item .activity-description {
            color: #6c757d;
            margin-bottom: 0;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-5 mb-5">
        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2>Welcome back, ${user.name}!</h2>
                    <p>Manage your courses, track student progress, and create engaging content all from your instructor dashboard.</p>
                </div>
                <div class="col-md-4 text-md-end">
                    <a href="${pageContext.request.contextPath}/instructor/courses/create" class="btn">Create New Course</a>
                </div>
            </div>
        </div>
        
        <!-- Stats Row -->
        <div class="row">
            <div class="col-md-3">
                <div class="stats-card primary">
                    <div class="stats-title">Total Courses</div>
                    <div class="stats-value">5</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card success">
                    <div class="stats-title">Total Students</div>
                    <div class="stats-value">128</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card info">
                    <div class="stats-title">Course Completion</div>
                    <div class="stats-value">76%</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card warning">
                    <div class="stats-title">Average Rating</div>
                    <div class="stats-value">4.7</div>
                </div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <h3 class="mt-5 mb-4">Quick Actions</h3>
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card dashboard-card">
                    <div class="card-body text-center">
                        <i class="fas fa-book card-icon"></i>
                        <h5 class="card-title">Manage Courses</h5>
                        <p class="card-text">View, edit, and manage all your courses in one place.</p>
                        <a href="${pageContext.request.contextPath}/instructor/courses" class="btn btn-primary">Go to Courses</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card dashboard-card">
                    <div class="card-body text-center">
                        <i class="fas fa-plus-circle card-icon"></i>
                        <h5 class="card-title">Create New Course</h5>
                        <p class="card-text">Start building a new course with our easy-to-use course creator.</p>
                        <a href="${pageContext.request.contextPath}/instructor/courses/create" class="btn btn-success">Create Course</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card dashboard-card">
                    <div class="card-body text-center">
                        <i class="fas fa-users card-icon"></i>
                        <h5 class="card-title">Student Management</h5>
                        <p class="card-text">View student progress and manage enrollments.</p>
                        <a href="${pageContext.request.contextPath}/instructor/students" class="btn btn-info">Manage Students</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Recent Activity -->
        <div class="recent-activity">
            <h3 class="mb-4">Recent Activity</h3>
            <div class="activity-item">
                <div class="activity-time">Today, 10:30 AM</div>
                <div class="activity-title">New Student Enrolled</div>
                <div class="activity-description">John Doe enrolled in "Advanced Java Programming"</div>
            </div>
            <div class="activity-item">
                <div class="activity-time">Yesterday, 3:45 PM</div>
                <div class="activity-title">Course Update</div>
                <div class="activity-description">You updated the content in "Web Development Fundamentals"</div>
            </div>
            <div class="activity-item">
                <div class="activity-time">May 15, 2023</div>
                <div class="activity-title">New Review</div>
                <div class="activity-description">Sarah Johnson left a 5-star review on "Python for Data Science"</div>
            </div>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="../common/footer.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
