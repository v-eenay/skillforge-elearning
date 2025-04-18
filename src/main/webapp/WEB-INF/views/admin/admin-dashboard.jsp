<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/header.jsp" %>

<div class="container py-4">
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="mb-3">Admin Dashboard</h2>
            <p class="text-muted">Welcome back, ${user.name}! Here's an overview of your platform.</p>
        </div>
        <div class="col-md-4 text-end">
            <button class="btn btn-outline-primary me-2">Notifications <span class="badge bg-danger">3</span></button>
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary">Manage Users</a>
                <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
                    <span class="visually-hidden">Toggle Dropdown</span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">User Management</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/contacts">Contact Messages</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/setup-database">Database Setup</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Stats Overview -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <h5 class="card-title">Total Users</h5>
                    <h2 class="display-4">${totalUsers}</h2>
                    <p class="card-text"><small><i class="fas fa-users"></i> Registered users</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title">Active Courses</h5>
                    <h2 class="display-4">87</h2>
                    <p class="card-text"><small><i class="fas fa-arrow-up"></i> 5% from last month</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title">Enrollments</h5>
                    <h2 class="display-4">3,721</h2>
                    <p class="card-text"><small><i class="fas fa-arrow-up"></i> 18% from last month</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-warning text-dark">
                <div class="card-body">
                    <h5 class="card-title">Revenue</h5>
                    <h2 class="display-4">$42K</h2>
                    <p class="card-text"><small><i class="fas fa-arrow-up"></i> 8% from last month</small></p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- User Management -->
        <div class="col-md-8 mb-4">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Recent Users</h5>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-primary">View All Users</a>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Joined</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty recentUsers}">
                                        <tr>
                                            <td colspan="5" class="text-center py-4">No users found.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="user" items="${recentUsers}">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <c:choose>
                                                            <c:when test="${not empty user.profileImage}">
                                                                <img src="${pageContext.request.contextPath}${user.profileImage}" alt="${user.name}" class="rounded-circle me-2" width="40" height="40" style="object-fit: cover;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 40px; height: 40px;">
                                                                    ${fn:substring(user.name, 0, 1)}
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div>${user.name}</div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.role == 'admin'}">
                                                            <span class="badge bg-danger">Admin</span>
                                                        </c:when>
                                                        <c:when test="${user.role == 'instructor'}">
                                                            <span class="badge bg-primary">Instructor</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-info">Student</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.status == 'active'}">
                                                            <span class="badge bg-success">Active</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-warning text-dark">Suspended</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>Recently joined</td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/admin/users?action=view&userId=${user.userId}" class="btn btn-sm btn-outline-primary me-1">
                                                        <i class="fas fa-eye me-1"></i> View
                                                    </a>
                                                    <c:if test="${user.role != 'admin'}">
                                                        <c:choose>
                                                            <c:when test="${user.status == 'active'}">
                                                                <a href="${pageContext.request.contextPath}/admin/users?action=suspend&userId=${user.userId}" class="btn btn-sm btn-outline-danger">Suspend</a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="${pageContext.request.contextPath}/admin/users?action=activate&userId=${user.userId}" class="btn btn-sm btn-outline-success">Activate</a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- System Settings -->
        <div class="col-md-4 mb-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">System Settings</h5>
                </div>
                <div class="card-body">
                    <div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            Site Configuration
                            <span class="badge bg-primary rounded-pill"><i class="bi bi-gear"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            Payment Settings
                            <span class="badge bg-primary rounded-pill"><i class="bi bi-credit-card"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            Email Templates
                            <span class="badge bg-primary rounded-pill"><i class="bi bi-envelope"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            Security Settings
                            <span class="badge bg-primary rounded-pill"><i class="bi bi-shield-lock"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            Backup & Restore
                            <span class="badge bg-primary rounded-pill"><i class="bi bi-cloud-arrow-up"></i></span>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/setup-database" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            Database Setup
                            <span class="badge bg-primary rounded-pill"><i class="fas fa-database"></i></span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Notifications -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Recent Notifications</h5>
                    <button class="btn btn-sm btn-primary">View All</button>
                </div>
                <div class="card-body p-0">
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action py-3">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">New Course Submitted</h6>
                                <small class="text-muted">3 hours ago</small>
                            </div>
                            <p class="mb-1">Instructor Priya Patel submitted a new course for review.</p>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action py-3">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">System Update Completed</h6>
                                <small class="text-muted">1 day ago</small>
                            </div>
                            <p class="mb-1">The system update has been successfully completed.</p>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action py-3">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">Payment Gateway Alert</h6>
                                <small class="text-muted">2 days ago</small>
                            </div>
                            <p class="mb-1">There was an issue with the payment gateway. Please check.</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
