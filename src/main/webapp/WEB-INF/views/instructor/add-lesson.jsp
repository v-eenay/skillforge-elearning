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
                    <li class="breadcrumb-item active" aria-current="page">Add Lesson to ${module.title}</li>
                </ol>
            </nav>
            <h2 class="mb-3">Add New Lesson</h2>
            <p class="text-muted">Create a new lesson for the module "${module.title}"</p>
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
    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${requestScope.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty sessionScope.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${sessionScope.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="success" scope="session" />
    </c:if>

    <div class="row">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Lesson Details</h5>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/instructor/add-lesson" method="post" id="addLessonForm" autocomplete="off">
                        <input type="hidden" name="moduleId" value="${module.moduleId}">
                        
                        <div class="mb-4">
                            <label for="lessonTitle" class="form-label">Lesson Title <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="lessonTitle" name="title" required 
                                   placeholder="e.g., Introduction to the Topic" maxlength="255" value="${param.title}">
                            <div class="form-text">Give your lesson a clear and descriptive title.</div>
                        </div>
                        
                        <div class="mb-4">
                            <label for="lessonContent" class="form-label">Lesson Content</label>
                            <textarea class="form-control" id="lessonContent" name="content" rows="8" 
                                      placeholder="Enter the lesson content here...">${param.content}</textarea>
                            <div class="form-text">You can use Markdown formatting for rich text.</div>
                        </div>
                        
                        <div class="mb-4">
                            <label for="lessonDuration" class="form-label">Duration (minutes)</label>
                            <input type="number" class="form-control" id="lessonDuration" name="duration" 
                                   value="${not empty param.duration ? param.duration : 0}" min="0">
                            <div class="form-text">Estimated time to complete this lesson in minutes.</div>
                        </div>
                        
                        <div class="mb-4">
                            <label for="resourceLink" class="form-label">Resource Link (Optional)</label>
                            <input type="url" class="form-control" id="resourceLink" name="resourceLink" 
                                   placeholder="e.g., https://example.com/resource" value="${param.resourceLink}">
                            <div class="form-text">Add a link to an external resource (video, article, etc.).</div>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label d-block">After creating this lesson:</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="afterAction" id="afterActionReturn" value="return" checked>
                                <label class="form-check-label" for="afterActionReturn">Return to course view</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="afterAction" id="afterActionAddAnother" value="addAnother">
                                <label class="form-check-label" for="afterActionAddAnother">Add another lesson</label>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}" class="btn btn-outline-secondary">
                                <i class="fas fa-times me-2"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Save Lesson
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">About Lessons</h5>
                </div>
                <div class="card-body p-4">
                    <p>Lessons are the building blocks of your modules. They contain the actual content that students will learn.</p>
                    
                    <div class="alert alert-info">
                        <h6 class="alert-heading"><i class="fas fa-lightbulb me-2"></i>Tips for Creating Lessons</h6>
                        <ul class="mb-0 ps-3">
                            <li>Use clear, descriptive titles</li>
                            <li>Keep content focused on a single topic</li>
                            <li>Include examples and practical applications</li>
                            <li>Add external resources for further learning</li>
                        </ul>
                    </div>
                    
                    <p class="mb-0">You can add different types of content to your lessons, including text, images, videos, and more.</p>
                </div>
            </div>
            
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Current Lessons in Module</h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty module.lessons}">
                            <div class="p-4 text-center">
                                <p class="text-muted mb-0">No lessons yet. This will be your first lesson in this module!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${module.lessons}" var="lesson" varStatus="status">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <span class="badge bg-secondary rounded-pill me-2">${status.index + 1}</span>
                                            ${lesson.title}
                                        </div>
                                        <c:if test="${lesson.duration > 0}">
                                            <span class="badge bg-light text-dark">${lesson.duration} min</span>
                                        </c:if>
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
    document.getElementById('addLessonForm').addEventListener('submit', function(event) {
        const titleInput = document.getElementById('lessonTitle');
        if (!titleInput.value.trim()) {
            event.preventDefault();
            titleInput.classList.add('is-invalid');
            
            // Add invalid feedback if it doesn't exist
            if (!document.querySelector('.invalid-feedback')) {
                const feedback = document.createElement('div');
                feedback.className = 'invalid-feedback';
                feedback.textContent = 'Lesson title is required';
                titleInput.parentNode.appendChild(feedback);
            }
        }
    });
    
    // Remove invalid state when user types
    document.getElementById('lessonTitle').addEventListener('input', function() {
        this.classList.remove('is-invalid');
    });
</script>

<%@ include file="/common/footer.jsp" %>
