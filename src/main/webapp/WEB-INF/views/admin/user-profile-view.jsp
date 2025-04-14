<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/header.jsp" %>

<div class="container py-5">
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="mb-3">User Profile</h2>
            <p class="text-muted">Viewing profile for ${user.name}</p>
        </div>
        <div class="col-md-4 text-end">
            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-primary me-2">
                <i class="fas fa-arrow-left me-1"></i> Back to Users
            </a>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-secondary">
                <i class="fas fa-tachometer-alt me-1"></i> Dashboard
            </a>
        </div>
    </div>

    <!-- Alerts -->
    <%@ include file="/common/alert-messages.jsp" %>

    <div class="row">
        <!-- User Profile Information -->
        <div class="col-lg-8">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Profile Information</h5>
                    <div>
                        <c:if test="${user.role != 'admin'}">
                            <c:choose>
                                <c:when test="${user.status == 'active'}">
                                    <form action="${pageContext.request.contextPath}/admin/users" method="post" class="d-inline">
                                        <input type="hidden" name="action" value="suspend">
                                        <input type="hidden" name="userId" value="${user.userId}">
                                        <input type="hidden" name="returnTo" value="profile">
                                        <button type="submit" class="btn btn-warning btn-sm" onclick="return confirm('Are you sure you want to suspend this user?')">
                                            <i class="fas fa-ban me-1"></i> Suspend User
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/admin/users" method="post" class="d-inline">
                                        <input type="hidden" name="action" value="activate">
                                        <input type="hidden" name="userId" value="${user.userId}">
                                        <input type="hidden" name="returnTo" value="profile">
                                        <button type="submit" class="btn btn-success btn-sm" onclick="return confirm('Are you sure you want to activate this user?')">
                                            <i class="fas fa-check-circle me-1"></i> Activate User
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                            <form action="${pageContext.request.contextPath}/admin/users" method="post" class="d-inline ms-2">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="userId" value="${user.userId}">
                                <input type="hidden" name="returnTo" value="list">
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this user? This action cannot be undone.')">
                                    <i class="fas fa-trash-alt me-1"></i> Delete User
                                </button>
                            </form>
                        </c:if>
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="row">
                        <!-- Profile Image -->
                        <div class="col-md-4 text-center mb-4 mb-md-0">
                            <c:choose>
                                <c:when test="${not empty user.profileImage}">
                                    <img src="${pageContext.request.contextPath}${user.profileImage}" alt="${user.name}" class="rounded-circle img-thumbnail mb-3" style="width: 150px; height: 150px; object-fit: cover;">
                                </c:when>
                                <c:otherwise>
                                    <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 150px; height: 150px; font-size: 4rem;">
                                        ${fn:substring(user.name, 0, 1)}
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <h4 class="mb-1">${user.name}</h4>
                            <p class="text-muted mb-2">@${user.userName}</p>
                            <div class="mb-3">
                                <c:choose>
                                    <c:when test="${user.role == 'admin'}">
                                        <span class="badge bg-danger">Administrator</span>
                                    </c:when>
                                    <c:when test="${user.role == 'instructor'}">
                                        <span class="badge bg-primary">Instructor</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-info">Student</span>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${user.status == 'active'}">
                                        <span class="badge bg-success">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark">Suspended</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Profile Details -->
                        <div class="col-md-8">
                            <div class="row mb-3">
                                <div class="col-md-4 fw-bold">User ID:</div>
                                <div class="col-md-8">${user.userId}</div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-4 fw-bold">Full Name:</div>
                                <div class="col-md-8">${user.name}</div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-4 fw-bold">Username:</div>
                                <div class="col-md-8">${user.userName}</div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-4 fw-bold">Email:</div>
                                <div class="col-md-8">
                                    <a href="mailto:${user.email}">${user.email}</a>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-4 fw-bold">Role:</div>
                                <div class="col-md-8">
                                    <c:choose>
                                        <c:when test="${user.role == 'admin'}">Administrator</c:when>
                                        <c:when test="${user.role == 'instructor'}">Instructor</c:when>
                                        <c:otherwise>Student</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-4 fw-bold">Status:</div>
                                <div class="col-md-8">
                                    <c:choose>
                                        <c:when test="${user.status == 'active'}">
                                            <span class="text-success">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-warning">Suspended</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Bio Section -->
                    <div class="mt-4">
                        <h5 class="mb-3">Biography</h5>
                        <div class="p-3 bg-light rounded">
                            <c:choose>
                                <c:when test="${not empty user.bio}">
                                    <p class="mb-0">${user.bio}</p>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted mb-0">No biography provided.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- User Statistics and Actions -->
        <div class="col-lg-4">
            <!-- User Statistics -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">User Statistics</h5>
                </div>
                <div class="card-body p-4">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                            <span>User ID</span>
                            <span class="badge bg-primary rounded-pill">${user.userId}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                            <span>Account Status</span>
                            <c:choose>
                                <c:when test="${user.status == 'active'}">
                                    <span class="badge bg-success">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-warning text-dark">Suspended</span>
                                </c:otherwise>
                            </c:choose>
                        </li>
                        <c:if test="${user.role == 'student'}">
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <span>Enrolled Courses</span>
                                <span class="badge bg-info rounded-pill">0</span>
                            </li>
                        </c:if>
                        <c:if test="${user.role == 'instructor'}">
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <span>Published Courses</span>
                                <span class="badge bg-info rounded-pill">0</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                <span>Total Students</span>
                                <span class="badge bg-info rounded-pill">0</span>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>

            <!-- User Actions -->
            <div class="card shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Actions</h5>
                </div>
                <div class="card-body p-4">
                    <div class="d-grid gap-2">
                        <c:if test="${user.role != 'admin'}">
                            <c:choose>
                                <c:when test="${user.status == 'active'}">
                                    <form action="${pageContext.request.contextPath}/admin/users" method="post">
                                        <input type="hidden" name="action" value="suspend">
                                        <input type="hidden" name="userId" value="${user.userId}">
                                        <input type="hidden" name="returnTo" value="profile">
                                        <button type="submit" class="btn btn-warning w-100 mb-2" onclick="return confirm('Are you sure you want to suspend this user?')">
                                            <i class="fas fa-ban me-2"></i> Suspend User
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/admin/users" method="post">
                                        <input type="hidden" name="action" value="activate">
                                        <input type="hidden" name="userId" value="${user.userId}">
                                        <input type="hidden" name="returnTo" value="profile">
                                        <button type="submit" class="btn btn-success w-100 mb-2" onclick="return confirm('Are you sure you want to activate this user?')">
                                            <i class="fas fa-check-circle me-2"></i> Activate User
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                            <form action="${pageContext.request.contextPath}/admin/users" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="userId" value="${user.userId}">
                                <input type="hidden" name="returnTo" value="list">
                                <button type="submit" class="btn btn-danger w-100" onclick="return confirm('Are you sure you want to delete this user? This action cannot be undone.')">
                                    <i class="fas fa-trash-alt me-2"></i> Delete User
                                </button>
                            </form>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary w-100 mt-3">
                            <i class="fas fa-arrow-left me-2"></i> Back to User List
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
