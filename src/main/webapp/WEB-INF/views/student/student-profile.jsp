<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/header.jsp" %>

<div class="container py-5">
    <div class="row">
        <!-- Profile Sidebar -->
        <div class="col-lg-4 mb-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center p-4">
                    <div class="mb-4">
                        <c:choose>
                            <c:when test="${not empty userProfile.profileImage}">
                                <img src="${pageContext.request.contextPath}${userProfile.profileImage.startsWith('/') ? '' : '/'}${userProfile.profileImage}" alt="${userProfile.name}" class="rounded-circle img-fluid" style="width: 150px; height: 150px; object-fit: cover;" onerror="this.onerror=null; this.src='https://placebeard.it/150/150?image=${userProfile.userId % 10 + 1}';">
                            </c:when>
                            <c:otherwise>
                                <img src="https://placebeard.it/150/150?image=${userProfile.userId % 10 + 1}" alt="${userProfile.name}" class="rounded-circle img-fluid" style="width: 150px; height: 150px; object-fit: cover;">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <h3 class="fw-bold mb-1">${userProfile.name}</h3>
                    <p class="text-muted mb-3">@${userProfile.userName}</p>
                    <p class="mb-3">${userProfile.bio}</p>
                    <div class="d-flex justify-content-center">
                        <span class="badge bg-primary me-2 px-3 py-2">Student</span>
                        <span class="badge bg-success px-3 py-2">Active</span>
                    </div>
                </div>
                <div class="card-footer bg-light p-4">
                    <div class="d-flex justify-content-between mb-3">
                        <span class="fw-bold">Email</span>
                        <span>${userProfile.email}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <span class="fw-bold">Joined</span>
                        <span>April 2023</span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="fw-bold">Courses</span>
                        <span>4 Enrolled</span>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow-sm mt-4">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-3">Quick Links</h5>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item px-0 py-2 border-0">
                            <a href="${pageContext.request.contextPath}/student/dashboard" class="text-decoration-none d-flex align-items-center">
                                <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                            </a>
                        </li>
                        <li class="list-group-item px-0 py-2 border-0">
                            <a href="#" class="text-decoration-none d-flex align-items-center">
                                <i class="fas fa-book-open me-2"></i> My Courses
                            </a>
                        </li>
                        <li class="list-group-item px-0 py-2 border-0">
                            <a href="#" class="text-decoration-none d-flex align-items-center">
                                <i class="fas fa-certificate me-2"></i> Certificates
                            </a>
                        </li>
                        <li class="list-group-item px-0 py-2 border-0">
                            <a href="#" class="text-decoration-none d-flex align-items-center">
                                <i class="fas fa-cog me-2"></i> Account Settings
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Profile Content -->
        <div class="col-lg-8">
            <!-- Alerts -->
            <%@ include file="/common/alert-messages.jsp" %>

            <!-- Edit Profile -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white p-4 border-0 d-flex justify-content-between align-items-center">
                    <h4 class="fw-bold mb-0">Edit Profile</h4>
                    <a href="${pageContext.request.contextPath}/student/profile" class="btn btn-outline-primary">View Profile</a>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/student/profile" method="post" enctype="multipart/form-data">
                        <div class="row g-3">
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
                            <div class="col-md-12 mb-3">
                                <label for="profileImage" class="form-label">Profile Image</label>
                                <div class="d-flex align-items-center mb-2">
                                    <c:choose>
                                        <c:when test="${not empty userProfile.profileImage}">
                                            <img src="${pageContext.request.contextPath}${userProfile.profileImage.startsWith('/') ? '' : '/'}${userProfile.profileImage}" alt="Current profile image" class="rounded-circle me-3" style="width: 64px; height: 64px; object-fit: cover;" onerror="this.onerror=null; this.src='https://placebeard.it/64/64?image=${userProfile.userId % 10 + 1}';">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://placebeard.it/64/64?image=${userProfile.userId % 10 + 1}" alt="Current profile image" class="rounded-circle me-3" style="width: 64px; height: 64px; object-fit: cover;">
                                        </c:otherwise>
                                    </c:choose>
                                    <span>Current profile image</span>
                                </div>
                                <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*">
                                <small class="text-muted">Upload a new profile image (JPG, PNG, or GIF). Maximum size: 10MB</small>
                            </div>
                            <div class="col-md-12">
                                <label for="bio" class="form-label">Bio</label>
                                <textarea class="form-control" id="bio" name="bio" rows="4">${userProfile.bio}</textarea>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Learning Progress -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white p-4 border-0 d-flex justify-content-between align-items-center">
                    <h4 class="fw-bold mb-0">Learning Progress</h4>
                    <a href="#" class="btn btn-sm btn-outline-primary">View All</a>
                </div>
                <div class="card-body p-4">
                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0">Web Development Fundamentals</h6>
                            <span class="badge bg-primary">75%</span>
                        </div>
                        <div class="progress" style="height: 8px;">
                            <div class="progress-bar" role="progressbar" style="width: 75%;" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0">Data Science Essentials</h6>
                            <span class="badge bg-primary">45%</span>
                        </div>
                        <div class="progress" style="height: 8px;">
                            <div class="progress-bar" role="progressbar" style="width: 45%;" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0">Mobile App Development</h6>
                            <span class="badge bg-primary">90%</span>
                        </div>
                        <div class="progress" style="height: 8px;">
                            <div class="progress-bar" role="progressbar" style="width: 90%;" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div>
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="mb-0">UI/UX Design Principles</h6>
                            <span class="badge bg-primary">30%</span>
                        </div>
                        <div class="progress" style="height: 8px;">
                            <div class="progress-bar" role="progressbar" style="width: 30%;" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Achievements -->
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white p-4 border-0">
                    <h4 class="fw-bold mb-0">Achievements</h4>
                </div>
                <div class="card-body p-4">
                    <div class="row g-3">
                        <div class="col-md-4 text-center">
                            <div class="p-3 border rounded-3 mb-2">
                                <i class="fas fa-award text-warning fa-3x mb-3"></i>
                                <h6 class="mb-1">Fast Learner</h6>
                                <small class="text-muted">Completed 3 courses in a month</small>
                            </div>
                        </div>
                        <div class="col-md-4 text-center">
                            <div class="p-3 border rounded-3 mb-2">
                                <i class="fas fa-trophy text-success fa-3x mb-3"></i>
                                <h6 class="mb-1">Perfect Score</h6>
                                <small class="text-muted">100% on Web Dev Quiz</small>
                            </div>
                        </div>
                        <div class="col-md-4 text-center">
                            <div class="p-3 border rounded-3 mb-2">
                                <i class="fas fa-star text-primary fa-3x mb-3"></i>
                                <h6 class="mb-1">Rising Star</h6>
                                <small class="text-muted">Top 10% of students</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
