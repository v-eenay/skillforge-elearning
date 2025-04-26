<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/header.jsp" %>

<div class="dashboard-container">
    <div class="container">
        <div class="row dashboard-header">
            <div class="col-md-8">
                <h2>Admin Dashboard</h2>
                <p>Welcome back, ${user.name}! Here's an overview of your platform.</p>
            </div>
            <div class="col-md-4">
                <div class="dashboard-actions">
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary">
                        <i class="fas fa-users"></i> <span>Manage Users</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/profile" class="btn btn-outline-primary">
                        <i class="fas fa-user-circle"></i> <span>My Profile</span>
                    </a>
                    <div class="dropdown">
                        <button class="btn btn-outline-primary dropdown-toggle" type="button" id="adminActionsDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-cog"></i> <span>Settings</span>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="adminActionsDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/setup-database"><i class="fas fa-database me-2"></i> Database Setup</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/initialize-categories"><i class="fas fa-tags me-2"></i> Initialize Categories</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#"><i class="fas fa-cogs me-2"></i> System Settings</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

    <!-- Stats Overview -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-primary text-white">
                <div class="card-body">
                    <h5 class="card-title">Total Users</h5>
                    <h2 class="display-4">${totalUsers}</h2>
                    <p class="card-text"><i class="fas fa-users"></i> Registered users</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title">Active Courses</h5>
                    <h2 class="display-4">87</h2>
                    <p class="card-text"><i class="fas fa-arrow-up"></i> 5% from last month</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title">Enrollments</h5>
                    <h2 class="display-4">3,721</h2>
                    <p class="card-text"><i class="fas fa-arrow-up"></i> 18% from last month</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-warning text-white">
                <div class="card-body">
                    <h5 class="card-title">Revenue</h5>
                    <h2 class="display-4">$42K</h2>
                    <p class="card-text"><i class="fas fa-arrow-up"></i> 8% from last month</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- User Management -->
        <div class="col-md-8 mb-4">
            <div class="content-card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5>Recent Users</h5>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-primary">
                        <i class="fas fa-users"></i> View All Users
                    </a>
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
                                                        <i class="fas fa-eye"></i> View
                                                    </a>
                                                    <c:if test="${user.role != 'admin'}">
                                                        <c:choose>
                                                            <c:when test="${user.status == 'active'}">
                                                                <a href="${pageContext.request.contextPath}/admin/users?action=suspend&userId=${user.userId}" class="btn btn-sm btn-outline-danger">
                                                                    <i class="fas fa-ban"></i> Suspend
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="${pageContext.request.contextPath}/admin/users?action=activate&userId=${user.userId}" class="btn btn-sm btn-outline-success">
                                                                    <i class="fas fa-check-circle"></i> Activate
                                                                </a>
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
            <div class="sidebar-card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5><i class="fas fa-cogs me-2"></i> System Settings</h5>
                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="collapse" data-bs-target="#systemSettingsCollapse" aria-expanded="true">
                        <i class="fas fa-chevron-down"></i>
                    </button>
                </div>
                <div class="card-body collapse show" id="systemSettingsCollapse">
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <div>
                                <i class="fas fa-cogs text-primary me-2"></i>
                                <span>Site Configuration</span>
                                <small class="d-block text-muted mt-1">Manage site settings and appearance</small>
                            </div>
                            <i class="fas fa-chevron-right text-muted"></i>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <div>
                                <i class="fas fa-credit-card text-success me-2"></i>
                                <span>Payment Settings</span>
                                <small class="d-block text-muted mt-1">Configure payment gateways and options</small>
                            </div>
                            <i class="fas fa-chevron-right text-muted"></i>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <div>
                                <i class="fas fa-envelope text-info me-2"></i>
                                <span>Email Templates</span>
                                <small class="d-block text-muted mt-1">Customize notification emails</small>
                            </div>
                            <i class="fas fa-chevron-right text-muted"></i>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <div>
                                <i class="fas fa-shield-alt text-danger me-2"></i>
                                <span>Security Settings</span>
                                <small class="d-block text-muted mt-1">Manage authentication and permissions</small>
                            </div>
                            <i class="fas fa-chevron-right text-muted"></i>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <div>
                                <i class="fas fa-cloud-upload-alt text-warning me-2"></i>
                                <span>Backup & Restore</span>
                                <small class="d-block text-muted mt-1">Manage system backups</small>
                            </div>
                            <i class="fas fa-chevron-right text-muted"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/setup-database" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <div>
                                <i class="fas fa-database text-primary me-2"></i>
                                <span>Database Setup</span>
                                <small class="d-block text-muted mt-1">Initialize and manage database</small>
                            </div>
                            <i class="fas fa-chevron-right text-muted"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/initialize-categories" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <div>
                                <i class="fas fa-tags text-success me-2"></i>
                                <span>Initialize Categories</span>
                                <small class="d-block text-muted mt-1">Set up course categories</small>
                            </div>
                            <i class="fas fa-chevron-right text-muted"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Notifications -->
            <div class="sidebar-card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5><i class="fas fa-bell me-2"></i> Recent Notifications</h5>
                    <div>
                        <span class="badge bg-danger me-2">3 New</span>
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="collapse" data-bs-target="#notificationsCollapse" aria-expanded="true">
                            <i class="fas fa-chevron-down"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body collapse show" id="notificationsCollapse">
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action border-start border-primary border-3 rounded-start">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1 text-primary"><i class="fas fa-book me-2"></i> New Course Submitted</h6>
                                <small class="text-muted"><i class="fas fa-clock me-1"></i> 3 hours ago</small>
                            </div>
                            <p class="mb-1">Instructor Priya Patel submitted a new course for review.</p>
                            <small class="text-primary">Click to review course</small>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action border-start border-success border-3 rounded-start">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1 text-success"><i class="fas fa-check-circle me-2"></i> System Update Completed</h6>
                                <small class="text-muted"><i class="fas fa-clock me-1"></i> 1 day ago</small>
                            </div>
                            <p class="mb-1">The system update has been successfully completed.</p>
                            <small class="text-success">Click to view update details</small>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action border-start border-warning border-3 rounded-start">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1 text-warning"><i class="fas fa-exclamation-triangle me-2"></i> Payment Gateway Alert</h6>
                                <small class="text-muted"><i class="fas fa-clock me-1"></i> 2 days ago</small>
                            </div>
                            <p class="mb-1">There was an issue with the payment gateway. Please check.</p>
                            <small class="text-warning">Click to investigate issue</small>
                        </a>
                    </div>
                    <div class="text-center mt-3">
                        <a href="#" class="btn btn-sm btn-primary w-100">
                            <i class="fas fa-list me-2"></i> View All Notifications
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
