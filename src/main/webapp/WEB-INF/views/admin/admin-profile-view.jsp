<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/header.jsp" %>

<div class="profile-container">
    <div class="container">
        <div class="row profile-header">
            <div class="col-md-8">
                <h2>Admin Profile</h2>
                <p>View your public profile information</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-primary me-2">
                    <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/profile/edit" class="btn btn-primary">
                    <i class="fas fa-edit me-2"></i> Edit Profile
                </a>
            </div>
        </div>
        
        <div class="row">
            <!-- Profile Sidebar -->
            <div class="col-lg-4 profile-animate">
                <div class="profile-card profile-sidebar">
                    <div class="profile-info">
                        <div class="profile-image-container">
                            <c:choose>
                                <c:when test="${not empty userProfile.profileImage}">
                                    <img src="${pageContext.request.contextPath}${userProfile.profileImage.startsWith('/') ? '' : '/'}${userProfile.profileImage}" alt="${userProfile.name}" class="profile-image" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-profile.svg';">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/images/default-profile.svg" alt="${userProfile.name}" class="profile-image">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <h3>${userProfile.name}</h3>
                        <span class="username">@${userProfile.userName}</span>
                        <p class="bio">${userProfile.bio}</p>
                        <div class="profile-badges">
                            <span class="profile-badge admin">
                                <i class="fas fa-user-shield"></i> Administrator
                            </span>
                            <span class="profile-badge active">
                                <i class="fas fa-check-circle"></i> Active
                            </span>
                        </div>
                    </div>
                    <div class="profile-details">
                        <div class="profile-detail-item">
                            <span class="profile-detail-label">Email</span>
                            <span class="profile-detail-value">${userProfile.email}</span>
                        </div>
                        <div class="profile-detail-item">
                            <span class="profile-detail-label">Joined</span>
                            <span class="profile-detail-value">January 2023</span>
                        </div>
                        <div class="profile-detail-item">
                            <span class="profile-detail-label">Role</span>
                            <span class="profile-detail-value">System Administrator</span>
                        </div>
                        <div class="profile-detail-item">
                            <span class="profile-detail-label">Last Login</span>
                            <span class="profile-detail-value">Today, 10:45 AM</span>
                        </div>
                    </div>
                    <div class="profile-actions">
                        <a href="${pageContext.request.contextPath}/admin/profile/edit" class="profile-action-btn primary">
                            <i class="fas fa-edit"></i> Edit Profile
                        </a>
                    </div>
                </div>
            </div>

            <!-- Profile Content -->
            <div class="col-lg-8">
                <!-- Alerts -->
                <%@ include file="/common/alert-messages.jsp" %>

                <!-- Admin Statistics -->
                <div class="profile-content-card profile-animate">
                    <div class="profile-content-header">
                        <h4>Platform Statistics</h4>
                    </div>
                    <div class="profile-content-body">
                        <div class="row g-4">
                            <div class="col-md-3 col-6">
                                <div class="stat-card">
                                    <div class="stat-icon">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <div class="stat-value">1,245</div>
                                    <div class="stat-label">Total Users</div>
                                </div>
                            </div>
                            <div class="col-md-3 col-6">
                                <div class="stat-card">
                                    <div class="stat-icon">
                                        <i class="fas fa-chalkboard-teacher"></i>
                                    </div>
                                    <div class="stat-value">48</div>
                                    <div class="stat-label">Instructors</div>
                                </div>
                            </div>
                            <div class="col-md-3 col-6">
                                <div class="stat-card">
                                    <div class="stat-icon">
                                        <i class="fas fa-book"></i>
                                    </div>
                                    <div class="stat-value">156</div>
                                    <div class="stat-label">Courses</div>
                                </div>
                            </div>
                            <div class="col-md-3 col-6">
                                <div class="stat-card">
                                    <div class="stat-icon">
                                        <i class="fas fa-certificate"></i>
                                    </div>
                                    <div class="stat-value">892</div>
                                    <div class="stat-label">Certificates</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activities -->
                <div class="profile-content-card profile-animate">
                    <div class="profile-content-header">
                        <h4>Recent Activities</h4>
                    </div>
                    <div class="profile-content-body">
                        <div class="activity-timeline">
                            <div class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-user-check"></i>
                                </div>
                                <div class="activity-content">
                                    <h6>Approved new instructor</h6>
                                    <p>You approved Michael Chen as a new instructor.</p>
                                    <span class="activity-time">Today, 11:30 AM</span>
                                </div>
                            </div>
                            <div class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-book-open"></i>
                                </div>
                                <div class="activity-content">
                                    <h6>Course approved</h6>
                                    <p>You approved "Advanced JavaScript Techniques" course by John Smith.</p>
                                    <span class="activity-time">Yesterday, 3:45 PM</span>
                                </div>
                            </div>
                            <div class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-cog"></i>
                                </div>
                                <div class="activity-content">
                                    <h6>System settings updated</h6>
                                    <p>You updated the payment gateway settings.</p>
                                    <span class="activity-time">July 15, 2023</span>
                                </div>
                            </div>
                            <div class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-comment-alt"></i>
                                </div>
                                <div class="activity-content">
                                    <h6>Support ticket resolved</h6>
                                    <p>You resolved a support ticket from Rajesh Sharma regarding course access.</p>
                                    <span class="activity-time">July 14, 2023</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- System Health -->
                <div class="profile-content-card profile-animate">
                    <div class="profile-content-header">
                        <h4>System Health</h4>
                    </div>
                    <div class="profile-content-body">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body p-4">
                                        <h5 class="mb-3">Server Status</h5>
                                        <div class="d-flex justify-content-between mb-3">
                                            <span>CPU Usage</span>
                                            <span class="text-success">28%</span>
                                        </div>
                                        <div class="progress mb-4" style="height: 8px;">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 28%;" aria-valuenow="28" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <div class="d-flex justify-content-between mb-3">
                                            <span>Memory Usage</span>
                                            <span class="text-warning">62%</span>
                                        </div>
                                        <div class="progress mb-4" style="height: 8px;">
                                            <div class="progress-bar bg-warning" role="progressbar" style="width: 62%;" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <div class="d-flex justify-content-between mb-3">
                                            <span>Disk Usage</span>
                                            <span class="text-success">45%</span>
                                        </div>
                                        <div class="progress" style="height: 8px;">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 45%;" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body p-4">
                                        <h5 class="mb-3">System Metrics</h5>
                                        <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom">
                                            <span>Uptime</span>
                                            <span class="badge bg-success px-3 py-2">99.9%</span>
                                        </div>
                                        <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom">
                                            <span>Response Time</span>
                                            <span class="badge bg-success px-3 py-2">245ms</span>
                                        </div>
                                        <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom">
                                            <span>Active Sessions</span>
                                            <span class="badge bg-primary px-3 py-2">328</span>
                                        </div>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span>Database Size</span>
                                            <span class="badge bg-info px-3 py-2">4.2 GB</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
