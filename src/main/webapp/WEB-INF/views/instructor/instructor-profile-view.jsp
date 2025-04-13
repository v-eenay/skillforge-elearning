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
                                <img src="${pageContext.request.contextPath}${userProfile.profileImage}" alt="${userProfile.name}" class="rounded-circle img-fluid" style="width: 150px; height: 150px; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center mx-auto" style="width: 150px; height: 150px; font-size: 4rem;">
                                    ${fn:substring(userProfile.name, 0, 1)}
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <h3 class="fw-bold mb-1">${userProfile.name}</h3>
                    <p class="text-muted mb-3">@${userProfile.userName}</p>
                    <p class="mb-3">${userProfile.bio}</p>
                    <div class="d-flex justify-content-center">
                        <span class="badge bg-info me-2 px-3 py-2">Instructor</span>
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
                    <div class="d-flex justify-content-between mb-3">
                        <span class="fw-bold">Courses</span>
                        <span>5 Published</span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="fw-bold">Students</span>
                        <span>247 Enrolled</span>
                    </div>
                </div>
            </div>
            
            <div class="card border-0 shadow-sm mt-4">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-3">Quick Links</h5>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item px-0 py-2 border-0">
                            <a href="${pageContext.request.contextPath}/instructor/dashboard" class="text-decoration-none d-flex align-items-center">
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
                                <i class="fas fa-users me-2"></i> My Students
                            </a>
                        </li>
                        <li class="list-group-item px-0 py-2 border-0">
                            <a href="#" class="text-decoration-none d-flex align-items-center">
                                <i class="fas fa-chart-line me-2"></i> Analytics
                            </a>
                        </li>
                        <li class="list-group-item px-0 py-2 border-0">
                            <a href="${pageContext.request.contextPath}/instructor/profile/edit" class="text-decoration-none d-flex align-items-center">
                                <i class="fas fa-edit me-2"></i> Edit Profile
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
            
            <!-- Course Statistics -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white p-4 border-0 d-flex justify-content-between align-items-center">
                    <h4 class="fw-bold mb-0">Course Statistics</h4>
                    <a href="#" class="btn btn-sm btn-outline-primary">View All Courses</a>
                </div>
                <div class="card-body p-4">
                    <div class="table-responsive">
                        <table class="table table-hover">
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
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white p-4 border-0 d-flex justify-content-between align-items-center">
                    <h4 class="fw-bold mb-0">Student Reviews</h4>
                    <a href="#" class="btn btn-sm btn-outline-primary">View All</a>
                </div>
                <div class="card-body p-4">
                    <div class="mb-4 pb-4 border-bottom">
                        <div class="d-flex mb-3">
                            <img src="https://placedog.net/50/50?id=1" alt="Student" class="rounded-circle me-3">
                            <div>
                                <h6 class="mb-1">Rajesh Sharma</h6>
                                <div class="text-warning mb-2">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <small class="text-muted">Web Development Fundamentals • 2 weeks ago</small>
                            </div>
                        </div>
                        <p class="mb-0">Excellent course! The instructor explains complex concepts in a very simple and understandable way. I've learned so much in just a few weeks.</p>
                    </div>
                    
                    <div class="mb-4 pb-4 border-bottom">
                        <div class="d-flex mb-3">
                            <img src="https://placedog.net/50/50?id=2" alt="Student" class="rounded-circle me-3">
                            <div>
                                <h6 class="mb-1">Priya Patel</h6>
                                <div class="text-warning mb-2">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star-half-alt"></i>
                                </div>
                                <small class="text-muted">Advanced JavaScript • 1 month ago</small>
                            </div>
                        </div>
                        <p class="mb-0">This course took my JavaScript skills to the next level. The projects were challenging but very rewarding. Highly recommended!</p>
                    </div>
                    
                    <div>
                        <div class="d-flex mb-3">
                            <img src="https://placedog.net/50/50?id=3" alt="Student" class="rounded-circle me-3">
                            <div>
                                <h6 class="mb-1">Amit Kumar</h6>
                                <div class="text-warning mb-2">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <small class="text-muted">React for Beginners • 3 weeks ago</small>
                            </div>
                        </div>
                        <p class="mb-0">I was struggling with React before taking this course. Now I feel confident building my own applications. The instructor's teaching style is fantastic!</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
