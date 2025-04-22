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
                        <div class="thumbnail-preview" id="thumbnailPreview">
                            <c:choose>
                                <c:when test="${not empty course.thumbnail}">
                                    <img src="${pageContext.request.contextPath}${course.thumbnail}" alt="Course Thumbnail">
                                    <div class="overlay">
                                        <button type="button" class="btn btn-light" id="changeThumbnailBtn">
                                            <i class="fas fa-exchange-alt me-2"></i>Change Thumbnail
                                        </button>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center">
                                        <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-2"></i>
                                        <p class="mb-0">Drag & drop your thumbnail here or click to browse</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <input type="file" class="form-control" id="thumbnailFile" name="thumbnailFile" accept="image/*" style="display: ${empty course.thumbnail ? 'block' : 'none'};">
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
        // Initialize CKEditor for course description
        document.addEventListener('DOMContentLoaded', function() {
            ClassicEditor
                .create(document.querySelector('#courseDescription'), {
                    toolbar: ['heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|', 'outdent', 'indent', '|', 'blockQuote', 'insertTable', 'undo', 'redo']
                })
                .then(editor => {
                    console.log('CKEditor initialized successfully');
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

        // Thumbnail preview functionality
        document.getElementById('thumbnailFile').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(event) {
                    const thumbnailPreview = document.getElementById('thumbnailPreview');
                    thumbnailPreview.innerHTML = `
                        <img src="${event.target.result}" alt="Course Thumbnail">
                        <div class="overlay">
                            <button type="button" class="btn btn-light" id="changeThumbnailBtn">
                                <i class="fas fa-exchange-alt me-2"></i>Change Thumbnail
                            </button>
                        </div>
                    `;

                    // Add event listener to the new button
                    document.getElementById('changeThumbnailBtn').addEventListener('click', function() {
                        document.getElementById('thumbnailFile').click();
                    });
                };
                reader.readAsDataURL(file);
            }
        });

        // Add event listener to the change thumbnail button if it exists
        const changeThumbnailBtn = document.getElementById('changeThumbnailBtn');
        if (changeThumbnailBtn) {
            changeThumbnailBtn.addEventListener('click', function() {
                document.getElementById('thumbnailFile').style.display = 'block';
                document.getElementById('thumbnailFile').click();
            });
        }
    </script>
</body>
</html>
