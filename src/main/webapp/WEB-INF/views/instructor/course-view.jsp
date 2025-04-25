<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/header.jsp" %>

<div class="container-fluid py-4">
    <div class="container">
        <!-- Success Messages -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="success" scope="session" />
        </c:if>
        <!-- Course Header -->
        <div class="row mb-4">
            <div class="col-md-8">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/instructor/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/instructor/courses/">My Courses</a></li>
                        <li class="breadcrumb-item active" aria-current="page">${course.title}</li>
                    </ol>
                </nav>
                <h1 class="mb-2">${course.title}</h1>
                <div class="d-flex align-items-center mb-3">
                    <span class="badge ${course.status == 'active' ? 'bg-success' : 'bg-warning text-dark'} me-2">
                        ${course.status == 'active' ? 'Published' : 'Draft'}
                    </span>
                    <span class="text-muted me-3"><i class="fas fa-folder me-1"></i> ${course.category.name}</span>
                    <span class="text-muted me-3"><i class="fas fa-signal me-1"></i> ${course.level}</span>
                    <span class="text-muted"><i class="fas fa-users me-1"></i> 0 students</span>
                </div>
            </div>
            <div class="col-md-4 text-end">
                <div class="btn-group">
                    <a href="${pageContext.request.contextPath}/instructor/courses/edit?id=${course.courseId}" class="btn btn-primary">
                        <i class="fas fa-edit me-1"></i> Edit Course
                    </a>
                    <button type="button" class="btn btn-primary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="visually-hidden">Toggle Dropdown</span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <c:choose>
                            <c:when test="${course.status == 'active'}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/instructor/courses/toggle-status?id=${course.courseId}"><i class="fas fa-pause-circle me-2"></i> Unpublish</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/instructor/courses/toggle-status?id=${course.courseId}"><i class="fas fa-check-circle me-2"></i> Publish</a></li>
                            </c:otherwise>
                        </c:choose>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-chart-bar me-2"></i> Analytics</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-users me-2"></i> Students</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="#"><i class="fas fa-trash-alt me-2"></i> Delete</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Course Content -->
            <div class="col-lg-8">
                <!-- Course Thumbnail -->
                <div class="card mb-4 border-0 shadow-sm">
                    <div class="course-thumbnail-container">
                        <c:choose>
                            <c:when test="${not empty course.thumbnail}">
                                <img src="${pageContext.request.contextPath}${course.thumbnail}" alt="${course.title}" class="img-fluid rounded" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-course-thumbnail.svg';">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/images/default-course-thumbnail.svg" alt="${course.title}" class="img-fluid rounded">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Course Description -->
                <div class="card mb-4 border-0 shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0">Course Description</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty course.description}">
                                <p>${course.description}</p>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted">No description provided.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Course Content Sections -->
                <div class="card mb-4 border-0 shadow-sm">
                    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Course Content</h5>
                        <a href="${pageContext.request.contextPath}/instructor/add-module?courseId=${course.courseId}" class="btn btn-sm btn-primary">
                            <i class="fas fa-plus me-1"></i> Add Module
                        </a>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${empty modules}">
                                <div class="text-center py-5">
                                    <div class="mb-3">
                                        <i class="fas fa-book-open fa-3x text-muted"></i>
                                    </div>
                                    <h5>No content yet</h5>
                                    <p class="text-muted">Start building your course by adding modules and lessons.</p>
                                    <a href="${pageContext.request.contextPath}/instructor/add-module?courseId=${course.courseId}" class="btn btn-primary">
                                        <i class="fas fa-plus me-1"></i> Add First Module
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="accordion" id="courseContentAccordion">
                                    <c:forEach items="${modules}" var="module" varStatus="moduleStatus">
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="heading${module.moduleId}">
                                                <button class="accordion-button ${moduleStatus.first ? '' : 'collapsed'}" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${module.moduleId}" aria-expanded="${moduleStatus.first ? 'true' : 'false'}" aria-controls="collapse${module.moduleId}">
                                                    <div class="d-flex justify-content-between align-items-center w-100 me-3">
                                                        <span>${module.title}</span>
                                                        <span class="badge bg-secondary rounded-pill">${fn:length(module.lessons)} lessons</span>
                                                    </div>
                                                </button>
                                            </h2>
                                            <div id="collapse${module.moduleId}" class="accordion-collapse collapse ${moduleStatus.first ? 'show' : ''}" aria-labelledby="heading${module.moduleId}" data-bs-parent="#courseContentAccordion">
                                                <div class="accordion-body p-0">
                                                    <ul class="list-group list-group-flush">
                                                        <c:forEach items="${module.lessons}" var="lesson">
                                                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                                                <div>
                                                                    <i class="fas fa-file-alt me-2"></i>
                                                                    <a href="${pageContext.request.contextPath}/instructor/view-lesson?id=${lesson.lessonId}" class="text-decoration-none text-dark">
                                                                        ${lesson.title}
                                                                    </a>
                                                                </div>
                                                                <div>
                                                                    <c:if test="${lesson.duration > 0}">
                                                                        <span class="text-muted me-3"><i class="fas fa-clock me-1"></i> ${lesson.duration} min</span>
                                                                    </c:if>
                                                                    <a href="${pageContext.request.contextPath}/instructor/view-lesson?id=${lesson.lessonId}" class="btn btn-sm btn-outline-secondary me-1">
                                                                        <i class="fas fa-eye"></i>
                                                                    </a>
                                                                    <a href="${pageContext.request.contextPath}/instructor/edit-lesson?id=${lesson.lessonId}" class="btn btn-sm btn-outline-primary">
                                                                        <i class="fas fa-edit"></i>
                                                                    </a>
                                                                </div>
                                                            </li>
                                                        </c:forEach>
                                                        <li class="list-group-item text-center">
                                                            <a href="${pageContext.request.contextPath}/instructor/add-lesson?moduleId=${module.moduleId}" class="btn btn-sm btn-outline-primary">
                                                                <i class="fas fa-plus me-1"></i> Add Lesson
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Course Requirements -->
                <div class="card mb-4 border-0 shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0">Requirements</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty course.prerequisites}">
                                <p>${course.prerequisites}</p>
                            </c:when>
                            <c:otherwise>
                                <p class="text-muted">No requirements specified.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Course Sidebar -->
            <div class="col-lg-4">
                <!-- Course Actions -->
                <div class="card mb-4 border-0 shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0">Course Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/instructor/courses/edit?id=${course.courseId}" class="btn btn-primary">
                                <i class="fas fa-edit me-2"></i> Edit Course Details
                            </a>
                            <a href="${pageContext.request.contextPath}/instructor/add-module?courseId=${course.courseId}" class="btn btn-outline-primary">
                                <i class="fas fa-plus-circle me-2"></i> Add Module
                            </a>
                            <c:choose>
                                <c:when test="${course.status == 'active'}">
                                    <a href="${pageContext.request.contextPath}/instructor/courses/toggle-status?id=${course.courseId}" class="btn btn-outline-warning">
                                        <i class="fas fa-pause-circle me-2"></i> Unpublish Course
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/instructor/courses/toggle-status?id=${course.courseId}" class="btn btn-success">
                                        <i class="fas fa-check-circle me-2"></i> Publish Course
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Course Information -->
                <div class="card mb-4 border-0 shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0">Course Information</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>Status</span>
                                <span class="badge ${course.status == 'active' ? 'bg-success' : 'bg-warning text-dark'}">
                                    ${course.status == 'active' ? 'Published' : 'Draft'}
                                </span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>Category</span>
                                <span>${course.category.name}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>Level</span>
                                <span>${course.level}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>Created</span>
                                <span>${course.createdAt}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>Last Updated</span>
                                <span>${course.updatedAt}</span>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Course Statistics -->
                <div class="card mb-4 border-0 shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0">Statistics</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>Enrolled Students</span>
                                <span class="badge bg-primary rounded-pill">0</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>Modules</span>
                                <span class="badge bg-primary rounded-pill">${fn:length(modules)}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>Lessons</span>
                                <span class="badge bg-primary rounded-pill">
                                    <c:set var="totalLessons" value="0" />
                                    <c:forEach items="${modules}" var="module">
                                        <c:set var="totalLessons" value="${totalLessons + fn:length(module.lessons)}" />
                                    </c:forEach>
                                    ${totalLessons}
                                </span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>Quizzes</span>
                                <span class="badge bg-primary rounded-pill">0</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>Assignments</span>
                                <span class="badge bg-primary rounded-pill">0</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
