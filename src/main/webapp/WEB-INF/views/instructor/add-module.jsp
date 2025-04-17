<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/header.jsp" %>

<div class="container py-4">
    <div class="row mb-4">
        <div class="col-md-8">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/instructor/dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/instructor/courses/">My Courses</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}">${course.title}</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Add Module</li>
                </ol>
            </nav>
            <h2 class="mb-3">Add New Module</h2>
            <p class="text-muted">Create a new module for your course "${course.title}"</p>
        </div>
        <div class="col-md-4 text-end">
            <a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Course
            </a>
        </div>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Module Details</h5>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/instructor/add-module" method="post" id="addModuleForm">
                        <input type="hidden" name="courseId" value="${course.courseId}">

                        <div class="mb-4">
                            <label for="moduleTitle" class="form-label">Module Title <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="moduleTitle" name="title" required
                                   placeholder="e.g., Introduction to the Course" maxlength="255">
                            <div class="form-text">Give your module a clear and descriptive title.</div>
                        </div>

                        <div class="mb-4">
                            <label for="moduleOrder" class="form-label">Module Order</label>
                            <input type="number" class="form-control" id="moduleOrder" name="orderIndex"
                                   value="${nextOrderIndex}" min="1">
                            <div class="form-text">The order in which this module appears in the course. Leave as is to add to the end.</div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label d-block">After creating this module:</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="afterAction" id="afterActionReturn" value="return" checked>
                                <label class="form-check-label" for="afterActionReturn">Return to course view</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="afterAction" id="afterActionAddLesson" value="addLesson">
                                <label class="form-check-label" for="afterActionAddLesson">Add lesson to this module</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="afterAction" id="afterActionAddAnother" value="addAnother">
                                <label class="form-check-label" for="afterActionAddAnother">Add another module</label>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}" class="btn btn-outline-secondary">
                                <i class="fas fa-times me-2"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Save Module
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">About Modules</h5>
                </div>
                <div class="card-body p-4">
                    <p>Modules are the main sections of your course. They help organize your content into logical units.</p>

                    <div class="alert alert-info">
                        <h6 class="alert-heading"><i class="fas fa-lightbulb me-2"></i>Tips for Creating Modules</h6>
                        <ul class="mb-0 ps-3">
                            <li>Use clear, descriptive titles</li>
                            <li>Group related content together</li>
                            <li>Keep modules balanced in size</li>
                            <li>Consider a logical progression of topics</li>
                        </ul>
                    </div>

                    <p class="mb-0">After creating a module, you can add lessons, quizzes, and assignments to it.</p>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Current Modules</h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty modules}">
                            <div class="p-4 text-center">
                                <p class="text-muted mb-0">No modules yet. This will be your first module!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${modules}" var="module" varStatus="status">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <span class="badge bg-secondary rounded-pill me-2">${status.index + 1}</span>
                                            ${module.title}
                                        </div>
                                        <span class="badge bg-light text-dark">${fn:length(module.lessons)} lessons</span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Client-side validation
    document.getElementById('addModuleForm').addEventListener('submit', function(event) {
        const titleInput = document.getElementById('moduleTitle');
        if (!titleInput.value.trim()) {
            event.preventDefault();
            titleInput.classList.add('is-invalid');

            // Add invalid feedback if it doesn't exist
            if (!document.querySelector('.invalid-feedback')) {
                const feedback = document.createElement('div');
                feedback.className = 'invalid-feedback';
                feedback.textContent = 'Module title is required';
                titleInput.parentNode.appendChild(feedback);
            }
        }
    });

    // Remove invalid state when user types
    document.getElementById('moduleTitle').addEventListener('input', function() {
        this.classList.remove('is-invalid');
    });
</script>

<%@ include file="/common/footer.jsp" %>
