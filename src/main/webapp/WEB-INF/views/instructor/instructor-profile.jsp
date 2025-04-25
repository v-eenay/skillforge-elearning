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
                                <img src="${pageContext.request.contextPath}${userProfile.profileImage.startsWith('/') ? '' : '/'}${userProfile.profileImage}" alt="${userProfile.name}" class="rounded-circle img-fluid" style="width: 150px; height: 150px; object-fit: cover;" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-profile.svg';">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/images/default-profile.svg" alt="${userProfile.name}" class="rounded-circle img-fluid" style="width: 150px; height: 150px; object-fit: cover;">
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


        </div>

        <!-- Profile Content -->
        <div class="col-lg-8">
            <!-- Alerts -->
            <%@ include file="/common/alert-messages.jsp" %>

            <!-- Edit Profile -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white p-4 border-0 d-flex justify-content-between align-items-center">
                    <h4 class="fw-bold mb-0">Edit Profile</h4>
                    <a href="${pageContext.request.contextPath}/instructor/profile" class="btn btn-outline-primary">View Profile</a>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/instructor/profile" method="post" enctype="multipart/form-data">
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
                                            <img src="${pageContext.request.contextPath}${userProfile.profileImage.startsWith('/') ? '' : '/'}${userProfile.profileImage}" alt="Current profile image" class="rounded-circle me-3" style="width: 64px; height: 64px; object-fit: cover;" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-profile.svg';">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/assets/images/default-profile.svg" alt="Current profile image" class="rounded-circle me-3" style="width: 64px; height: 64px; object-fit: cover;">
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
                                <small class="text-muted">Tell students about yourself, your expertise, and teaching style</small>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Course Statistics -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white p-4 border-0 d-flex justify-content-between align-items-center">
                    <h4 class="fw-bold mb-0">Course Statistics</h4>
                    <a href="${pageContext.request.contextPath}/instructor/courses/" class="btn btn-sm btn-outline-primary">View All Courses</a>
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
                            <img src="https://placebeard.it/50/50?image=39" alt="Student" class="rounded-circle me-3" style="object-fit: cover;">
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
                            <img src="https://placebeard.it/50/50?image=40" alt="Student" class="rounded-circle me-3" style="object-fit: cover;">
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
                            <img src="https://placebeard.it/50/50?image=41" alt="Student" class="rounded-circle me-3" style="object-fit: cover;">
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
