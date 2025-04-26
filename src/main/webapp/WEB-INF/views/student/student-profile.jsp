<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/header.jsp" %>

<div class="profile-container">
    <div class="container">
        <div class="row profile-header">
            <div class="col-md-8">
                <h2>Student Profile</h2>
                <p>Manage your profile information and track your learning progress</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-outline-primary">
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
                            <span class="profile-badge student">
                                <i class="fas fa-user-graduate"></i> Student
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
                            <span class="profile-detail-value">April 2023</span>
                        </div>
                        <div class="profile-detail-item">
                            <span class="profile-detail-label">Courses</span>
                            <span class="profile-detail-value">4 Enrolled</span>
                        </div>
                        <div class="profile-detail-item">
                            <span class="profile-detail-label">Certificates</span>
                            <span class="profile-detail-value">1 Earned</span>
                        </div>
                    </div>
                    <div class="profile-actions">
                        <a href="${pageContext.request.contextPath}/student/profile" class="profile-action-btn secondary">
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
                        <form action="${pageContext.request.contextPath}/student/profile" method="post" enctype="multipart/form-data" class="profile-form">
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
                                    <div class="form-text">Tell us about yourself, your interests, and learning goals</div>
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

                <!-- Enrolled Courses -->
                <div class="profile-content-card profile-animate">
                    <div class="profile-content-header">
                        <h4>Enrolled Courses</h4>
                        <a href="${pageContext.request.contextPath}/student/courses" class="btn btn-sm btn-outline-primary">
                            <i class="fas fa-external-link-alt me-1"></i> View All Courses
                        </a>
                    </div>
                    <div class="profile-content-body">
                        <div class="table-responsive">
                            <table class="profile-table">
                                <thead>
                                    <tr>
                                        <th>Course</th>
                                        <th>Instructor</th>
                                        <th>Progress</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Web Development Fundamentals</td>
                                        <td>John Smith</td>
                                        <td>
                                            <div class="progress" style="height: 8px;">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                            <small class="text-muted">75% Complete</small>
                                        </td>
                                        <td><span class="badge bg-success">In Progress</span></td>
                                    </tr>
                                    <tr>
                                        <td>Python for Data Science</td>
                                        <td>Sarah Johnson</td>
                                        <td>
                                            <div class="progress" style="height: 8px;">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                            <small class="text-muted">100% Complete</small>
                                        </td>
                                        <td><span class="badge bg-primary">Completed</span></td>
                                    </tr>
                                    <tr>
                                        <td>UI/UX Design Principles</td>
                                        <td>Michael Chen</td>
                                        <td>
                                            <div class="progress" style="height: 8px;">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: 30%;" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                            <small class="text-muted">30% Complete</small>
                                        </td>
                                        <td><span class="badge bg-success">In Progress</span></td>
                                    </tr>
                                    <tr>
                                        <td>JavaScript Fundamentals</td>
                                        <td>Emily Rodriguez</td>
                                        <td>
                                            <div class="progress" style="height: 8px;">
                                                <div class="progress-bar bg-success" role="progressbar" style="width: 10%;" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                            <small class="text-muted">10% Complete</small>
                                        </td>
                                        <td><span class="badge bg-warning text-dark">Just Started</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Certificates -->
                <div class="profile-content-card profile-animate">
                    <div class="profile-content-header">
                        <h4>Certificates</h4>
                    </div>
                    <div class="profile-content-body">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="card h-100 border-0 shadow-sm">
                                    <div class="card-body p-4">
                                        <div class="d-flex align-items-center mb-3">
                                            <i class="fas fa-certificate text-primary me-3" style="font-size: 2rem;"></i>
                                            <div>
                                                <h5 class="mb-1">Python for Data Science</h5>
                                                <p class="text-muted mb-0">Completed on June 15, 2023</p>
                                            </div>
                                        </div>
                                        <p>Successfully completed all requirements and assessments for the Python for Data Science course.</p>
                                        <div class="d-flex justify-content-between align-items-center mt-3">
                                            <a href="#" class="btn btn-sm btn-outline-primary">
                                                <i class="fas fa-download me-2"></i> Download
                                            </a>
                                            <a href="#" class="btn btn-sm btn-outline-secondary">
                                                <i class="fas fa-share-alt me-2"></i> Share
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card h-100 border-0 shadow-sm bg-light">
                                    <div class="card-body p-4 d-flex flex-column justify-content-center align-items-center text-center">
                                        <i class="fas fa-award text-muted mb-3" style="font-size: 3rem; opacity: 0.5;"></i>
                                        <h5 class="text-muted">Complete more courses to earn certificates</h5>
                                        <p class="mb-3">Finish your enrolled courses to receive more certificates.</p>
                                        <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary">
                                            <i class="fas fa-search me-2"></i> Browse Courses
                                        </a>
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
