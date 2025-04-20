<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/header.jsp" %>

<div class="dashboard-container">
    <div class="container">
        <div class="row dashboard-header">
            <div class="col-md-8">
                <h2>Instructor Dashboard</h2>
                <p>Welcome back, ${user.name}! Manage your courses and track student performance.</p>
            </div>
            <div class="col-md-4">
                <div class="dashboard-actions">
                    <button class="btn btn-outline-primary">
                        <i class="fas fa-envelope"></i> Messages <span class="badge bg-danger">5</span>
                    </button>
                    <a href="${pageContext.request.contextPath}/instructor/profile" class="btn btn-outline-primary">
                        <i class="fas fa-user"></i> My Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/instructor/courses/create" class="btn btn-primary">
                        <i class="fas fa-plus-circle"></i> Create Course
                    </a>
                </div>
            </div>
        </div>

    <!-- Stats Overview -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-primary text-white">
                <div class="card-body">
                    <h5 class="card-title">Active Courses</h5>
                    <h2 class="display-4">${activeCourses}</h2>
                    <p class="card-text"><i class="fas fa-book"></i> ${totalCourses} total courses</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title">Total Students</h5>
                    <h2 class="display-4">247</h2>
                    <p class="card-text"><i class="fas fa-arrow-up"></i> 12% from last month</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title">Course Rating</h5>
                    <h2 class="display-4">4.8</h2>
                    <p class="card-text"><i class="fas fa-star"></i> Based on 183 reviews</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-warning text-white">
                <div class="card-body">
                    <h5 class="card-title">Earnings</h5>
                    <h2 class="display-4">$3.2K</h2>
                    <p class="card-text"><i class="fas fa-dollar-sign"></i> This month</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Course Management -->
        <div class="col-md-8 mb-4">
            <div class="content-card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5>My Courses</h5>
                    <div class="filter-buttons">
                        <button class="btn btn-sm btn-outline-secondary">All</button>
                        <button class="btn btn-sm btn-primary">Published</button>
                        <button class="btn btn-sm btn-outline-secondary">Draft</button>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Course 1 -->
                    <c:choose>
                        <c:when test="${empty courses}">
                            <div class="text-center p-4">
                                <p class="text-muted">You haven't created any courses yet.</p>
                                <a href="${pageContext.request.contextPath}/instructor/courses/create" class="btn btn-primary">Create Your First Course</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${courses}" var="course" varStatus="loop" begin="0" end="3">
                                <div class="d-flex ${!loop.last ? 'mb-3 p-3 border-bottom' : 'p-3'}">
                                    <c:choose>
                                        <c:when test="${not empty course.thumbnail}">
                                            <img src="${pageContext.request.contextPath}${course.thumbnail}" class="me-3" alt="${course.title}" style="object-fit: cover; width: 100px; height: 70px;">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://placebeard.it/100/70?image=${course.courseId % 10 + 45}" class="me-3" alt="${course.title}" style="object-fit: cover;">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="flex-grow-1">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <h5 class="mb-1">
                                                    <a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}" class="text-decoration-none text-dark">
                                                        ${course.title}
                                                    </a>
                                                </h5>
                                                <div class="d-flex align-items-center">
                                                    <c:choose>
                                                        <c:when test="${course.status == 'active'}">
                                                            <span class="badge bg-success me-2">Published</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary me-2">Draft</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <small class="text-muted">Created: ${course.createdAt}</small>
                                                </div>
                                            </div>
                                            <div>
                                                <a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}" class="btn btn-sm btn-outline-secondary me-1">View</a>
                                                <a href="${pageContext.request.contextPath}/instructor/courses/edit?id=${course.courseId}" class="btn btn-sm btn-outline-primary me-1">Edit</a>
                                                <c:choose>
                                                    <c:when test="${course.status == 'active'}">
                                                        <button class="btn btn-sm btn-outline-secondary">Statistics</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-sm btn-success">Publish</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-between align-items-center mt-2">
                                            <div>
                                                <small class="text-muted me-3"><strong>Category:</strong> ${course.category.name}</small>
                                                <small class="text-muted me-3"><strong>Level:</strong> ${course.level}</small>
                                                <c:if test="${course.status == 'active'}">
                                                    <small class="text-muted"><strong>Students:</strong> 0</small>
                                                </c:if>
                                                <c:if test="${course.status != 'active'}">
                                                    <small class="text-muted"><strong>Status:</strong> ${course.status}</small>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <c:if test="${courses.size() > 4}">
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/instructor/courses/" class="btn btn-outline-primary">View All Courses</a>
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="col-md-4">
            <!-- Student Performance -->
            <div class="sidebar-card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5>Student Performance</h5>
                    <button class="btn btn-sm btn-primary">View All</button>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <h6>Web Development Fundamentals</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small><i class="fas fa-users"></i> Average Completion Rate</small>
                                <span>78%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style="width: 78%" aria-valuenow="78"
                                     aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <h6>Advanced JavaScript Techniques</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small><i class="fas fa-users"></i> Average Completion Rate</small>
                                <span>65%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style="width: 65%" aria-valuenow="65"
                                     aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <h6>Responsive Web Design Masterclass</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small><i class="fas fa-users"></i> Average Completion Rate</small>
                                <span>82%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style="width: 82%" aria-valuenow="82"
                                     aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Earnings Overview -->
            <div class="sidebar-card mb-4">
                <div class="card-header">
                    <h5>Earnings Overview</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6><i class="fas fa-calendar-day"></i> This Month</h6>
                        <h5 class="text-success mb-0">$3,240</h5>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6><i class="fas fa-calendar-week"></i> Last Month</h6>
                        <h5 class="mb-0">$2,890</h5>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <h6><i class="fas fa-calendar"></i> Year to Date</h6>
                        <h5 class="mb-0">$18,650</h5>
                    </div>
                    <hr>
                    <div class="d-grid">
                        <button class="btn btn-outline-primary"><i class="fas fa-chart-line"></i> View Earnings Report</button>
                    </div>
                </div>
            </div>

            <!-- Recent Reviews -->
            <div class="sidebar-card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5>Recent Reviews</h5>
                    <button class="btn btn-sm btn-primary">View All</button>
                </div>
                <div class="card-body">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <h6><i class="fas fa-user"></i> Rajesh Sharma</h6>
                                <div>
                                    <span class="text-warning"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></span>
                                    <small class="ms-1">5.0</small>
                                </div>
                            </div>
                            <p>"Excellent course! The instructor explains complex concepts in a very understandable way."</p>
                            <small><i class="fas fa-book"></i> Web Development Fundamentals <i class="fas fa-circle"></i> 2 days ago</small>
                        </div>
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <h6><i class="fas fa-user"></i> Sunita Rai</h6>
                                <div>
                                    <span class="text-warning"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i></span>
                                    <small class="ms-1">4.0</small>
                                </div>
                            </div>
                            <p>"Great content but would love more practical examples. Overall very helpful."</p>
                            <small><i class="fas fa-book"></i> Advanced JavaScript Techniques <i class="fas fa-circle"></i> 1 week ago</small>
                        </div>
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <h6><i class="fas fa-user"></i> Amit Kumar</h6>
                                <div>
                                    <span class="text-warning"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></span>
                                    <small class="ms-1">5.0</small>
                                </div>
                            </div>
                            <p>"This course transformed my understanding of responsive design. Highly recommended!"</p>
                            <small><i class="fas fa-book"></i> Responsive Web Design Masterclass <i class="fas fa-circle"></i> 2 weeks ago</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
