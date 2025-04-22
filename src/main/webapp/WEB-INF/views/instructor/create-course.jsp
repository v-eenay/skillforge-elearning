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

        .btn-create-course {
            background-color: #4f46e5;
            color: white;
            border-color: #4f46e5;
            padding: 0.625rem 1.25rem;
            font-weight: 500;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }

        .btn-create-course:hover {
            background-color: #4338ca;
            border-color: #4338ca;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            color: white;
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
            cursor: pointer;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }

        .thumbnail-preview:hover {
            border-color: #4f46e5;
            background-color: rgba(79, 70, 229, 0.05);
        }

        .thumbnail-preview .upload-placeholder {
            text-align: center;
            color: #6c757d;
            padding: 20px;
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .thumbnail-preview .upload-placeholder i {
            font-size: 3rem;
            margin-bottom: 10px;
            color: #4f46e5;
        }

        #thumbnailImage {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
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

        /* Button styles moved to the top */

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

            <form id="courseForm" action="${pageContext.request.contextPath}/instructor/courses/create" method="post" enctype="multipart/form-data">
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
                                <div class="input-group">
                                    <select class="form-select" id="courseCategory" name="categoryId" required>
                                        <option value="" selected disabled>Select a category</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.categoryId}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                    <button class="btn btn-outline-secondary" type="button" id="newCategoryBtn">
                                        <i class="fas fa-plus"></i> New
                                    </button>
                                </div>
                            </div>

                            <!-- New Category Modal -->
                            <div class="modal fade" id="newCategoryModal" tabindex="-1" aria-labelledby="newCategoryModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="newCategoryModalLabel">Create New Category</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form id="newCategoryForm">
                                                <div class="mb-3">
                                                    <label for="categoryName" class="form-label">Category Name</label>
                                                    <input type="text" class="form-control" id="categoryName" name="name" required>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="categoryDescription" class="form-label">Description</label>
                                                    <textarea class="form-control" id="categoryDescription" name="description" rows="3"></textarea>
                                                </div>
                                            </form>
                                            <div id="categoryFormMessage" class="alert" style="display: none;"></div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                            <button type="button" class="btn btn-primary" id="saveNewCategoryBtn">Create Category</button>
                                        </div>
                                    </div>
                                </div>
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
                            <div class="upload-placeholder" id="uploadPlaceholder">
                                <i class="fas fa-cloud-upload-alt"></i>
                                <p>Drag and drop your thumbnail here or click to browse</p>
                            </div>
                            <img id="thumbnailImage" src="" alt="Course Thumbnail Preview" style="display: none; width: 100%; height: 100%; object-fit: cover;">
                        </div>
                        <input type="file" class="form-control" id="courseThumbnail" name="thumbnailFile" accept="image/*" required style="display: none;">
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
                        <button type="button" id="saveDraftBtn" class="btn btn-secondary me-2">
                            <i class="fas fa-save me-2"></i>Save Draft
                        </button>
                        <button type="button" id="createCourseBtn" class="btn btn-create-course">
                            <i class="fas fa-check me-2"></i>Create Course
                        </button>
                    </div>
                </div>

                <!-- Hidden input for save action -->
                <input type="hidden" name="saveAction" id="saveActionInput" value="draft">
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
        let courseEditor;

        // Initialize CKEditor for course description
        ClassicEditor
            .create(document.querySelector('#courseDescription'))
            .then(editor => {
                courseEditor = editor;
                console.log('CKEditor initialized successfully');
                // Update hidden textarea with editor content for form submission
                editor.model.document.on('change:data', () => {
                    document.querySelector('#descriptionHidden').value = editor.getData();
                    console.log('CKEditor content updated in hidden field');
                });

                // Set initial value to ensure the hidden field has content
                document.querySelector('#descriptionHidden').value = editor.getData();
            })
            .catch(error => {
                console.error('Error initializing CKEditor:', error);
            });

        // New Category Modal Functionality
        document.addEventListener('DOMContentLoaded', function() {
            const newCategoryBtn = document.getElementById('newCategoryBtn');
            const newCategoryModal = new bootstrap.Modal(document.getElementById('newCategoryModal'));
            const saveNewCategoryBtn = document.getElementById('saveNewCategoryBtn');
            const categoryFormMessage = document.getElementById('categoryFormMessage');
            const newCategoryForm = document.getElementById('newCategoryForm');
            const courseCategorySelect = document.getElementById('courseCategory');

            // Show the modal when the New button is clicked
            newCategoryBtn.addEventListener('click', function() {
                newCategoryModal.show();
            });

            // Handle form submission
            saveNewCategoryBtn.addEventListener('click', function() {
                // Validate form
                const categoryName = document.getElementById('categoryName').value.trim();
                if (!categoryName) {
                    showMessage('Please enter a category name.', 'danger');
                    return;
                }

                // Collect form data
                const formData = new FormData(newCategoryForm);

                // Send AJAX request
                fetch('${pageContext.request.contextPath}/instructor/categories/create', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Show success message
                        showMessage(data.message, 'success');

                        // Add the new category to the dropdown
                        const newOption = new Option(data.category.name, data.category.id);
                        courseCategorySelect.add(newOption);

                        // Select the new category
                        courseCategorySelect.value = data.category.id;

                        // Clear the form
                        newCategoryForm.reset();

                        // Close the modal after a short delay
                        setTimeout(() => {
                            newCategoryModal.hide();
                            categoryFormMessage.style.display = 'none';
                        }, 1500);
                    } else {
                        showMessage(data.message, 'danger');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showMessage('An error occurred. Please try again.', 'danger');
                });
            });

            // Helper function to show messages
            function showMessage(message, type) {
                categoryFormMessage.textContent = message;
                categoryFormMessage.className = 'alert alert-' + type;
                categoryFormMessage.style.display = 'block';
            }
        });

        // Initialize all UI functionality when DOM is loaded
        document.addEventListener('DOMContentLoaded', function() {
            // Thumbnail preview functionality
            initThumbnailPreview();

            // Other initialization code...
        });

        // Function to initialize thumbnail preview
        function initThumbnailPreview() {
            // Get elements
            const thumbnailPreview = document.getElementById('thumbnailPreview');
            const thumbnailInput = document.getElementById('courseThumbnail');
            const thumbnailImage = document.getElementById('thumbnailImage');
            const uploadPlaceholder = document.getElementById('uploadPlaceholder');

            if (!thumbnailPreview || !thumbnailInput || !thumbnailImage || !uploadPlaceholder) {
                console.error('Thumbnail preview elements not found');
                return;
            }

            // Handle file selection
            thumbnailInput.addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    if (!file.type.startsWith('image/')) {
                        alert('Please select an image file');
                        return;
                    }

                    const reader = new FileReader();
                    reader.onload = function(event) {
                        thumbnailImage.src = event.target.result;
                        thumbnailImage.style.display = 'block';
                        uploadPlaceholder.style.display = 'none';
                    };
                    reader.readAsDataURL(file);
                }
            });

            // Drag and drop functionality
            ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
                thumbnailPreview.addEventListener(eventName, function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                }, false);
            });

            // Add highlight class on drag enter/over
            ['dragenter', 'dragover'].forEach(eventName => {
                thumbnailPreview.addEventListener(eventName, function() {
                    thumbnailPreview.classList.add('border-primary');
                }, false);
            });

            // Remove highlight class on drag leave/drop
            ['dragleave', 'drop'].forEach(eventName => {
                thumbnailPreview.addEventListener(eventName, function() {
                    thumbnailPreview.classList.remove('border-primary');
                }, false);
            });

            // Handle file drop
            thumbnailPreview.addEventListener('drop', function(e) {
                const dt = e.dataTransfer;
                const files = dt.files;

                if (files.length) {
                    if (files[0].type.startsWith('image/')) {
                        thumbnailInput.files = files;

                        // Manually trigger the change event
                        const event = new Event('change', { bubbles: true });
                        thumbnailInput.dispatchEvent(event);
                    } else {
                        alert('Please drop an image file');
                    }
                }
            }, false);

            // Click on preview to trigger file input
            thumbnailPreview.addEventListener('click', function() {
                thumbnailInput.click();
            });
        }

        // Form validation and submission
        document.addEventListener('DOMContentLoaded', function() {
            const courseForm = document.getElementById('courseForm');
            const saveDraftBtn = document.getElementById('saveDraftBtn');
            const createCourseBtn = document.getElementById('createCourseBtn');
            const saveActionInput = document.getElementById('saveActionInput');

            // Function to validate the form
            function validateForm() {
                console.log('Validating form...');

                // Make sure the description from CKEditor is in the hidden field
                if (courseEditor) {
                    const editorData = courseEditor.getData();
                    console.log('CKEditor data:', editorData);
                    document.querySelector('#descriptionHidden').value = editorData;
                } else {
                    console.error('CKEditor not initialized');
                    alert('Error: Rich text editor not initialized. Please refresh the page and try again.');
                    return false;
                }

                // Check if title is filled
                const title = document.getElementById('courseTitle').value.trim();
                console.log('Title:', title);
                if (!title) {
                    alert('Please enter a course title');
                    document.getElementById('courseTitle').focus();
                    return false;
                }

                // Check if description is filled
                const description = document.querySelector('#descriptionHidden').value.trim();
                console.log('Description length:', description.length);
                if (!description) {
                    alert('Please enter a course description');
                    courseEditor.focus();
                    return false;
                }

                // Check if category is selected
                const category = document.getElementById('courseCategory').value;
                console.log('Category:', category);
                if (!category) {
                    alert('Please select a category');
                    document.getElementById('courseCategory').focus();
                    return false;
                }

                // Check if level is selected
                const level = document.getElementById('courseLevel').value;
                console.log('Level:', level);
                if (!level) {
                    alert('Please select a level');
                    document.getElementById('courseLevel').focus();
                    return false;
                }

                // Check if thumbnail is uploaded
                const thumbnail = document.getElementById('courseThumbnail').files;
                console.log('Thumbnail files:', thumbnail.length);
                if (thumbnail.length === 0) {
                    alert('Please upload a course thumbnail');
                    document.getElementById('thumbnailPreview').click();
                    return false;
                }

                console.log('Form validation passed');
                return true;
            }

            // Save as Draft button click handler
            saveDraftBtn.addEventListener('click', function() {
                console.log('Save Draft button clicked');
                saveActionInput.value = 'draft';
                document.getElementById('statusDraft').checked = true;

                if (validateForm()) {
                    console.log('Form validation passed, submitting form as draft');
                    // Show loading indicator or disable button here if needed
                    saveDraftBtn.disabled = true;
                    saveDraftBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Saving...';

                    // Make sure the form is properly submitted
                    try {
                        // Log form data for debugging
                        console.log('Form action:', courseForm.action);
                        console.log('Form method:', courseForm.method);
                        console.log('Form enctype:', courseForm.enctype);

                        // Submit the form
                        courseForm.submit();
                        console.log('Form submitted successfully as draft');
                    } catch (error) {
                        console.error('Error submitting form:', error);
                        saveDraftBtn.disabled = false;
                        saveDraftBtn.innerHTML = '<i class="fas fa-save me-2"></i>Save Draft';
                        alert('Error submitting form: ' + error.message);
                    }
                } else {
                    console.log('Form validation failed');
                }
            });

            // Create Course button click handler
            createCourseBtn.addEventListener('click', function() {
                console.log('Create Course button clicked');
                saveActionInput.value = 'publish';
                document.getElementById('statusPublish').checked = true;

                if (validateForm()) {
                    console.log('Form validation passed, submitting form');
                    // Show loading indicator or disable button here if needed
                    createCourseBtn.disabled = true;
                    createCourseBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Creating...';

                    // Make sure the form is properly submitted
                    try {
                        // Log form data for debugging
                        console.log('Form action:', courseForm.action);
                        console.log('Form method:', courseForm.method);
                        console.log('Form enctype:', courseForm.enctype);

                        // Submit the form
                        courseForm.submit();
                        console.log('Form submitted successfully');
                    } catch (error) {
                        console.error('Error submitting form:', error);
                        createCourseBtn.disabled = false;
                        createCourseBtn.innerHTML = '<i class="fas fa-check me-2"></i>Create Course';
                        alert('Error submitting form: ' + error.message);
                    }
                } else {
                    console.log('Form validation failed');
                }
            });

            // Remove the form submission event handler to avoid conflicts
            // The buttons will handle the form submission directly
        });
    </script>
</body>
</html>
