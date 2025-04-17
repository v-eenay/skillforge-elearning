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
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/instructor/view-lesson?id=${lesson.lessonId}">${lesson.title}</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Preview as Student</li>
                </ol>
            </nav>
        </div>
        <div class="col-md-4 text-end">
            <a href="${pageContext.request.contextPath}/instructor/view-lesson?id=${lesson.lessonId}" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Lesson
            </a>
        </div>
    </div>

    <!-- Preview Mode Banner -->
    <div class="alert alert-info mb-4">
        <div class="d-flex align-items-center">
            <i class="fas fa-eye fa-2x me-3"></i>
            <div>
                <h5 class="mb-1">Preview Mode</h5>
                <p class="mb-0">You are previewing this lesson as a student would see it.</p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8">
            <!-- Lesson Header -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body p-4">
                    <h2 class="mb-3">${lesson.title}</h2>
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
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Lesson Content</h5>
                </div>
                <div class="card-body p-4">
                    <c:choose>
                        <c:when test="${empty contentBlocks}">
                            <div class="text-center py-5">
                                <i class="fas fa-file-alt fa-3x text-muted mb-3"></i>
                                <h5>No Content Yet</h5>
                                <p class="text-muted">This lesson doesn't have any content blocks yet.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="content-blocks">
                                <c:forEach items="${contentBlocks}" var="block" varStatus="status">
                                    <div class="content-block mb-4 pb-4 ${!status.last ? 'border-bottom' : ''}">
                                        <c:if test="${not empty block.title}">
                                            <h5 class="mb-3">${block.title}</h5>
                                        </c:if>

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
            <!-- Course Navigation -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Course Navigation</h5>
                </div>
                <div class="card-body p-0">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item p-3">
                            <h6 class="mb-1">${module.title}</h6>
                            <small class="text-muted">Current Module</small>
                        </div>
                        <div class="list-group-item p-3 bg-light">
                            <div class="d-flex align-items-center">
                                <span class="badge bg-primary rounded-pill me-2">•</span>
                                <div>
                                    <h6 class="mb-0">${lesson.title}</h6>
                                    <small class="text-muted">Current Lesson</small>
                                </div>
                            </div>
                        </div>
                    </div>
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
                        <c:if test="${not empty lesson.resourceLink}">
                            <li class="list-group-item d-flex justify-content-between px-0">
                                <span>External Resource</span>
                                <a href="${lesson.resourceLink}" target="_blank">View</a>
                            </li>
                        </c:if>
                    </ul>

                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/instructor/view-lesson?id=${lesson.lessonId}" class="btn btn-primary w-100">
                            <i class="fas fa-edit me-2"></i> Edit This Lesson
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
