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
                    <li class="breadcrumb-item active" aria-current="page">${lesson.title}</li>
                </ol>
            </nav>
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
            <!-- Lesson Header -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2 class="mb-0">${lesson.title}</h2>
                        <div>
                            <a href="${pageContext.request.contextPath}/instructor/edit-lesson?id=${lesson.lessonId}" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-edit me-1"></i> Edit
                            </a>
                        </div>
                    </div>
                    <div class="d-flex align-items-center text-muted mb-3">
                        <span class="me-3"><i class="fas fa-book me-1"></i> Module: ${module.title}</span>
                        <c:if test="${lesson.duration > 0}">
                            <span><i class="fas fa-clock me-1"></i> ${lesson.duration} minutes</span>
                        </c:if>
                    </div>
                    <c:if test="${not empty lesson.resourceLink}">
                        <div class="mb-3">
                            <a href="${lesson.resourceLink}" target="_blank" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-external-link-alt me-1"></i> External Resource
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Content Blocks -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Lesson Content</h5>
                    <a href="${pageContext.request.contextPath}/instructor/add-content-block?lessonId=${lesson.lessonId}" class="btn btn-sm btn-primary">
                        <i class="fas fa-plus me-1"></i> Add Content Block
                    </a>
                </div>
                <div class="card-body p-4">
                    <c:choose>
                        <c:when test="${empty contentBlocks}">
                            <div class="text-center py-5">
                                <i class="fas fa-file-alt fa-3x text-muted mb-3"></i>
                                <h5>No Content Blocks Yet</h5>
                                <p class="text-muted">This lesson doesn't have any content blocks yet.</p>
                                <a href="${pageContext.request.contextPath}/instructor/add-content-block?lessonId=${lesson.lessonId}" class="btn btn-primary">
                                    <i class="fas fa-plus me-1"></i> Add First Content Block
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="content-blocks">
                                <c:forEach items="${contentBlocks}" var="block" varStatus="status">
                                    <div class="content-block mb-4 pb-4 ${!status.last ? 'border-bottom' : ''}">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <div>
                                                <c:if test="${not empty block.title}">
                                                    <h5 class="mb-0">${block.title}</h5>
                                                </c:if>
                                                <small class="text-muted">
                                                    <i class="fas fa-${block.blockType == 'TEXT' ? 'align-left' : block.blockType == 'VIDEO' ? 'video' : block.blockType == 'IMAGE' ? 'image' : block.blockType == 'CODE' ? 'code' : block.blockType == 'DOCUMENT' ? 'file-alt' : 'code'} me-1"></i>
                                                    ${block.blockType}
                                                </small>
                                            </div>
                                            <div>
                                                <a href="${pageContext.request.contextPath}/instructor/edit-content-block?id=${block.contentBlockId}" class="btn btn-sm btn-outline-secondary me-1">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/instructor/delete-content-block?id=${block.contentBlockId}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this content block?');">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </div>
                                        </div>

                                        <c:choose>
                                            <c:when test="${block.blockType == 'TEXT'}">
                                                <div class="content-text">
                                                    ${block.content}
                                                </div>
                                            </c:when>
                                            <c:when test="${block.blockType == 'VIDEO'}">
                                                <div class="content-video">
                                                    <c:choose>
                                                        <c:when test="${fn:startsWith(block.content, '/uploads/')}">
                                                            <!-- Display uploaded video file -->
                                                            <div class="ratio ratio-16x9 mb-3">
                                                                <video controls>
                                                                    <source src="${pageContext.request.contextPath}${block.content}" type="video/mp4">
                                                                    Your browser does not support the video tag.
                                                                </video>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- Display video from URL (YouTube, Vimeo, etc.) -->
                                                            <div class="ratio ratio-16x9 mb-3">
                                                                <iframe src="${block.content}" title="${block.title}" allowfullscreen></iframe>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:if test="${not empty block.description}">
                                                        <p class="text-muted">${block.description}</p>
                                                    </c:if>
                                                </div>
                                            </c:when>
                                            <c:when test="${block.blockType == 'IMAGE'}">
                                                <div class="content-image">
                                                    <img src="${fn:startsWith(block.content, '/uploads/') ? pageContext.request.contextPath : ''}${block.content}"
                                                         alt="${block.title}" class="img-fluid mb-2">
                                                    <c:if test="${not empty block.description}">
                                                        <p class="text-muted">${block.description}</p>
                                                    </c:if>
                                                </div>
                                            </c:when>
                                            <c:when test="${block.blockType == 'CODE'}">
                                                <div class="content-code">
                                                    <pre class="bg-light p-3 rounded"><code>${block.content}</code></pre>
                                                </div>
                                            </c:when>
                                            <c:when test="${block.blockType == 'DOCUMENT'}">
                                                <div class="content-document">
                                                    <c:choose>
                                                        <c:when test="${fn:startsWith(block.content, '/uploads/')}">
                                                            <!-- Display uploaded document file -->
                                                            <div class="document-preview mb-3">
                                                                <c:set var="fileName" value="${fn:substringAfter(block.content, '/')}" />
                                                                <c:set var="fileExtension" value="${fn:toLowerCase(fn:substringAfter(fileName, '.'))}"/>
                                                                <c:choose>
                                                                    <c:when test="${fileExtension == 'pdf'}">
                                                                        <!-- PDF Preview -->
                                                                        <div class="ratio ratio-16x9 mb-3">
                                                                            <iframe src="${pageContext.request.contextPath}${block.content}"
                                                                                    title="${block.title}" allowfullscreen></iframe>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:when test="${fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png' || fileExtension == 'gif'}">
                                                                        <!-- Image Preview -->
                                                                        <img src="${pageContext.request.contextPath}${block.content}"
                                                                             alt="${block.title}" class="img-fluid mb-2">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <!-- Document Icon -->
                                                                        <div class="text-center p-4 bg-light rounded mb-3">
                                                                            <i class="fas fa-file-${fileExtension == 'pdf' ? 'pdf' :
                                                                                                fileExtension == 'doc' || fileExtension == 'docx' ? 'word' :
                                                                                                fileExtension == 'xls' || fileExtension == 'xlsx' ? 'excel' :
                                                                                                fileExtension == 'ppt' || fileExtension == 'pptx' ? 'powerpoint' :
                                                                                                'alt'} fa-4x mb-3 text-primary"></i>
                                                                            <h5>${fileName}</h5>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <a href="${pageContext.request.contextPath}${block.content}" target="_blank" class="btn btn-outline-primary">
                                                                <i class="fas fa-file-download me-2"></i> Download Document
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- Display document from URL -->
                                                            <a href="${block.content}" target="_blank" class="btn btn-outline-primary">
                                                                <i class="fas fa-file-download me-2"></i> Download Document
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:if test="${not empty block.description}">
                                                        <p class="text-muted mt-2">${block.description}</p>
                                                    </c:if>
                                                </div>
                                            </c:when>
                                            <c:when test="${block.blockType == 'EMBED'}">
                                                <div class="content-embed">
                                                    ${block.content}
                                                </div>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <!-- Lesson Actions -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Lesson Actions</h5>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/instructor/edit-lesson?id=${lesson.lessonId}" class="btn btn-primary">
                            <i class="fas fa-edit me-2"></i> Edit Lesson Details
                        </a>
                        <a href="${pageContext.request.contextPath}/instructor/add-content-block?lessonId=${lesson.lessonId}" class="btn btn-outline-primary">
                            <i class="fas fa-plus-circle me-2"></i> Add Content Block
                        </a>
                        <a href="${pageContext.request.contextPath}/instructor/preview-lesson?id=${lesson.lessonId}" class="btn btn-outline-secondary">
                            <i class="fas fa-eye me-2"></i> Preview as Student
                        </a>
                        <a href="${pageContext.request.contextPath}/instructor/delete-lesson?id=${lesson.lessonId}" class="btn btn-outline-danger" onclick="return confirm('Are you sure you want to delete this lesson? This action cannot be undone.');">
                            <i class="fas fa-trash me-2"></i> Delete Lesson
                        </a>
                    </div>
                </div>
            </div>

            <!-- Module Information -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Module Information</h5>
                </div>
                <div class="card-body">
                    <h6>${module.title}</h6>
                    <p class="text-muted">This lesson is part of the module "${module.title}" in the course "${course.title}".</p>
                    <a href="${pageContext.request.contextPath}/instructor/courses/view?id=${course.courseId}" class="btn btn-sm btn-outline-secondary">
                        <i class="fas fa-arrow-left me-1"></i> Back to Course
                    </a>
                </div>
            </div>

            <!-- Lesson Information -->
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Lesson Information</h5>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span>Duration</span>
                            <span>${lesson.duration > 0 ? lesson.duration : 'Not specified'} ${lesson.duration == 1 ? 'minute' : 'minutes'}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between px-0">
                            <span>Content Blocks</span>
                            <span class="badge bg-primary rounded-pill">${fn:length(contentBlocks)}</span>
                        </li>
                        <c:if test="${not empty lesson.resourceLink}">
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>External Resource</span>
                                <a href="${lesson.resourceLink}" target="_blank">View</a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
