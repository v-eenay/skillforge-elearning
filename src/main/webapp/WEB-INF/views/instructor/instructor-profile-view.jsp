<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/header.jsp" %>

<div class="profile-container">
    <div class="container">
        <div class="row profile-header">
            <div class="col-md-8">
                <h2>Instructor Profile</h2>
                <p>View instructor information and statistics</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-outline-primary">
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
                            <span class="profile-badge instructor">
                                <i class="fas fa-chalkboard-teacher"></i> Instructor
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
                            <span class="profile-detail-value">5 Published</span>
                        </div>
                        <div class="profile-detail-item">
                            <span class="profile-detail-label">Students</span>
                            <span class="profile-detail-value">247 Enrolled</span>
                        </div>
                    </div>
                    <div class="profile-actions">
                        <a href="${pageContext.request.contextPath}/instructor/profile/edit" class="profile-action-btn primary">
                            <i class="fas fa-edit"></i> Edit Profile
                        </a>
                    </div>
                </div>
            </div>

            <!-- Profile Content -->
            <div class="col-lg-8">
                <!-- Alerts -->
                <%@ include file="/common/alert-messages.jsp" %>

                <!-- Course Statistics -->
                <div class="profile-content-card profile-animate">
                    <div class="profile-content-header">
                        <h4>Course Statistics</h4>
                        <a href="${pageContext.request.contextPath}/instructor/courses/" class="btn btn-sm btn-outline-primary">
                            <i class="fas fa-external-link-alt me-1"></i> View All Courses
                        </a>
                    </div>
                    <div class="profile-content-body">
                        <div class="table-responsive">
                            <table class="profile-table">
                                <thead>
                                    <tr>
                                        <th>Course</th>
                                        <th>Students</th>
                                        <th>Rating</th>
                                        <th>Revenue</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Web Development Fundamentals</td>
                                        <td>87</td>
                                        <td>4.9 <i class="fas fa-star text-warning"></i></td>
                                        <td>$1,740</td>
                                    </tr>
                                    <tr>
                                        <td>Advanced JavaScript</td>
                                        <td>65</td>
                                        <td>4.7 <i class="fas fa-star text-warning"></i></td>
                                        <td>$1,300</td>
                                    </tr>
                                    <tr>
                                        <td>React for Beginners</td>
                                        <td>52</td>
                                        <td>4.8 <i class="fas fa-star text-warning"></i></td>
                                        <td>$1,040</td>
                                    </tr>
                                    <tr>
                                        <td>Node.js Masterclass</td>
                                        <td>43</td>
                                        <td>4.6 <i class="fas fa-star text-warning"></i></td>
                                        <td>$860</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Student Reviews -->
                <div class="profile-content-card profile-animate">
                    <div class="profile-content-header">
                        <h4>Student Reviews</h4>
                        <a href="#" class="btn btn-sm btn-outline-primary">
                            <i class="fas fa-external-link-alt me-1"></i> View All
                        </a>
                    </div>
                    <div class="profile-content-body">
                        <div class="review-card">
                            <div class="review-header">
                                <img src="https://placebeard.it/50/50?image=36" alt="Student" class="review-avatar">
                                <div class="review-info">
                                    <h6>Rajesh Sharma</h6>
                                    <div class="review-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span class="review-meta">Web Development Fundamentals • 2 weeks ago</span>
                                </div>
                            </div>
                            <p class="review-text">Excellent course! The instructor explains complex concepts in a very simple and understandable way. I've learned so much in just a few weeks.</p>
                        </div>

                        <div class="review-card">
                            <div class="review-header">
                                <img src="https://placebeard.it/50/50?image=37" alt="Student" class="review-avatar">
                                <div class="review-info">
                                    <h6>Priya Patel</h6>
                                    <div class="review-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                    </div>
                                    <span class="review-meta">Advanced JavaScript • 1 month ago</span>
                                </div>
                            </div>
                            <p class="review-text">This course took my JavaScript skills to the next level. The projects were challenging but very rewarding. Highly recommended!</p>
                        </div>

                        <div class="review-card">
                            <div class="review-header">
                                <img src="https://placebeard.it/50/50?image=38" alt="Student" class="review-avatar">
                                <div class="review-info">
                                    <h6>Amit Kumar</h6>
                                    <div class="review-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span class="review-meta">React for Beginners • 3 weeks ago</span>
                                </div>
                            </div>
                            <p class="review-text">I was struggling with React before taking this course. Now I feel confident building my own applications. The instructor's teaching style is fantastic!</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
