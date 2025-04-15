<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Course | SkillForge</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .course-form-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        .form-section {
            margin-bottom: 30px;
            padding: 20px;
            border-radius: 8px;
            background-color: #f8f9fa;
            border-left: 4px solid #4e73df;
        }

        .form-section h3 {
            color: #4e73df;
            margin-bottom: 20px;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .thumbnail-preview {
            width: 100%;
            height: 200px;
            border: 2px dashed #ddd;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            overflow: hidden;
            position: relative;
        }

        .thumbnail-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
        }

        .thumbnail-preview .upload-placeholder {
            text-align: center;
            color: #6c757d;
        }

        .thumbnail-preview .upload-placeholder i {
            font-size: 3rem;
            margin-bottom: 10px;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
        }

        .required-field::after {
            content: "*";
            color: #dc3545;
            margin-left: 4px;
        }

        .btn-create-course {
            background-color: #4e73df;
            color: white;
            padding: 10px 25px;
            font-weight: 600;
            border: none;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .btn-create-course:hover {
            background-color: #2e59d9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .btn-cancel {
            background-color: #f8f9fa;
            color: #6c757d;
            border: 1px solid #ddd;
            padding: 10px 25px;
            font-weight: 600;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .btn-cancel:hover {
            background-color: #e9ecef;
        }

        .form-floating {
            margin-bottom: 20px;
        }

        .form-check {
            margin-bottom: 10px;
        }

        .rich-text-editor {
            min-height: 200px;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            padding: 10px;
        }

        .course-progress-bar {
            height: 8px;
            margin-bottom: 30px;
            background-color: #e9ecef;
        }

        .course-progress-bar .progress-bar {
            background-color: #4e73df;
        }

        .form-tips {
            background-color: #e8f4fd;
            border-left: 4px solid #17a2b8;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .form-tips h5 {
            color: #17a2b8;
            margin-bottom: 10px;
        }

        .form-tips ul {
            padding-left: 20px;
            margin-bottom: 0;
        }

        .form-tips li {
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/common/header.jsp" />

    <div class="container mt-5 mb-5">
        <div class="course-form-container">
            <h2 class="text-center mb-4">Create New Course</h2>
            <p class="text-center text-muted mb-4">Fill in the details below to create your new course. Fields marked with * are required.</p>

            <!-- Progress Bar -->
            <div class="progress course-progress-bar">
                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
            </div>

            <form action="${pageContext.request.contextPath}/instructor/courses/create" method="post" enctype="multipart/form-data">
                <!-- Basic Information Section -->
                <div class="form-section">
                    <h3><i class="fas fa-info-circle me-2"></i>Basic Information</h3>

                    <div class="form-tips mb-4">
                        <h5><i class="fas fa-lightbulb me-2"></i>Tips for a Great Course</h5>
                        <ul>
                            <li>Choose a clear, specific title that reflects what students will learn</li>
                            <li>Write a comprehensive description that outlines the course content and benefits</li>
                            <li>Select the most appropriate category for your course to help students find it</li>
                        </ul>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="courseTitle" name="title" placeholder="Course Title" required>
                        <label for="courseTitle" class="required-field">Course Title</label>
                        <div class="form-text">Keep it clear, specific, and under 60 characters</div>
                    </div>

                    <div class="mb-3">
                        <label for="courseDescription" class="form-label required-field">Course Description</label>
                        <div class="rich-text-editor" id="courseDescription">
                            <!-- Rich text editor will be initialized here -->
                        </div>
                        <textarea name="description" id="descriptionHidden" style="display: none;"></textarea>
                        <div class="form-text">Describe what students will learn and why they should take your course (min. 200 characters)</div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="courseCategory" class="form-label required-field">Category</label>
                                <select class="form-select" id="courseCategory" name="categoryId" required>
                                    <option value="" selected disabled>Select a category</option>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.categoryId}">${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="courseLevel" class="form-label required-field">Level</label>
                                <select class="form-select" id="courseLevel" name="level" required>
                                    <option value="" selected disabled>Select a level</option>
                                    <option value="Beginner">Beginner</option>
                                    <option value="Intermediate">Intermediate</option>
                                    <option value="Advanced">Advanced</option>
                                    <option value="All Levels">All Levels</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Course Media Section -->
                <div class="form-section">
                    <h3><i class="fas fa-image me-2"></i>Course Media</h3>

                    <div class="form-tips mb-4">
                        <h5><i class="fas fa-lightbulb me-2"></i>Tips for Course Thumbnail</h5>
                        <ul>
                            <li>Use high-quality images that represent your course content</li>
                            <li>Optimal dimensions: 1280 x 720 pixels (16:9 ratio)</li>
                            <li>Keep text on the image minimal and readable</li>
                        </ul>
                    </div>

                    <div class="mb-3">
                        <label for="courseThumbnail" class="form-label required-field">Course Thumbnail</label>
                        <div class="thumbnail-preview" id="thumbnailPreview">
                            <div class="upload-placeholder">
                                <i class="fas fa-cloud-upload-alt"></i>
                                <p>Drag and drop your thumbnail here or click to browse</p>
                            </div>
                        </div>
                        <input type="file" class="form-control" id="courseThumbnail" name="thumbnailFile" accept="image/*" required>
                        <div class="form-text">Upload a high-quality image that represents your course (16:9 ratio recommended)</div>
                    </div>

                    <div class="mb-3">
                        <label for="coursePromo" class="form-label">Promotional Video URL (Optional)</label>
                        <input type="url" class="form-control" id="coursePromo" name="promoVideo" placeholder="https://www.youtube.com/watch?v=...">
                        <div class="form-text">Add a YouTube or Vimeo URL to showcase your course content</div>
                    </div>
                </div>

                <!-- Course Details Section -->
                <div class="form-section">
                    <h3><i class="fas fa-list-alt me-2"></i>Course Details</h3>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="courseDuration" class="form-label">Estimated Duration (hours)</label>
                                <input type="number" class="form-control" id="courseDuration" name="duration" min="1" placeholder="e.g., 10">
                                <div class="form-text">Approximate time to complete the course</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="coursePrice" class="form-label">Price (Optional)</label>
                                <div class="input-group">
                                    <span class="input-group-text">$</span>
                                    <input type="number" class="form-control" id="coursePrice" name="price" min="0" step="0.01" placeholder="e.g., 49.99">
                                </div>
                                <div class="form-text">Leave empty for a free course</div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="coursePrerequisites" class="form-label">Prerequisites (Optional)</label>
                        <textarea class="form-control" id="coursePrerequisites" name="prerequisites" rows="3" placeholder="List any skills or knowledge students should have before taking this course"></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="courseTags" class="form-label">Tags (Optional)</label>
                        <input type="text" class="form-control" id="courseTags" name="tags" placeholder="e.g., programming, java, web development">
                        <div class="form-text">Separate tags with commas to help students find your course</div>
                    </div>
                </div>

                <!-- Course Settings Section -->
                <div class="form-section">
                    <h3><i class="fas fa-cog me-2"></i>Course Settings</h3>

                    <div class="mb-3">
                        <label class="form-label">Visibility</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="statusDraft" value="draft" checked>
                            <label class="form-check-label" for="statusDraft">
                                <i class="fas fa-save me-1"></i> Save as Draft
                                <div class="form-text">Your course won't be visible to students until you publish it</div>
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="statusPublish" value="active">
                            <label class="form-check-label" for="statusPublish">
                                <i class="fas fa-globe me-1"></i> Publish Immediately
                                <div class="form-text">Your course will be visible to students as soon as it's approved</div>
                            </label>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Enrollment Options</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="allowEnrollment" name="allowEnrollment" checked>
                            <label class="form-check-label" for="allowEnrollment">
                                Allow students to enroll in this course
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="requireApproval" name="requireApproval">
                            <label class="form-check-label" for="requireApproval">
                                Require approval for enrollment
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="d-flex justify-content-between mt-4">
                    <button type="button" class="btn btn-cancel" onclick="history.back()">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                    <div>
                        <button type="submit" name="saveAction" value="draft" class="btn btn-secondary me-2">
                            <i class="fas fa-save me-2"></i>Save Draft
                        </button>
                        <button type="submit" name="saveAction" value="publish" class="btn btn-create-course">
                            <i class="fas fa-check me-2"></i>Create Course
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="/common/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- CKEditor for rich text editing -->
    <script src="https://cdn.ckeditor.com/ckeditor5/36.0.1/classic/ckeditor.js"></script>

    <script>
        // Initialize CKEditor for course description
        ClassicEditor
            .create(document.querySelector('#courseDescription'))
            .then(editor => {
                // Update hidden textarea with editor content for form submission
                editor.model.document.on('change:data', () => {
                    document.querySelector('#descriptionHidden').value = editor.getData();
                });
            })
            .catch(error => {
                console.error(error);
            });

        // Thumbnail preview functionality
        document.getElementById('courseThumbnail').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    const previewDiv = document.getElementById('thumbnailPreview');
                    previewDiv.innerHTML = `<img src="${event.target.result}" alt="Course Thumbnail Preview">`;
                };
                reader.readAsDataURL(file);
            }
        });

        // Drag and drop functionality for thumbnail
        const thumbnailPreview = document.getElementById('thumbnailPreview');
        const thumbnailInput = document.getElementById('courseThumbnail');

        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            thumbnailPreview.addEventListener(eventName, preventDefaults, false);
        });

        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }

        ['dragenter', 'dragover'].forEach(eventName => {
            thumbnailPreview.addEventListener(eventName, highlight, false);
        });

        ['dragleave', 'drop'].forEach(eventName => {
            thumbnailPreview.addEventListener(eventName, unhighlight, false);
        });

        function highlight() {
            thumbnailPreview.classList.add('border-primary');
        }

        function unhighlight() {
            thumbnailPreview.classList.remove('border-primary');
        }

        thumbnailPreview.addEventListener('drop', handleDrop, false);

        function handleDrop(e) {
            const dt = e.dataTransfer;
            const files = dt.files;

            if (files.length) {
                thumbnailInput.files = files;
                const event = new Event('change');
                thumbnailInput.dispatchEvent(event);
            }
        }

        // Click on preview to trigger file input
        thumbnailPreview.addEventListener('click', () => {
            thumbnailInput.click();
        });
    </script>
</body>
</html>
