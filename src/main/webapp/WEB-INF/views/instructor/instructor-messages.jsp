<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/header.jsp" %>

<div class="dashboard-container">
    <div class="container">
        <!-- Success Messages -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session" />
        </c:if>

        <!-- Error Messages -->
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${sessionScope.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="error" scope="session" />
        </c:if>
        
        <div class="row dashboard-header">
            <div class="col-md-8">
                <h2>Messages</h2>
                <p>Manage your communications with students and administrators.</p>
            </div>
            <div class="col-md-4">
                <div class="dashboard-actions">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#composeMessageModal">
                        <i class="fas fa-pen"></i> Compose New Message
                    </button>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Message Sidebar -->
            <div class="col-md-3 mb-4">
                <div class="content-card">
                    <div class="card-header">
                        <h5 class="mb-0">Folders</h5>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action active d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-inbox me-2"></i> Inbox</span>
                            <span class="badge bg-primary rounded-pill">5</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-paper-plane me-2"></i> Sent</span>
                            <span class="badge bg-secondary rounded-pill">12</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-star me-2"></i> Starred</span>
                            <span class="badge bg-secondary rounded-pill">3</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-trash-alt me-2"></i> Trash</span>
                        </a>
                    </div>
                </div>
                
                <div class="content-card mt-4">
                    <div class="card-header">
                        <h5 class="mb-0">Contacts</h5>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex align-items-center">
                                <img src="https://placebeard.it/40/40?image=1" class="rounded-circle me-2" alt="Admin">
                                <div>
                                    <h6 class="mb-0">Admin Support</h6>
                                    <small class="text-muted">Platform Support</small>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex align-items-center">
                                <img src="https://placebeard.it/40/40?image=2" class="rounded-circle me-2" alt="Student">
                                <div>
                                    <h6 class="mb-0">Rajesh Sharma</h6>
                                    <small class="text-muted">Student</small>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex align-items-center">
                                <img src="https://placebeard.it/40/40?image=3" class="rounded-circle me-2" alt="Student">
                                <div>
                                    <h6 class="mb-0">Sunita Rai</h6>
                                    <small class="text-muted">Student</small>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex align-items-center">
                                <img src="https://placebeard.it/40/40?image=4" class="rounded-circle me-2" alt="Student">
                                <div>
                                    <h6 class="mb-0">Amit Kumar</h6>
                                    <small class="text-muted">Student</small>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Message List -->
            <div class="col-md-9">
                <div class="content-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Inbox</h5>
                        <div class="input-group" style="max-width: 300px;">
                            <input type="text" class="form-control" placeholder="Search messages...">
                            <button class="btn btn-outline-secondary" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action unread" data-bs-toggle="modal" data-bs-target="#viewMessageModal">
                            <div class="d-flex w-100 justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <div class="me-3">
                                        <img src="https://placebeard.it/45/45?image=1" class="rounded-circle" alt="Admin">
                                    </div>
                                    <div>
                                        <h6 class="mb-1 fw-bold">Course Approval Notification</h6>
                                        <p class="mb-1 text-truncate" style="max-width: 500px;">Your course "Web Development Fundamentals" has been approved and is now live on the platform.</p>
                                        <small class="text-muted">From: Admin Support • 2 hours ago</small>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <span class="badge bg-primary">New</span>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action unread" data-bs-toggle="modal" data-bs-target="#viewMessageModal">
                            <div class="d-flex w-100 justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <div class="me-3">
                                        <img src="https://placebeard.it/45/45?image=2" class="rounded-circle" alt="Student">
                                    </div>
                                    <div>
                                        <h6 class="mb-1 fw-bold">Question about JavaScript Module</h6>
                                        <p class="mb-1 text-truncate" style="max-width: 500px;">Hello, I'm having trouble understanding the closure concept in the JavaScript module. Could you provide some additional examples?</p>
                                        <small class="text-muted">From: Rajesh Sharma • 5 hours ago</small>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <span class="badge bg-primary">New</span>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action unread" data-bs-toggle="modal" data-bs-target="#viewMessageModal">
                            <div class="d-flex w-100 justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <div class="me-3">
                                        <img src="https://placebeard.it/45/45?image=3" class="rounded-circle" alt="Student">
                                    </div>
                                    <div>
                                        <h6 class="mb-1 fw-bold">Assignment Submission</h6>
                                        <p class="mb-1 text-truncate" style="max-width: 500px;">I've submitted my final project for the Responsive Web Design course. Looking forward to your feedback!</p>
                                        <small class="text-muted">From: Sunita Rai • Yesterday</small>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <span class="badge bg-primary">New</span>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action" data-bs-toggle="modal" data-bs-target="#viewMessageModal">
                            <div class="d-flex w-100 justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <div class="me-3">
                                        <img src="https://placebeard.it/45/45?image=1" class="rounded-circle" alt="Admin">
                                    </div>
                                    <div>
                                        <h6 class="mb-1">Monthly Earnings Report</h6>
                                        <p class="mb-1 text-truncate" style="max-width: 500px;">Your earnings report for the month of April is now available. You've earned $1,245 from course sales.</p>
                                        <small class="text-muted">From: Admin Support • 2 days ago</small>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action" data-bs-toggle="modal" data-bs-target="#viewMessageModal">
                            <div class="d-flex w-100 justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <div class="me-3">
                                        <img src="https://placebeard.it/45/45?image=4" class="rounded-circle" alt="Student">
                                    </div>
                                    <div>
                                        <h6 class="mb-1">Course Feedback</h6>
                                        <p class="mb-1 text-truncate" style="max-width: 500px;">I just completed your Advanced JavaScript course and wanted to thank you. The content was excellent and has helped me secure a new job!</p>
                                        <small class="text-muted">From: Amit Kumar • 3 days ago</small>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="card-footer">
                        <nav aria-label="Messages pagination">
                            <ul class="pagination justify-content-center mb-0">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Compose Message Modal -->
<div class="modal fade" id="composeMessageModal" tabindex="-1" aria-labelledby="composeMessageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="composeMessageModalLabel">Compose New Message</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="recipient" class="form-label">To:</label>
                        <select class="form-select" id="recipient" required>
                            <option value="" selected disabled>Select recipient</option>
                            <option value="admin">Admin Support</option>
                            <option value="student1">Rajesh Sharma</option>
                            <option value="student2">Sunita Rai</option>
                            <option value="student3">Amit Kumar</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="subject" class="form-label">Subject:</label>
                        <input type="text" class="form-control" id="subject" required>
                    </div>
                    <div class="mb-3">
                        <label for="message" class="form-label">Message:</label>
                        <textarea class="form-control" id="message" rows="6" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="attachment" class="form-label">Attachment (optional):</label>
                        <input class="form-control" type="file" id="attachment">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary">Send Message</button>
            </div>
        </div>
    </div>
</div>

<!-- View Message Modal -->
<div class="modal fade" id="viewMessageModal" tabindex="-1" aria-labelledby="viewMessageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewMessageModalLabel">Course Approval Notification</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="d-flex align-items-center mb-3">
                    <img src="https://placebeard.it/50/50?image=1" class="rounded-circle me-3" alt="Admin">
                    <div>
                        <h6 class="mb-0">Admin Support</h6>
                        <small class="text-muted">2 hours ago</small>
                    </div>
                </div>
                <div class="message-content mb-4">
                    <p>Dear Instructor,</p>
                    <p>We are pleased to inform you that your course "Web Development Fundamentals" has been reviewed and approved by our content team. The course is now live on the platform and available for student enrollment.</p>
                    <p>Here's a summary of your course details:</p>
                    <ul>
                        <li><strong>Course Title:</strong> Web Development Fundamentals</li>
                        <li><strong>Category:</strong> Web Development</li>
                        <li><strong>Level:</strong> Beginner</li>
                        <li><strong>Lessons:</strong> 12</li>
                    </ul>
                    <p>You can now promote your course and start engaging with students. Remember to respond to student questions promptly to maintain a high instructor rating.</p>
                    <p>Thank you for contributing to our learning platform!</p>
                    <p>Best regards,<br>SkillForge Admin Team</p>
                </div>
                <hr>
                <div class="reply-section">
                    <h6>Reply:</h6>
                    <textarea class="form-control mb-3" rows="3" placeholder="Type your reply here..."></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Reply</button>
            </div>
        </div>
    </div>
</div>

<style>
    .unread h6 {
        font-weight: 600;
    }
    .unread {
        background-color: rgba(13, 110, 253, 0.05);
    }
    .list-group-item-action:hover {
        background-color: #f8f9fa;
    }
    .message-content {
        line-height: 1.6;
    }
</style>

<%@ include file="/common/footer.jsp" %>
