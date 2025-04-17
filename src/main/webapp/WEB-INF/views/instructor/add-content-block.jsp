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
                    <li class="breadcrumb-item active" aria-current="page">Add Content Block</li>
                </ol>
            </nav>
            <h2 class="mb-3">Add Content Block</h2>
            <p class="text-muted">Add a new content block to the lesson "${lesson.title}"</p>
        </div>
        <div class="col-md-4 text-end">
            <a href="${pageContext.request.contextPath}/instructor/view-lesson?id=${lesson.lessonId}" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to Lesson
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
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Select Content Block Type</h5>
                </div>
                <div class="card-body p-4">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <div class="card h-100 ${param.blockType == 'TEXT' || empty param.blockType ? 'border-primary' : ''}" id="textBlockCard">
                                <div class="card-body text-center p-4">
                                    <i class="fas fa-align-left fa-3x mb-3 ${param.blockType == 'TEXT' || empty param.blockType ? 'text-primary' : 'text-muted'}"></i>
                                    <h5 class="card-title">Text</h5>
                                    <p class="card-text small">Add formatted text content</p>
                                    <div class="form-check justify-content-center">
                                        <input class="form-check-input" type="radio" name="blockTypeRadio" id="textBlockRadio" value="TEXT" ${param.blockType == 'TEXT' || empty param.blockType ? 'checked' : ''}>
                                        <label class="form-check-label" for="textBlockRadio">Select</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100 ${param.blockType == 'VIDEO' ? 'border-primary' : ''}" id="videoBlockCard">
                                <div class="card-body text-center p-4">
                                    <i class="fas fa-video fa-3x mb-3 ${param.blockType == 'VIDEO' ? 'text-primary' : 'text-muted'}"></i>
                                    <h5 class="card-title">Video</h5>
                                    <p class="card-text small">Embed a video from YouTube, Vimeo, etc.</p>
                                    <div class="form-check justify-content-center">
                                        <input class="form-check-input" type="radio" name="blockTypeRadio" id="videoBlockRadio" value="VIDEO" ${param.blockType == 'VIDEO' ? 'checked' : ''}>
                                        <label class="form-check-label" for="videoBlockRadio">Select</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100 ${param.blockType == 'IMAGE' ? 'border-primary' : ''}" id="imageBlockCard">
                                <div class="card-body text-center p-4">
                                    <i class="fas fa-image fa-3x mb-3 ${param.blockType == 'IMAGE' ? 'text-primary' : 'text-muted'}"></i>
                                    <h5 class="card-title">Image</h5>
                                    <p class="card-text small">Add an image with caption</p>
                                    <div class="form-check justify-content-center">
                                        <input class="form-check-input" type="radio" name="blockTypeRadio" id="imageBlockRadio" value="IMAGE" ${param.blockType == 'IMAGE' ? 'checked' : ''}>
                                        <label class="form-check-label" for="imageBlockRadio">Select</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100 ${param.blockType == 'CODE' ? 'border-primary' : ''}" id="codeBlockCard">
                                <div class="card-body text-center p-4">
                                    <i class="fas fa-code fa-3x mb-3 ${param.blockType == 'CODE' ? 'text-primary' : 'text-muted'}"></i>
                                    <h5 class="card-title">Code</h5>
                                    <p class="card-text small">Add a code snippet with syntax highlighting</p>
                                    <div class="form-check justify-content-center">
                                        <input class="form-check-input" type="radio" name="blockTypeRadio" id="codeBlockRadio" value="CODE" ${param.blockType == 'CODE' ? 'checked' : ''}>
                                        <label class="form-check-label" for="codeBlockRadio">Select</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100 ${param.blockType == 'DOCUMENT' ? 'border-primary' : ''}" id="documentBlockCard">
                                <div class="card-body text-center p-4">
                                    <i class="fas fa-file-alt fa-3x mb-3 ${param.blockType == 'DOCUMENT' ? 'text-primary' : 'text-muted'}"></i>
                                    <h5 class="card-title">Document</h5>
                                    <p class="card-text small">Link to a downloadable document</p>
                                    <div class="form-check justify-content-center">
                                        <input class="form-check-input" type="radio" name="blockTypeRadio" id="documentBlockRadio" value="DOCUMENT" ${param.blockType == 'DOCUMENT' ? 'checked' : ''}>
                                        <label class="form-check-label" for="documentBlockRadio">Select</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100 ${param.blockType == 'EMBED' ? 'border-primary' : ''}" id="embedBlockCard">
                                <div class="card-body text-center p-4">
                                    <i class="fas fa-code fa-3x mb-3 ${param.blockType == 'EMBED' ? 'text-primary' : 'text-muted'}"></i>
                                    <h5 class="card-title">Embed</h5>
                                    <p class="card-text small">Embed external content (iframe)</p>
                                    <div class="form-check justify-content-center">
                                        <input class="form-check-input" type="radio" name="blockTypeRadio" id="embedBlockRadio" value="EMBED" ${param.blockType == 'EMBED' ? 'checked' : ''}>
                                        <label class="form-check-label" for="embedBlockRadio">Select</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Content Block Details</h5>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/instructor/add-content-block" method="post" id="addContentBlockForm" autocomplete="off" enctype="multipart/form-data">
                        <input type="hidden" name="lessonId" value="${lesson.lessonId}">
                        <input type="hidden" name="blockType" id="blockTypeInput" value="${param.blockType != null ? param.blockType : 'TEXT'}">

                        <div class="mb-4">
                            <label for="blockTitle" class="form-label">Title (Optional)</label>
                            <input type="text" class="form-control" id="blockTitle" name="title"
                                   placeholder="e.g., Introduction" maxlength="255" value="${param.title}">
                            <div class="form-text">A title for this content block (optional).</div>
                        </div>

                        <!-- Text Block Form -->
                        <div id="textBlockForm" class="content-block-form ${param.blockType == 'TEXT' || empty param.blockType ? '' : 'd-none'}">
                            <div class="mb-4">
                                <label for="textContent" class="form-label">Text Content <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="textContent" name="textContent" rows="8"
                                          placeholder="Enter your text content here...">${param.textContent}</textarea>
                                <div class="form-text">You can use Markdown formatting for rich text.</div>
                            </div>
                        </div>

                        <!-- Video Block Form -->
                        <div id="videoBlockForm" class="content-block-form ${param.blockType == 'VIDEO' ? '' : 'd-none'}">
                            <div class="mb-4">
                                <label class="form-label">Video Source</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="videoSourceType" id="videoSourceUrl" value="url" checked>
                                    <label class="form-check-label" for="videoSourceUrl">URL (YouTube, Vimeo, etc.)</label>
                                </div>
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="radio" name="videoSourceType" id="videoSourceUpload" value="upload">
                                    <label class="form-check-label" for="videoSourceUpload">Upload Video File</label>
                                </div>
                            </div>

                            <div id="videoUrlContainer" class="mb-4">
                                <label for="videoUrl" class="form-label">Video URL</label>
                                <input type="url" class="form-control" id="videoUrl" name="videoUrl"
                                       placeholder="e.g., https://www.youtube.com/watch?v=..." value="${param.videoUrl}">
                                <div class="form-text">Enter a YouTube, Vimeo, or other video URL.</div>
                            </div>

                            <div id="videoFileContainer" class="mb-4 d-none">
                                <label for="videoFile" class="form-label">Video File</label>
                                <input type="file" class="form-control" id="videoFile" name="videoFile" accept="video/*">
                                <div class="form-text">Upload a video file (MP4, WebM, etc.). Maximum size: 50MB.</div>

                                <div id="videoPreviewContainer" class="mt-3 d-none">
                                    <label class="form-label">Preview:</label>
                                    <div class="ratio ratio-16x9">
                                        <video id="videoPreview" controls></video>
                                    </div>
                                    <div class="d-flex align-items-center mt-2">
                                        <i class="fas fa-info-circle text-primary me-2"></i>
                                        <small class="text-muted">Video preview is shown here. Students will see this video in the lesson.</small>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="videoDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="videoDescription" name="videoDescription" rows="3"
                                          placeholder="Enter a description for this video...">${param.videoDescription}</textarea>
                            </div>
                        </div>

                        <!-- Image Block Form -->
                        <div id="imageBlockForm" class="content-block-form ${param.blockType == 'IMAGE' ? '' : 'd-none'}">
                            <div class="mb-4">
                                <label class="form-label">Image Source</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="imageSourceType" id="imageSourceUrl" value="url" checked>
                                    <label class="form-check-label" for="imageSourceUrl">URL</label>
                                </div>
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="radio" name="imageSourceType" id="imageSourceUpload" value="upload">
                                    <label class="form-check-label" for="imageSourceUpload">Upload Image File</label>
                                </div>
                            </div>

                            <div id="imageUrlContainer" class="mb-4">
                                <label for="imageUrl" class="form-label">Image URL</label>
                                <input type="url" class="form-control" id="imageUrl" name="imageUrl"
                                       placeholder="e.g., https://example.com/image.jpg" value="${param.imageUrl}">
                                <div class="form-text">Enter the URL of the image.</div>

                                <div id="imageUrlPreviewContainer" class="mt-3 d-none">
                                    <label class="form-label">Preview:</label>
                                    <img id="imageUrlPreview" src="" alt="Image Preview" class="img-fluid img-thumbnail" style="max-height: 200px;">
                                </div>
                            </div>

                            <div id="imageFileContainer" class="mb-4 d-none">
                                <label for="imageFile" class="form-label">Image File</label>
                                <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*">
                                <div class="form-text">Upload an image file (JPG, PNG, GIF, etc.). Maximum size: 10MB.</div>

                                <div id="imageFilePreviewContainer" class="mt-3 d-none">
                                    <label class="form-label">Preview:</label>
                                    <img id="imageFilePreview" src="" alt="Image Preview" class="img-fluid img-thumbnail" style="max-height: 300px;">
                                    <div class="d-flex align-items-center mt-2">
                                        <i class="fas fa-info-circle text-primary me-2"></i>
                                        <small class="text-muted">Image preview is shown here. Students will see this image in the lesson.</small>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="imageCaption" class="form-label">Caption</label>
                                <input type="text" class="form-control" id="imageCaption" name="imageCaption"
                                       placeholder="Enter a caption for this image" value="${param.imageCaption}">
                            </div>
                        </div>

                        <!-- Code Block Form -->
                        <div id="codeBlockForm" class="content-block-form ${param.blockType == 'CODE' ? '' : 'd-none'}">
                            <div class="mb-4">
                                <label for="codeContent" class="form-label">Code <span class="text-danger">*</span></label>
                                <textarea class="form-control font-monospace" id="codeContent" name="codeContent" rows="8"
                                          placeholder="Enter your code here...">${param.codeContent}</textarea>
                            </div>
                            <div class="mb-4">
                                <label for="codeLanguage" class="form-label">Language</label>
                                <input type="text" class="form-control" id="codeLanguage" name="codeLanguage"
                                       placeholder="e.g., javascript, python, java" value="${param.codeLanguage}">
                                <div class="form-text">Specify the programming language for syntax highlighting.</div>
                            </div>
                        </div>

                        <!-- Document Block Form -->
                        <div id="documentBlockForm" class="content-block-form ${param.blockType == 'DOCUMENT' ? '' : 'd-none'}">
                            <div class="mb-4">
                                <label class="form-label">Document Source</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="documentSourceType" id="documentSourceUrl" value="url" checked>
                                    <label class="form-check-label" for="documentSourceUrl">URL</label>
                                </div>
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="radio" name="documentSourceType" id="documentSourceUpload" value="upload">
                                    <label class="form-check-label" for="documentSourceUpload">Upload Document File</label>
                                </div>
                            </div>

                            <div id="documentUrlContainer" class="mb-4">
                                <label for="documentUrl" class="form-label">Document URL</label>
                                <input type="url" class="form-control" id="documentUrl" name="documentUrl"
                                       placeholder="e.g., https://example.com/document.pdf" value="${param.documentUrl}">
                                <div class="form-text">Enter the URL of the document.</div>
                            </div>

                            <div id="documentFileContainer" class="mb-4 d-none">
                                <label for="documentFile" class="form-label">Document File</label>
                                <input type="file" class="form-control" id="documentFile" name="documentFile" accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.txt,.jpg,.jpeg,.png,.gif">
                                <div class="form-text">Upload a document file (PDF, DOC, DOCX, images, etc.). Maximum size: 50MB.</div>

                                <div id="documentPreviewContainer" class="mt-3 d-none">
                                    <label class="form-label">Preview:</label>
                                    <div id="documentIconPreview" class="p-3 bg-light rounded">
                                        <i class="fas fa-file-alt me-2"></i>
                                        <span id="documentFileName"></span>
                                        <span class="text-muted ms-2" id="documentFileSize"></span>
                                    </div>
                                    <div id="documentImagePreview" class="d-none mt-2">
                                        <img id="documentImagePreviewImg" src="" alt="Document Preview" class="img-fluid img-thumbnail" style="max-height: 200px;">
                                    </div>
                                    <div id="documentPdfPreview" class="d-none mt-2">
                                        <div class="alert alert-info">
                                            <i class="fas fa-info-circle me-2"></i>
                                            PDF preview will be available after upload.
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center mt-2">
                                        <i class="fas fa-info-circle text-primary me-2"></i>
                                        <small class="text-muted">Document preview is shown here. Students will be able to view and download this document in the lesson.</small>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="documentDescription" class="form-label">Description</label>
                                <textarea class="form-control" id="documentDescription" name="documentDescription" rows="3"
                                          placeholder="Enter a description for this document...">${param.documentDescription}</textarea>
                            </div>
                        </div>

                        <!-- Embed Block Form -->
                        <div id="embedBlockForm" class="content-block-form ${param.blockType == 'EMBED' ? '' : 'd-none'}">
                            <div class="mb-4">
                                <label for="embedCode" class="form-label">Embed Code <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="embedCode" name="embedCode" rows="8"
                                          placeholder="Enter the embed code here...">${param.embedCode}</textarea>
                                <div class="form-text">Enter the iframe or embed code.</div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="blockOrderIndex" class="form-label">Order</label>
                            <input type="number" class="form-control" id="blockOrderIndex" name="orderIndex"
                                   value="${not empty param.orderIndex ? param.orderIndex : nextOrderIndex}" min="1">
                            <div class="form-text">The order in which this block appears in the lesson. Leave as is to add to the end.</div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label d-block">After adding this content block:</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="afterAction" id="afterActionAddAnother" value="addAnother" checked>
                                <label class="form-check-label" for="afterActionAddAnother">Add another content block</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="afterAction" id="afterActionViewLesson" value="viewLesson">
                                <label class="form-check-label" for="afterActionViewLesson">View lesson</label>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/instructor/view-lesson?id=${lesson.lessonId}" class="btn btn-outline-secondary">
                                <i class="fas fa-times me-2"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Save Content Block
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">About Content Blocks</h5>
                </div>
                <div class="card-body p-4">
                    <p>Content blocks are the building blocks of your lessons. They allow you to create rich, interactive content for your students.</p>

                    <div class="alert alert-info">
                        <h6 class="alert-heading"><i class="fas fa-lightbulb me-2"></i>Tips for Creating Content</h6>
                        <ul class="mb-0 ps-3">
                            <li>Use a variety of content types to keep students engaged</li>
                            <li>Break complex topics into smaller, digestible blocks</li>
                            <li>Use images and videos to illustrate concepts</li>
                            <li>Provide code examples for technical topics</li>
                            <li>Include downloadable resources for further study</li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Current Content Blocks</h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${empty contentBlocks}">
                            <div class="p-4 text-center">
                                <p class="text-muted mb-0">No content blocks yet. This will be your first content block in this lesson!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${contentBlocks}" var="block" varStatus="status">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <span class="badge bg-secondary rounded-pill me-2">${block.orderIndex}</span>
                                            <i class="fas fa-${block.blockType == 'TEXT' ? 'align-left' : block.blockType == 'VIDEO' ? 'video' : block.blockType == 'IMAGE' ? 'image' : block.blockType == 'CODE' ? 'code' : block.blockType == 'DOCUMENT' ? 'file-alt' : 'code'} me-2"></i>
                                            ${not empty block.title ? block.title : block.blockType}
                                        </div>
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
    // Handle block type selection
    document.querySelectorAll('input[name="blockTypeRadio"]').forEach(radio => {
        radio.addEventListener('change', function() {
            // Update hidden input
            document.getElementById('blockTypeInput').value = this.value;

            // Update card styling
            document.querySelectorAll('.card').forEach(card => {
                card.classList.remove('border-primary');
            });
            document.getElementById(this.value.toLowerCase() + 'BlockCard').classList.add('border-primary');

            // Update icon colors
            document.querySelectorAll('.fa-3x').forEach(icon => {
                icon.classList.remove('text-primary');
                icon.classList.add('text-muted');
            });
            document.querySelector('#' + this.value.toLowerCase() + 'BlockCard .fa-3x').classList.remove('text-muted');
            document.querySelector('#' + this.value.toLowerCase() + 'BlockCard .fa-3x').classList.add('text-primary');

            // Show/hide appropriate form
            document.querySelectorAll('.content-block-form').forEach(form => {
                form.classList.add('d-none');
            });
            document.getElementById(this.value.toLowerCase() + 'BlockForm').classList.remove('d-none');
        });
    });

    // Handle video source type selection
    document.querySelectorAll('input[name="videoSourceType"]').forEach(radio => {
        radio.addEventListener('change', function() {
            if (this.value === 'url') {
                document.getElementById('videoUrlContainer').classList.remove('d-none');
                document.getElementById('videoFileContainer').classList.add('d-none');
            } else {
                document.getElementById('videoUrlContainer').classList.add('d-none');
                document.getElementById('videoFileContainer').classList.remove('d-none');
            }
        });
    });

    // Handle image source type selection
    document.querySelectorAll('input[name="imageSourceType"]').forEach(radio => {
        radio.addEventListener('change', function() {
            if (this.value === 'url') {
                document.getElementById('imageUrlContainer').classList.remove('d-none');
                document.getElementById('imageFileContainer').classList.add('d-none');
            } else {
                document.getElementById('imageUrlContainer').classList.add('d-none');
                document.getElementById('imageFileContainer').classList.remove('d-none');
            }
        });
    });

    // Handle document source type selection
    document.querySelectorAll('input[name="documentSourceType"]').forEach(radio => {
        radio.addEventListener('change', function() {
            if (this.value === 'url') {
                document.getElementById('documentUrlContainer').classList.remove('d-none');
                document.getElementById('documentFileContainer').classList.add('d-none');
            } else {
                document.getElementById('documentUrlContainer').classList.add('d-none');
                document.getElementById('documentFileContainer').classList.remove('d-none');
            }
        });
    });

    // Video file preview
    document.getElementById('videoFile').addEventListener('change', function(e) {
        const file = this.files[0];
        if (file) {
            const videoPreviewContainer = document.getElementById('videoPreviewContainer');
            const videoPreview = document.getElementById('videoPreview');

            // Create object URL for the file
            const objectUrl = URL.createObjectURL(file);
            videoPreview.src = objectUrl;

            // Show the preview container
            videoPreviewContainer.classList.remove('d-none');

            // Clean up the object URL when it's no longer needed
            videoPreview.onload = function() {
                URL.revokeObjectURL(objectUrl);
            };
        }
    });

    // Image URL preview
    document.getElementById('imageUrl').addEventListener('input', function() {
        const url = this.value.trim();
        const previewContainer = document.getElementById('imageUrlPreviewContainer');
        const preview = document.getElementById('imageUrlPreview');

        if (url) {
            preview.src = url;
            preview.onload = function() {
                previewContainer.classList.remove('d-none');
            };
            preview.onerror = function() {
                previewContainer.classList.add('d-none');
            };
        } else {
            previewContainer.classList.add('d-none');
        }
    });

    // Image file preview
    document.getElementById('imageFile').addEventListener('change', function(e) {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            const previewContainer = document.getElementById('imageFilePreviewContainer');
            const preview = document.getElementById('imageFilePreview');

            reader.onload = function(event) {
                preview.src = event.target.result;
                previewContainer.classList.remove('d-none');
            };

            reader.readAsDataURL(file);
        }
    });

    // Document file preview
    document.getElementById('documentFile').addEventListener('change', function(e) {
        const file = this.files[0];
        if (file) {
            const previewContainer = document.getElementById('documentPreviewContainer');
            const fileName = document.getElementById('documentFileName');
            const fileSize = document.getElementById('documentFileSize');
            const documentIconPreview = document.getElementById('documentIconPreview');
            const documentImagePreview = document.getElementById('documentImagePreview');
            const documentPdfPreview = document.getElementById('documentPdfPreview');
            const documentImagePreviewImg = document.getElementById('documentImagePreviewImg');

            fileName.textContent = file.name;

            // Format file size
            const size = file.size;
            if (size < 1024) {
                fileSize.textContent = size + ' bytes';
            } else if (size < 1024 * 1024) {
                fileSize.textContent = (size / 1024).toFixed(2) + ' KB';
            } else {
                fileSize.textContent = (size / (1024 * 1024)).toFixed(2) + ' MB';
            }

            // Show appropriate preview based on file type
            const fileType = file.type;
            const fileExtension = file.name.split('.').pop().toLowerCase();

            // Reset all preview containers
            documentIconPreview.classList.remove('d-none');
            documentImagePreview.classList.add('d-none');
            documentPdfPreview.classList.add('d-none');

            // Update icon based on file type
            const fileIcon = documentIconPreview.querySelector('i');
            if (fileType.startsWith('image/')) {
                fileIcon.className = 'fas fa-file-image me-2';
                // Show image preview
                const reader = new FileReader();
                reader.onload = function(event) {
                    documentImagePreviewImg.src = event.target.result;
                    documentImagePreview.classList.remove('d-none');
                };
                reader.readAsDataURL(file);
            } else if (fileType === 'application/pdf' || fileExtension === 'pdf') {
                fileIcon.className = 'fas fa-file-pdf me-2';
                documentPdfPreview.classList.remove('d-none');
            } else if (fileType.includes('word') || fileExtension === 'doc' || fileExtension === 'docx') {
                fileIcon.className = 'fas fa-file-word me-2';
            } else if (fileType.includes('excel') || fileExtension === 'xls' || fileExtension === 'xlsx') {
                fileIcon.className = 'fas fa-file-excel me-2';
            } else if (fileType.includes('powerpoint') || fileExtension === 'ppt' || fileExtension === 'pptx') {
                fileIcon.className = 'fas fa-file-powerpoint me-2';
            } else {
                fileIcon.className = 'fas fa-file-alt me-2';
            }

            previewContainer.classList.remove('d-none');
        }
    });

    // Client-side validation
    document.getElementById('addContentBlockForm').addEventListener('submit', function(event) {
        const blockType = document.getElementById('blockTypeInput').value;
        let isValid = true;
        let errorMessage = '';

        // Validate based on block type
        if (blockType === 'TEXT') {
            const textContent = document.getElementById('textContent').value.trim();
            if (!textContent) {
                isValid = false;
                errorMessage = 'Text content is required';
                document.getElementById('textContent').classList.add('is-invalid');
            }
        } else if (blockType === 'VIDEO') {
            const videoSourceType = document.querySelector('input[name="videoSourceType"]:checked').value;
            if (videoSourceType === 'url') {
                const videoUrl = document.getElementById('videoUrl').value.trim();
                if (!videoUrl) {
                    isValid = false;
                    errorMessage = 'Video URL is required';
                    document.getElementById('videoUrl').classList.add('is-invalid');
                }
            } else {
                const videoFile = document.getElementById('videoFile').files;
                if (!videoFile || videoFile.length === 0) {
                    isValid = false;
                    errorMessage = 'Video file is required';
                    document.getElementById('videoFile').classList.add('is-invalid');
                }
            }
        } else if (blockType === 'IMAGE') {
            const imageSourceType = document.querySelector('input[name="imageSourceType"]:checked').value;
            if (imageSourceType === 'url') {
                const imageUrl = document.getElementById('imageUrl').value.trim();
                if (!imageUrl) {
                    isValid = false;
                    errorMessage = 'Image URL is required';
                    document.getElementById('imageUrl').classList.add('is-invalid');
                }
            } else {
                const imageFile = document.getElementById('imageFile').files;
                if (!imageFile || imageFile.length === 0) {
                    isValid = false;
                    errorMessage = 'Image file is required';
                    document.getElementById('imageFile').classList.add('is-invalid');
                }
            }
        } else if (blockType === 'CODE') {
            const codeContent = document.getElementById('codeContent').value.trim();
            if (!codeContent) {
                isValid = false;
                errorMessage = 'Code content is required';
                document.getElementById('codeContent').classList.add('is-invalid');
            }
        } else if (blockType === 'DOCUMENT') {
            const documentSourceType = document.querySelector('input[name="documentSourceType"]:checked').value;
            if (documentSourceType === 'url') {
                const documentUrl = document.getElementById('documentUrl').value.trim();
                if (!documentUrl) {
                    isValid = false;
                    errorMessage = 'Document URL is required';
                    document.getElementById('documentUrl').classList.add('is-invalid');
                }
            } else {
                const documentFile = document.getElementById('documentFile').files;
                if (!documentFile || documentFile.length === 0) {
                    isValid = false;
                    errorMessage = 'Document file is required';
                    document.getElementById('documentFile').classList.add('is-invalid');
                }
            }
        } else if (blockType === 'EMBED') {
            const embedCode = document.getElementById('embedCode').value.trim();
            if (!embedCode) {
                isValid = false;
                errorMessage = 'Embed code is required';
                document.getElementById('embedCode').classList.add('is-invalid');
            }
        }

        if (!isValid) {
            event.preventDefault();

            // Add error message
            const form = document.getElementById('addContentBlockForm');
            if (!document.querySelector('.alert-danger')) {
                const alert = document.createElement('div');
                alert.className = 'alert alert-danger alert-dismissible fade show mb-4';
                alert.role = 'alert';
                alert.innerHTML = errorMessage +
                    '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>';
                form.prepend(alert);
            }
        }
    });

    // Remove invalid state when user types
    document.querySelectorAll('input, textarea').forEach(input => {
        input.addEventListener('input', function() {
            this.classList.remove('is-invalid');
        });
    });
</script>

<%@ include file="/common/footer.jsp" %>
