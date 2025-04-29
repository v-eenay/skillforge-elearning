<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/header.jsp" %>

<div class="dashboard-container">
    <div class="container">
        <!-- Success Messages -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session" />
        </c:if>

        <!-- Error Messages -->
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="error" scope="session" />
        </c:if>
        <div class="row dashboard-header">
            <div class="col-md-8">
                <h2>Instructor Dashboard</h2>
                <p>Welcome back, ${user.name}! Manage your courses and track student performance.</p>
            </div>
            <div class="col-md-4">
                <div class="dashboard-actions">
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
                    <h5 class="card-title"><i class="fas fa-book-open"></i> Active Courses</h5>
                    <h2 class="display-4">${activeCourses}</h2>
                    <p class="card-text"><i class="fas fa-layer-group"></i> ${totalCourses} total courses</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title"><i class="fas fa-users"></i> Total Students</h5>
                    <h2 class="display-4">247</h2>
                    <p class="card-text"><i class="fas fa-chart-line"></i> 12% from last month</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title"><i class="fas fa-star"></i> Course Rating</h5>
                    <h2 class="display-4">4.8</h2>
                    <p class="card-text"><i class="fas fa-comment-dots"></i> Based on 183 reviews</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-warning text-white">
                <div class="card-body">
                    <h5 class="card-title"><i class="fas fa-coins"></i> Earnings</h5>
                    <h2 class="display-4">$3.2K</h2>
                    <p class="card-text"><i class="fas fa-calendar-alt"></i> This month</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Course Management -->
        <div class="col-md-8 mb-4">
            <div class="content-card mb-4">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="mb-0">My Courses</h5>
                        <div class="filter-buttons">
                            <button class="btn btn-outline-secondary filter-btn" data-filter="all">
                                <i class="fas fa-th-large"></i> All
                            </button>
                            <button class="btn btn-primary filter-btn active" data-filter="published">
                                <i class="fas fa-check-circle"></i> Published
                            </button>
                            <button class="btn btn-outline-secondary filter-btn" data-filter="draft">
                                <i class="fas fa-pencil-alt"></i> Draft
                            </button>
                        </div>
                    </div>
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0">
                            <i class="fas fa-search text-muted"></i>
                        </span>
                        <input type="text" class="form-control border-start-0 ps-0" id="searchCourses" placeholder="Search your courses...">
                    </div>
                </div>
                <div class="card-body" id="coursesContainer">
                    <!-- No Results Message (hidden by default) -->
                    <div id="noResults" class="alert alert-info text-center" style="display: none;">
                        <i class="fas fa-search me-2"></i> No courses match your filter criteria.
                    </div>
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
                                <div class="d-flex ${!loop.last ? 'mb-3 p-3 border-bottom' : 'p-3'} course-item" data-status="${course.status}" data-created="${course.createdAt}" data-students="0">
                                    <div class="course-image-container">
                                        <c:choose>
                                            <c:when test="${not empty course.thumbnail}">
                                                <img src="${pageContext.request.contextPath}${course.thumbnail}" class="course-thumbnail" alt="${course.title}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/course-thumbnail.svg';">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/images/course-thumbnail.svg" class="course-thumbnail" alt="${course.title}">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
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
                                            <div class="course-action-buttons">
                                                <a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}" class="btn btn-sm btn-outline-secondary">View</a>
                                                <a href="${pageContext.request.contextPath}/instructor/courses/edit?id=${course.courseId}" class="btn btn-sm btn-outline-primary">Edit</a>
                                                <c:choose>
                                                    <c:when test="${course.status == 'active'}">
                                                        <button class="btn btn-sm btn-outline-secondary">Statistics</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/instructor/courses/toggle-status?id=${course.courseId}" class="btn btn-sm btn-success">Publish</a>
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
                    <button class="btn btn-sm btn-primary">
                        <i class="fas fa-chart-bar me-1"></i> View All
                    </button>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <h6>Web Development Fundamentals</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small><i class="fas fa-graduation-cap"></i> Average Completion Rate</small>
                                <span class="fw-bold">78%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style="width: 78%" aria-valuenow="78"
                                     aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <h6>Advanced JavaScript Techniques</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small><i class="fas fa-graduation-cap"></i> Average Completion Rate</small>
                                <span class="fw-bold">65%</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style="width: 65%" aria-valuenow="65"
                                     aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <h6>Responsive Web Design Masterclass</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small><i class="fas fa-graduation-cap"></i> Average Completion Rate</small>
                                <span class="fw-bold">82%</span>
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
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h6 class="mb-1"><i class="fas fa-calendar-day text-primary me-2"></i> This Month</h6>
                            <small class="text-muted">May 1 - May 31, 2023</small>
                        </div>
                        <h5 class="text-success mb-0 fw-bold">$3,240</h5>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h6 class="mb-1"><i class="fas fa-calendar-week text-info me-2"></i> Last Month</h6>
                            <small class="text-muted">Apr 1 - Apr 30, 2023</small>
                        </div>
                        <h5 class="mb-0 fw-bold">$2,890</h5>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h6 class="mb-1"><i class="fas fa-calendar text-warning me-2"></i> Year to Date</h6>
                            <small class="text-muted">Jan 1 - May 31, 2023</small>
                        </div>
                        <h5 class="mb-0 fw-bold">$18,650</h5>
                    </div>
                    <div class="d-grid mt-2">
                        <button class="btn btn-primary">
                            <i class="fas fa-chart-line me-2"></i> View Earnings Report
                        </button>
                    </div>
                </div>
            </div>

            <!-- Recent Reviews -->
            <div class="sidebar-card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5>Recent Reviews</h5>
                    <button class="btn btn-sm btn-primary">
                        <i class="fas fa-comments me-1"></i> View All
                    </button>
                </div>
                <div class="card-body">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="mb-0"><i class="fas fa-user-circle text-primary me-2"></i> Rajesh Sharma</h6>
                                <div>
                                    <span class="text-warning"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></span>
                                    <small class="ms-1 fw-bold">5.0</small>
                                </div>
                            </div>
                            <p class="mb-1 fst-italic">"Excellent course! The instructor explains complex concepts in a very understandable way."</p>
                            <div class="d-flex align-items-center">
                                <span class="badge bg-primary me-2">Web Development</span>
                                <small class="text-muted"><i class="fas fa-clock me-1"></i> 2 days ago</small>
                            </div>
                        </div>
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="mb-0"><i class="fas fa-user-circle text-info me-2"></i> Sunita Rai</h6>
                                <div>
                                    <span class="text-warning"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="far fa-star"></i></span>
                                    <small class="ms-1 fw-bold">4.0</small>
                                </div>
                            </div>
                            <p class="mb-1 fst-italic">"Great content but would love more practical examples. Overall very helpful."</p>
                            <div class="d-flex align-items-center">
                                <span class="badge bg-info me-2">JavaScript</span>
                                <small class="text-muted"><i class="fas fa-clock me-1"></i> 1 week ago</small>
                            </div>
                        </div>
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h6 class="mb-0"><i class="fas fa-user-circle text-success me-2"></i> Amit Kumar</h6>
                                <div>
                                    <span class="text-warning"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></span>
                                    <small class="ms-1 fw-bold">5.0</small>
                                </div>
                            </div>
                            <p class="mb-1 fst-italic">"This course transformed my understanding of responsive design. Highly recommended!"</p>
                            <div class="d-flex align-items-center">
                                <span class="badge bg-success me-2">Web Design</span>
                                <small class="text-muted"><i class="fas fa-clock me-1"></i> 2 weeks ago</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>

<!-- Instructor JS -->
<script src="${pageContext.request.contextPath}/assets/js/instructor.js"></script>
