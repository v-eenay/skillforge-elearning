<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/header.jsp" %>

<div class="container py-4">
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="mb-3">Instructor Dashboard</h2>
            <p class="text-muted">Welcome back, ${user.name}! Manage your courses and track student performance.</p>
        </div>
        <div class="col-md-4 text-end">
            <div class="d-flex justify-content-end gap-2">
                <button class="btn btn-outline-primary">Student Messages <span class="badge bg-danger">5</span></button>
                <a href="${pageContext.request.contextPath}/instructor/profile" class="btn btn-outline-info">My Profile</a>
                <a href="${pageContext.request.contextPath}/instructor/courses/create" class="btn btn-primary">Create Course</a>
            </div>
        </div>
    </div>

    <!-- Stats Overview -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <h5 class="card-title">Active Courses</h5>
                    <h2 class="display-4">${activeCourses}</h2>
                    <p class="card-text"><small>${totalCourses} total courses</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title">Total Students</h5>
                    <h2 class="display-4">247</h2>
                    <p class="card-text"><small><i class="fas fa-arrow-up"></i> 12% from last month</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title">Course Rating</h5>
                    <h2 class="display-4">4.8</h2>
                    <p class="card-text"><small>Based on 183 reviews</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-warning text-dark">
                <div class="card-body">
                    <h5 class="card-title">Earnings</h5>
                    <h2 class="display-4">$3.2K</h2>
                    <p class="card-text"><small>This month</small></p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Course Management -->
        <div class="col-md-8 mb-4">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">My Courses</h5>
                    <div>
                        <button class="btn btn-sm btn-outline-secondary me-2">All</button>
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
                                                <h5 class="mb-1">${course.title}</h5>
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
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Student Performance</h5>
                    <button class="btn btn-sm btn-primary">View All</button>
                </div>
                <div class="card-body p-0">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <h6 class="mb-1">Web Development Fundamentals</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">Average Completion Rate</small>
                                <span>78%</span>
                            </div>
                            <div class="progress mt-1" style="height: 5px;">
                                <div class="progress-bar" role="progressbar" style="width: 78%" aria-valuenow="78"
                                     aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <h6 class="mb-1">Advanced JavaScript Techniques</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">Average Completion Rate</small>
                                <span>65%</span>
                            </div>
                            <div class="progress mt-1" style="height: 5px;">
                                <div class="progress-bar" role="progressbar" style="width: 65%" aria-valuenow="65"
                                     aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <h6 class="mb-1">Responsive Web Design Masterclass</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">Average Completion Rate</small>
                                <span>82%</span>
                            </div>
                            <div class="progress mt-1" style="height: 5px;">
                                <div class="progress-bar" role="progressbar" style="width: 82%" aria-valuenow="82"
                                     aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Earnings Overview -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Earnings Overview</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0">This Month</h6>
                        <h5 class="text-success mb-0">$3,240</h5>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0">Last Month</h6>
                        <h5 class="mb-0">$2,890</h5>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">Year to Date</h6>
                        <h5 class="mb-0">$18,650</h5>
                    </div>
                    <hr>
                    <div class="d-grid">
                        <button class="btn btn-outline-primary">View Earnings Report</button>
                    </div>
                </div>
            </div>

            <!-- Recent Reviews -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Recent Reviews</h5>
                    <button class="btn btn-sm btn-primary">View All</button>
                </div>
                <div class="card-body p-0">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item py-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <h6 class="mb-0">Rajesh Sharma</h6>
                                <div>
                                    <span class="text-warning"><i class="fa-solid fa-star"></i><i
                                            class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
                                            class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></span>
                                    <small class="text-muted ms-1">5.0</small>
                                </div>
                            </div>
                            <p class="mb-1">"Excellent course! The instructor explains complex concepts in a very
                                understandable way."</p>
                            <small class="text-muted">Web Development Fundamentals <i class="fa-solid fa-circle-dot"></i> 2 days ago</small>
                        </div>
                        <div class="list-group-item py-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <h6 class="mb-0">Sunita Rai</h6>
                                <div>
                                    <span class="text-warning"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-regular fa-star"></i></span>
                                    <small class="text-muted ms-1">4.0</small>
                                </div>
                            </div>
                            <p class="mb-1">"Great content but would love more practical examples. Overall very
                                helpful."</p>
                            <small class="text-muted">Advanced JavaScript Techniques <i class="fa-solid fa-circle-dot"></i> 1 week ago</small>
                        </div>
                        <div class="list-group-item py-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <h6 class="mb-0">Amit Kumar</h6>
                                <div>
                                    <span class="text-warning"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></span>
                                    <small class="text-muted ms-1">5.0</small>
                                </div>
                            </div>
                            <p class="mb-1">"This course transformed my understanding of responsive design. Highly
                                recommended!"</p>
                            <small class="text-muted">Responsive Web Design Masterclass <i class="fa-solid fa-circle-dot"></i> 2 weeks ago</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
