<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Course | SkillForge</title>
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

        .thumbnail-preview .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .thumbnail-preview:hover .overlay {
            opacity: 1;
        }

        .form-tips {
            background-color: #fff8e1;
            border-left: 4px solid #ffc107;
            padding: 15px;
            border-radius: 8px;
        }

        .form-tips h5 {
            color: #ff9800;
            font-size: 1.1rem;
            margin-bottom: 10px;
        }

        .form-tips ul {
            padding-left: 20px;
            margin-bottom: 0;
        }

        .btn-create-course {
            background-color: #4e73df;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-weight: 600;
        }

        .btn-create-course:hover {
            background-color: #3a5fc8;
            color: white;
        }

        .btn-cancel {
            background-color: #f8f9fa;
            color: #6c757d;
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-weight: 600;
        }

        .btn-cancel:hover {
            background-color: #e9ecef;
        }

        .rich-text-editor {
            min-height: 200px;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            padding: 10px;
        }

        .ck-editor__editable {
            min-height: 200px;
        }
    </style>
</head>
<body>
    <%@ include file="/common/header.jsp" %>

    <div class="container-fluid py-5 bg-light">
        <div class="course-form-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-edit me-2"></i>Edit Course</h2>
                <a href="${pageContext.request.contextPath}/instructor/courses/" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Courses
                </a>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/instructor/courses/edit" method="post" enctype="multipart/form-data">
                <input type="hidden" name="courseId" value="${course.courseId}">

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

                    <div class="mb-3">
                        <label for="title" class="form-label">Course Title <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="title" name="title" value="${course.title}" required>
                    </div>

                    <div class="mb-3">
                        <label for="courseDescription" class="form-label">Course Description <span class="text-danger">*</span></label>
                        <textarea id="courseDescription" style="display: none;">${course.description}</textarea>
                        <input type="hidden" id="descriptionHidden" name="description" value="${course.description}">
                        <small class="text-muted">Use the rich text editor to format your description.</small>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="categoryId" class="form-label">Category <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <option value="">Select a category</option>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.categoryId}" ${course.categoryId == category.categoryId ? 'selected' : ''}>${category.name}</option>
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
                        <div class="col-md-6 mb-3">
                            <label for="level" class="form-label">Level <span class="text-danger">*</span></label>
                            <select class="form-select" id="level" name="level" required>
                                <option value="">Select a level</option>
                                <option value="beginner" ${course.level == 'beginner' ? 'selected' : ''}>Beginner</option>
                                <option value="intermediate" ${course.level == 'intermediate' ? 'selected' : ''}>Intermediate</option>
                                <option value="advanced" ${course.level == 'advanced' ? 'selected' : ''}>Advanced</option>
                                <option value="all-levels" ${course.level == 'all-levels' ? 'selected' : ''}>All Levels</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Media Section -->
                <div class="form-section">
                    <h3><i class="fas fa-image me-2"></i>Media</h3>

                    <div class="mb-3">
                        <label for="thumbnailFile" class="form-label">Course Thumbnail</label>
                        <!-- File input placed before the preview area for better form submission -->
                        <input type="file" id="thumbnailFile" name="thumbnailFile" accept="image/*" style="display: none;">
                        <div class="thumbnail-preview" id="thumbnailPreview">
                            <div class="upload-placeholder" id="uploadPlaceholder" style="${not empty course.thumbnail ? 'display: none;' : ''}">
                                <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-2"></i>
                                <p class="mb-0">Drag & drop your thumbnail here or click to browse</p>
                            </div>
                            <img id="thumbnailImage" src="${not empty course.thumbnail ? pageContext.request.contextPath.concat(course.thumbnail) : ''}" 
                                 alt="Course Thumbnail" 
                                 style="${not empty course.thumbnail ? 'display: block;' : 'display: none;'} width: 100%; height: 100%; object-fit: cover;"
                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/course-thumbnail.svg';">
                            <div class="overlay" style="${not empty course.thumbnail ? '' : 'display: none;'}">
                                <button type="button" class="btn btn-light" id="changeThumbnailBtn">
                                    <i class="fas fa-exchange-alt me-2"></i>Change Thumbnail
                                </button>
                            </div>
                        </div>
                        <small class="text-muted">Recommended size: 1280x720 pixels (16:9 ratio). Max file size: 5MB.</small>
                    </div>

                    <div class="mb-3">
                        <label for="promoVideo" class="form-label">Promotional Video URL (Optional)</label>
                        <input type="url" class="form-control" id="promoVideo" name="promoVideo" value="${course.promoVideo}" placeholder="e.g., https://www.youtube.com/watch?v=...">
                        <small class="text-muted">Add a YouTube or Vimeo URL to showcase your course.</small>
                    </div>
                </div>

                <!-- Additional Information Section -->
                <div class="form-section">
                    <h3><i class="fas fa-list-alt me-2"></i>Additional Information</h3>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="duration" class="form-label">Course Duration (Optional)</label>
                            <input type="text" class="form-control" id="duration" name="duration" value="${course.duration}" placeholder="e.g., 10 hours">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="price" class="form-label">Price (Optional)</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" id="price" name="price" value="${course.price}" min="0" step="0.01" placeholder="e.g., 49.99">
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="prerequisites" class="form-label">Prerequisites (Optional)</label>
                        <textarea class="form-control" id="prerequisites" name="prerequisites" rows="3" placeholder="What should students know before taking this course?">${course.prerequisites}</textarea>
                    </div>

                    <div class="mb-3">
                        <label for="tags" class="form-label">Tags (Optional)</label>
                        <input type="text" class="form-control" id="tags" name="tags" value="${course.tags}" placeholder="e.g., programming, web development, javascript">
                        <small class="text-muted">Separate tags with commas.</small>
                    </div>
                </div>

                <!-- Course Status Section -->
                <div class="form-section">
                    <h3><i class="fas fa-toggle-on me-2"></i>Course Status</h3>

                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="statusInactive" value="inactive" ${course.status == 'inactive' ? 'checked' : ''}>
                            <label class="form-check-label" for="statusInactive">
                                <i class="fas fa-save me-2"></i>Draft - Save your course but don't publish it yet
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="status" id="statusActive" value="active" ${course.status == 'active' ? 'checked' : ''}>
                            <label class="form-check-label" for="statusActive">
                                <i class="fas fa-globe me-2"></i>Published - Make your course available to students
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/instructor/courses/" class="btn btn-cancel">
                        <i class="fas fa-times me-2"></i>Cancel
                    </a>
                    <div>
                        <button type="submit" name="saveAction" value="draft" class="btn btn-secondary me-2">
                            <i class="fas fa-save me-2"></i>Save as Draft
                        </button>
                        <button type="submit" name="saveAction" value="publish" class="btn btn-primary">
                            <i class="fas fa-check me-2"></i>Save and Publish
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="/common/footer.jsp" %>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- CKEditor -->
    <script src="https://cdn.ckeditor.com/ckeditor5/36.0.1/classic/ckeditor.js"></script>
    <script>
        // Initialize event handlers
        document.addEventListener('DOMContentLoaded', function() {

            // New Category Modal Functionality
            const newCategoryBtn = document.getElementById('newCategoryBtn');
            const newCategoryModal = new bootstrap.Modal(document.getElementById('newCategoryModal'));
            const saveNewCategoryBtn = document.getElementById('saveNewCategoryBtn');
            const categoryFormMessage = document.getElementById('categoryFormMessage');
            const newCategoryForm = document.getElementById('newCategoryForm');
            const categorySelect = document.getElementById('categoryId');

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
                // Convert form data to URL-encoded string for better compatibility
                const params = new URLSearchParams();
                params.append('name', categoryName);
                params.append('description', document.getElementById('categoryDescription').value);

                console.log('Sending category creation request to: ${pageContext.request.contextPath}/instructor/categories/create');
                console.log('Category name:', categoryName);
                console.log('Category description:', document.getElementById('categoryDescription').value);

                // Send AJAX request
                fetch('${pageContext.request.contextPath}/instructor/categories/create', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: params
                })
                .then(response => {
                    console.log('Response status:', response.status);
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.text().then(text => {
                        console.log('Raw response text:', text);
                        try {
                            return JSON.parse(text);
                        } catch (e) {
                            console.error('Error parsing JSON:', e);
                            throw new Error('Invalid JSON response: ' + text);
                        }
                    });
                })
                .then(data => {
                    if (data.success) {
                        // Show success message
                        showMessage(data.message, 'success');

                        // Add the new category to the dropdown
                        const newOption = new Option(data.category.name, data.category.id);
                        categorySelect.add(newOption);

                        // Select the new category
                        categorySelect.value = data.category.id;

                        // Clear the form fields manually since reset() might not work
                        document.getElementById('categoryName').value = '';
                        document.getElementById('categoryDescription').value = '';

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
                    showMessage('An error occurred. Please try again: ' + error.message, 'danger');
                });
            });

            // Helper function to show messages
            function showMessage(message, type) {
                categoryFormMessage.textContent = message;
                categoryFormMessage.className = 'alert alert-' + type;
                categoryFormMessage.style.display = 'block';
            }
        });

        // Initialize thumbnail preview functionality
        document.addEventListener('DOMContentLoaded', function() {
            initThumbnailPreview();
        });

        function initThumbnailPreview() {
            const thumbnailInput = document.getElementById('thumbnailFile');
            const thumbnailPreview = document.getElementById('thumbnailPreview');
            const thumbnailImage = document.getElementById('thumbnailImage');
            const uploadPlaceholder = document.getElementById('uploadPlaceholder');
            const overlay = document.querySelector('.overlay');
            const changeThumbnailBtn = document.getElementById('changeThumbnailBtn');

            if (!thumbnailInput || !thumbnailPreview || !thumbnailImage || !uploadPlaceholder || !overlay) {
                console.error('Thumbnail elements not found');
                return;
            }

            // File input is already hidden with style="display: none;" in the HTML
            // No need to hide it with JavaScript

            // Handle file selection
            thumbnailInput.addEventListener('change', function(e) {
                console.log('File input change event triggered');
                const file = e.target.files[0];
                if (file) {
                    console.log('File selected:', file.name, file.type, file.size);
                    if (!file.type.startsWith('image/')) {
                        alert('Please select an image file');
                        return;
                    }

                    const reader = new FileReader();
                    reader.onload = function(event) {
                        console.log('File read complete');
                        // Update the image source
                        thumbnailImage.src = event.target.result;
                        // Show the image and overlay, hide the placeholder
                        thumbnailImage.style.display = 'block';
                        overlay.style.display = 'block';
                        uploadPlaceholder.style.display = 'none';
                    };
                    reader.onerror = function(error) {
                        console.error('Error reading file:', error);
                        alert('Error reading the image file. Please try another file.');
                    };
                    reader.readAsDataURL(file);
                }
            });

            // Add event listener to the change thumbnail button if it exists
            if (changeThumbnailBtn) {
                changeThumbnailBtn.addEventListener('click', function() {
                    console.log('Change thumbnail button clicked');
                    thumbnailInput.click();
                });
            }

            // Make the preview clickable to select a file when no image is present
            thumbnailPreview.addEventListener('click', function(e) {
                // Only trigger file input if clicking on the preview area, not on the change button
                if (!e.target.closest('#changeThumbnailBtn')) {
                    console.log('Thumbnail preview clicked');
                    thumbnailInput.click();
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
                console.log('File dropped');
                const dt = e.dataTransfer;
                const files = dt.files;

                if (files.length) {
                    console.log('Dropped file:', files[0].name, files[0].type, files[0].size);
                    if (files[0].type.startsWith('image/')) {
                        // Create a new FileList object
                        const dataTransfer = new DataTransfer();
                        dataTransfer.items.add(files[0]);
                        thumbnailInput.files = dataTransfer.files;

                        // Manually trigger the change event
                        const event = new Event('change', { bubbles: true });
                        thumbnailInput.dispatchEvent(event);
                    } else {
                        alert('Please drop an image file');
                    }
                }
            }, false);
        }

        // Global variable to store the CKEditor instance
        let courseEditor;

        // Initialize CKEditor and form submission handling
        document.addEventListener('DOMContentLoaded', function() {
            // Get form elements
            const courseForm = document.querySelector('form[action="${pageContext.request.contextPath}/instructor/courses/edit"]');
            const saveDraftBtn = document.querySelector('button[value="draft"]');
            const savePublishBtn = document.querySelector('button[value="publish"]');

            // Initialize CKEditor
            ClassicEditor
                .create(document.querySelector('#courseDescription'), {
                    toolbar: ['heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|', 'outdent', 'indent', '|', 'blockQuote', 'insertTable', 'undo', 'redo']
                })
                .then(editor => {
                    console.log('CKEditor initialized successfully');
                    courseEditor = editor;

                    // Update hidden textarea with editor content for form submission
                    editor.model.document.on('change:data', () => {
                        document.querySelector('#descriptionHidden').value = editor.getData();
                    });

                    // Set initial content if available
                    if (document.querySelector('#descriptionHidden').value) {
                        editor.setData(document.querySelector('#descriptionHidden').value);
                    }
                })
                .catch(error => {
                    console.error('Error initializing CKEditor:', error);
                    // Fallback to regular textarea if CKEditor fails to load
                    document.querySelector('#courseDescription').style.display = 'block';
                    document.querySelector('#courseDescription').style.height = '300px';
                });

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
                const title = document.getElementById('title').value.trim();
                console.log('Title:', title);
                if (!title) {
                    alert('Please enter a course title');
                    document.getElementById('title').focus();
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
                const category = document.getElementById('categoryId').value;
                console.log('Category:', category);
                if (!category) {
                    alert('Please select a category');
                    document.getElementById('categoryId').focus();
                    return false;
                }

                // Check if level is selected
                const level = document.getElementById('level').value;
                console.log('Level:', level);
                if (!level) {
                    alert('Please select a level');
                    document.getElementById('level').focus();
                    return false;
                }

                console.log('Form validation passed');
                return true;
            }

            // Add event listeners to the form buttons
            if (saveDraftBtn) {
                saveDraftBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log('Save Draft button clicked');
                    document.getElementById('statusInactive').checked = true;

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
                            saveDraftBtn.innerHTML = '<i class="fas fa-save me-2"></i>Save as Draft';
                            alert('Error submitting form: ' + error.message);
                        }
                    } else {
                        console.log('Form validation failed');
                    }
                });
            }

            if (savePublishBtn) {
                savePublishBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log('Save and Publish button clicked');
                    document.getElementById('statusActive').checked = true;

                    if (validateForm()) {
                        console.log('Form validation passed, submitting form');
                        // Show loading indicator or disable button here if needed
                        savePublishBtn.disabled = true;
                        savePublishBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Saving...';

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
                            savePublishBtn.disabled = false;
                            savePublishBtn.innerHTML = '<i class="fas fa-check me-2"></i>Save and Publish';
                            alert('Error submitting form: ' + error.message);
                        }
                    } else {
                        console.log('Form validation failed');
                    }
                });
            }
        });
    </script>
</body>
</html>
