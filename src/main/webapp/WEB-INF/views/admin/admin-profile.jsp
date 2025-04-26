<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/header.jsp" %>

<div class="profile-container">
    <div class="container">
        <div class="row profile-header">
            <div class="col-md-8">
                <h2>Admin Profile</h2>
                <p>Manage your profile information and administrator settings</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-primary">
                    <i class="fas fa-tachometer-alt me-2"></i> Dashboard
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
                        <a href="${pageContext.request.contextPath}/admin/profile" class="profile-action-btn secondary">
                            <i class="fas fa-eye"></i> View Public Profile
                        </a>
                    </div>
                </div>
            </div>

            <!-- Profile Content -->
            <div class="col-lg-8">
                <!-- Alerts -->
                <%@ include file="/common/alert-messages.jsp" %>

                <!-- Edit Profile -->
                <div class="profile-content-card profile-animate">
                    <div class="profile-content-header">
                        <h4>Edit Profile</h4>
                    </div>
                    <div class="profile-content-body">
                        <form action="${pageContext.request.contextPath}/admin/profile" method="post" enctype="multipart/form-data" class="profile-form">
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <label for="name" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="name" name="name" value="${userProfile.name}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="userName" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="userName" name="userName" value="${userProfile.userName}" required>
                                </div>
                                <div class="col-md-12">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${userProfile.email}" required>
                                </div>
                                <div class="col-md-12">
                                    <label for="profileImage" class="form-label">Profile Image</label>
                                    <div class="current-profile-image">
                                        <c:choose>
                                            <c:when test="${not empty userProfile.profileImage}">
                                                <img src="${pageContext.request.contextPath}${userProfile.profileImage.startsWith('/') ? '' : '/'}${userProfile.profileImage}" alt="Current profile image" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-profile.svg';">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/images/default-profile.svg" alt="Current profile image">
                                            </c:otherwise>
                                        </c:choose>
                                        <span>Current profile image</span>
                                    </div>
                                    <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*">
                                    <div class="form-text">Upload a new profile image (JPG, PNG, or GIF). Maximum size: 10MB</div>
                                </div>
                                <div class="col-md-12">
                                    <label for="bio" class="form-label">Bio</label>
                                    <textarea class="form-control" id="bio" name="bio" rows="4">${userProfile.bio}</textarea>
                                    <div class="form-text">Tell users about your role and responsibilities</div>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i> Save Changes
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

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
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
