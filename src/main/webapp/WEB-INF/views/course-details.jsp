<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.title} | SkillForge</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/course-details.css">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/common/header.jsp" />

    <!-- Course Header -->
    <section class="course-header py-5 bg-light">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/courses">Courses</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/courses?category=${course.categoryId}">${course.category.name}</a></li>
                            <li class="breadcrumb-item active" aria-current="page">${course.title}</li>
                        </ol>
                    </nav>
                    <h1 class="display-5 fw-bold mb-3">${course.title}</h1>
                    <p class="lead mb-4">${course.description}</p>
                    <div class="d-flex flex-wrap align-items-center mb-4">
                        <span class="badge bg-primary me-2">${course.category.name}</span>
                        <span class="badge bg-secondary me-3">${course.level}</span>
                        <span class="text-muted me-3"><i class="fas fa-users me-1"></i> ${enrollmentCount} students enrolled</span>
                        <span class="text-muted"><i class="fas fa-calendar me-1"></i> Created <fmt:formatDate value="${course.createdAt}" pattern="MMM dd, yyyy" /></span>
                    </div>
                    <div class="d-flex flex-wrap gap-2">
                        <c:choose>
                            <c:when test="${empty sessionScope.user}">
                                <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary">
                                    <i class="fas fa-sign-in-alt me-1"></i> Login to Enroll
                                </a>
                            </c:when>
                            <c:when test="${isEnrolled}">
                                <a href="${pageContext.request.contextPath}/enrollment/view?courseId=${course.courseId}" class="btn btn-success">
                                    <i class="fas fa-play-circle me-1"></i> Continue Learning
                                </a>
                                <a href="${pageContext.request.contextPath}/enrollment/unenroll?courseId=${course.courseId}" class="btn btn-outline-danger" onclick="return confirm('Are you sure you want to unenroll from this course?')">
                                    <i class="fas fa-times-circle me-1"></i> Unenroll
                                </a>
                            </c:when>
                            <c:when test="${sessionScope.user.role == 'student'}">
                                <a href="${pageContext.request.contextPath}/enrollment/enroll?courseId=${course.courseId}" class="btn btn-primary">
                                    <i class="fas fa-graduation-cap me-1"></i> Enroll Now
                                </a>
                            </c:when>
                            <c:when test="${sessionScope.user.userId == course.createdBy}">
                                <a href="${pageContext.request.contextPath}/instructor/courses/edit?id=${course.courseId}" class="btn btn-primary">
                                    <i class="fas fa-edit me-1"></i> Edit Course
                                </a>
                                <a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}" class="btn btn-outline-secondary">
                                    <i class="fas fa-cog me-1"></i> Manage Course
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="#" class="btn btn-secondary disabled">
                                    <i class="fas fa-info-circle me-1"></i> Instructors Cannot Enroll
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="col-lg-4 mt-4 mt-lg-0">
                    <div class="card border-0 shadow-sm">
                        <c:choose>
                            <c:when test="${not empty course.thumbnail}">
                                <img src="${pageContext.request.contextPath}${course.thumbnail}" class="card-img-top" alt="${course.title}">
                            </c:when>
                            <c:otherwise>
                                <img src="https://placebeard.it/600/400?image=${course.courseId % 10 + 1}" class="card-img-top" alt="${course.title}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-course-thumbnail.svg';">
                            </c:otherwise>
                        </c:choose>
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-3">Course Details</h5>
                            <ul class="list-unstyled mb-0">
                                <li class="d-flex align-items-center mb-3">
                                    <i class="fas fa-user-tie text-primary me-3 fa-fw"></i>
                                    <div>
                                        <span class="text-muted">Instructor</span>
                                        <p class="mb-0 fw-medium">${course.creator.name}</p>
                                    </div>
                                </li>
                                <li class="d-flex align-items-center mb-3">
                                    <i class="fas fa-signal text-primary me-3 fa-fw"></i>
                                    <div>
                                        <span class="text-muted">Level</span>
                                        <p class="mb-0 fw-medium">${course.level}</p>
                                    </div>
                                </li>
                                <li class="d-flex align-items-center mb-3">
                                    <i class="fas fa-folder text-primary me-3 fa-fw"></i>
                                    <div>
                                        <span class="text-muted">Category</span>
                                        <p class="mb-0 fw-medium">${course.category.name}</p>
                                    </div>
                                </li>
                                <li class="d-flex align-items-center">
                                    <i class="fas fa-users text-primary me-3 fa-fw"></i>
                                    <div>
                                        <span class="text-muted">Enrolled</span>
                                        <p class="mb-0 fw-medium">${enrollmentCount} students</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Course Content -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <!-- Course Description -->
                    <div class="content-card mb-4">
                        <div class="card-header">
                            <h4 class="mb-0">About This Course</h4>
                        </div>
                        <div class="card-body">
                            <p>${course.description}</p>
                            
                            <c:if test="${not empty course.prerequisites}">
                                <h5 class="mt-4">Prerequisites</h5>
                                <p>${course.prerequisites}</p>
                            </c:if>
                            
                            <c:if test="${not empty course.tags}">
                                <h5 class="mt-4">Tags</h5>
                                <div class="d-flex flex-wrap gap-2">
                                    <c:forEach items="${fn:split(course.tags, ',')}" var="tag">
                                        <span class="badge bg-light text-dark">${tag.trim()}</span>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    
                    <!-- Course Curriculum -->
                    <div class="content-card mb-4">
                        <div class="card-header">
                            <h4 class="mb-0">Course Curriculum</h4>
                        </div>
                        <div class="card-body">
                            <p class="text-muted">Enroll in this course to access the full curriculum.</p>
                            
                            <!-- Sample curriculum preview -->
                            <div class="accordion" id="curriculumAccordion">
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#module1">
                                            Module 1: Introduction
                                        </button>
                                    </h2>
                                    <div id="module1" class="accordion-collapse collapse" data-bs-parent="#curriculumAccordion">
                                        <div class="accordion-body">
                                            <ul class="list-group list-group-flush">
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <i class="fas fa-play-circle me-2 text-muted"></i>
                                                        Introduction to the Course
                                                    </div>
                                                    <span class="badge bg-light text-dark">Preview</span>
                                                </li>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <i class="fas fa-file-alt me-2 text-muted"></i>
                                                        Course Overview
                                                    </div>
                                                    <span class="badge bg-light text-dark">10 min</span>
                                                </li>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <i class="fas fa-puzzle-piece me-2 text-muted"></i>
                                                        Getting Started Quiz
                                                    </div>
                                                    <span class="badge bg-light text-dark">5 questions</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#module2">
                                            Module 2: Core Concepts
                                        </button>
                                    </h2>
                                    <div id="module2" class="accordion-collapse collapse" data-bs-parent="#curriculumAccordion">
                                        <div class="accordion-body">
                                            <ul class="list-group list-group-flush">
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <i class="fas fa-play-circle me-2 text-muted"></i>
                                                        Understanding the Basics
                                                    </div>
                                                    <span class="badge bg-light text-dark">15 min</span>
                                                </li>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <i class="fas fa-file-alt me-2 text-muted"></i>
                                                        Key Principles
                                                    </div>
                                                    <span class="badge bg-light text-dark">20 min</span>
                                                </li>
                                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <i class="fas fa-puzzle-piece me-2 text-muted"></i>
                                                        Practice Exercise
                                                    </div>
                                                    <span class="badge bg-light text-dark">Assignment</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Instructor Info -->
                    <div class="content-card">
                        <div class="card-header">
                            <h4 class="mb-0">About the Instructor</h4>
                        </div>
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <c:choose>
                                    <c:when test="${not empty course.creator.profileImage}">
                                        <img src="${pageContext.request.contextPath}${course.creator.profileImage}" alt="${course.creator.name}" class="rounded-circle me-3" width="64" height="64">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://placebeard.it/64/64?image=${course.creator.userId % 10 + 20}" alt="${course.creator.name}" class="rounded-circle me-3" width="64" height="64">
                                    </c:otherwise>
                                </c:choose>
                                <div>
                                    <h5 class="mb-1">${course.creator.name}</h5>
                                    <p class="text-muted mb-0">@${course.creator.userName}</p>
                                </div>
                            </div>
                            <p>${course.creator.bio}</p>
                        </div>
                    </div>
                </div>
                
                <!-- Sidebar -->
                <div class="col-lg-4 mt-4 mt-lg-0">
                    <!-- Related Courses -->
                    <div class="sidebar-card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">Related Courses</h5>
                        </div>
                        <div class="card-body p-0">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item p-3">
                                    <div class="d-flex">
                                        <img src="https://placebeard.it/80/60?image=5" class="me-3" alt="Related Course">
                                        <div>
                                            <h6 class="mb-1">Advanced Techniques</h6>
                                            <p class="text-muted small mb-0">Take your skills to the next level</p>
                                        </div>
                                    </div>
                                </li>
                                <li class="list-group-item p-3">
                                    <div class="d-flex">
                                        <img src="https://placebeard.it/80/60?image=6" class="me-3" alt="Related Course">
                                        <div>
                                            <h6 class="mb-1">Practical Applications</h6>
                                            <p class="text-muted small mb-0">Real-world examples and case studies</p>
                                        </div>
                                    </div>
                                </li>
                                <li class="list-group-item p-3">
                                    <div class="d-flex">
                                        <img src="https://placebeard.it/80/60?image=7" class="me-3" alt="Related Course">
                                        <div>
                                            <h6 class="mb-1">Certification Preparation</h6>
                                            <p class="text-muted small mb-0">Get ready for industry certifications</p>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Student Feedback -->
                    <div class="sidebar-card">
                        <div class="card-header">
                            <h5 class="mb-0">Student Feedback</h5>
                        </div>
                        <div class="card-body">
                            <div class="text-center mb-3">
                                <h2 class="display-4 fw-bold">4.8</h2>
                                <div class="text-warning mb-1">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star-half-alt"></i>
                                </div>
                                <p class="text-muted">Course Rating</p>
                            </div>
                            
                            <!-- Sample reviews -->
                            <div class="review-item mb-3 pb-3 border-bottom">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <h6 class="mb-0">John Doe</h6>
                                    <div class="text-warning">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                </div>
                                <p class="small mb-0">"This course exceeded my expectations. The instructor explains complex concepts in a very clear and understandable way."</p>
                            </div>
                            
                            <div class="review-item">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <h6 class="mb-0">Jane Smith</h6>
                                    <div class="text-warning">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </div>
                                </div>
                                <p class="small mb-0">"Great content and well-structured lessons. I would have liked more practical examples, but overall very helpful."</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-5 bg-primary text-white">
        <div class="container text-center">
            <h2 class="fw-bold mb-3">Ready to Start Learning?</h2>
            <p class="lead mb-4">Join thousands of students who are already advancing their careers with SkillForge.</p>
            <div class="d-flex justify-content-center gap-3">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-light btn-lg px-4">Login to Enroll</a>
                        <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-outline-light btn-lg px-4">Sign Up Now</a>
                    </c:when>
                    <c:when test="${isEnrolled}">
                        <a href="${pageContext.request.contextPath}/enrollment/view?courseId=${course.courseId}" class="btn btn-light btn-lg px-4">Continue Learning</a>
                    </c:when>
                    <c:when test="${sessionScope.user.role == 'student'}">
                        <a href="${pageContext.request.contextPath}/enrollment/enroll?courseId=${course.courseId}" class="btn btn-light btn-lg px-4">Enroll Now</a>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- Include Footer -->
    <jsp:include page="/common/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
