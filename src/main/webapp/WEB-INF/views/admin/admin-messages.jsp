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
                <h2>Message Center</h2>
                <p>Manage platform communications and support requests.</p>
            </div>
            <div class="col-md-4">
                <div class="dashboard-actions">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#composeMessageModal">
                        <i class="fas fa-pen"></i> Compose New Message
                    </button>
                    <button class="btn btn-outline-primary">
                        <i class="fas fa-cog"></i> Message Settings
                    </button>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Message Sidebar -->
            <div class="col-md-3 mb-4">
                <div class="content-card">
                    <div class="card-header">
                        <h5 class="mb-0">Message Categories</h5>
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action active d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-inbox me-2"></i> All Messages</span>
                            <span class="badge bg-primary rounded-pill">3</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-question-circle me-2"></i> Support Requests</span>
                            <span class="badge bg-danger rounded-pill">2</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-check-circle me-2"></i> Course Approvals</span>
                            <span class="badge bg-warning rounded-pill">1</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-bullhorn me-2"></i> Announcements</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-archive me-2"></i> Archived</span>
                            <span class="badge bg-secondary rounded-pill">15</span>
                        </a>
                    </div>
                </div>
                
                <div class="content-card mt-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Quick Stats</h5>
                        <button class="btn btn-sm btn-outline-primary"><i class="fas fa-sync-alt"></i></button>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <h6 class="mb-2">Response Rate</h6>
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 92%;" aria-valuenow="92" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between mt-1">
                                <small class="text-muted">92% of messages answered</small>
                                <small class="text-muted">Target: 95%</small>
                            </div>
                        </div>
                        <div class="mb-3">
                            <h6 class="mb-2">Average Response Time</h6>
                            <div class="d-flex align-items-center">
                                <i class="fas fa-clock text-primary me-2"></i>
                                <span class="fw-bold">3.2 hours</span>
                            </div>
                        </div>
                        <div>
                            <h6 class="mb-2">Messages Today</h6>
                            <div class="d-flex align-items-center">
                                <i class="fas fa-envelope text-primary me-2"></i>
                                <span class="fw-bold">12 new messages</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Message List -->
            <div class="col-md-9">
                <div class="content-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center">
                            <h5 class="mb-0 me-3">All Messages</h5>
                            <div class="btn-group btn-group-sm" role="group">
                                <button type="button" class="btn btn-outline-secondary active">All</button>
                                <button type="button" class="btn btn-outline-secondary">Unread</button>
                                <button type="button" class="btn btn-outline-secondary">Flagged</button>
                            </div>
                        </div>
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
                                        <img src="https://placebeard.it/45/45?image=7" class="rounded-circle" alt="Student">
                                    </div>
                                    <div>
                                        <div class="d-flex align-items-center mb-1">
                                            <h6 class="mb-0 fw-bold">Payment Issue</h6>
                                            <span class="badge bg-danger ms-2">Support</span>
                                        </div>
                                        <p class="mb-1 text-truncate" style="max-width: 500px;">I'm having trouble with my course payment. The transaction was completed but I still don't have access to the course.</p>
                                        <small class="text-muted">From: David Wilson (Student) • 1 hour ago</small>
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
                                        <img src="https://placebeard.it/45/45?image=5" class="rounded-circle" alt="Instructor">
                                    </div>
                                    <div>
                                        <div class="d-flex align-items-center mb-1">
                                            <h6 class="mb-0 fw-bold">Course Review Request</h6>
                                            <span class="badge bg-warning ms-2">Approval</span>
                                        </div>
                                        <p class="mb-1 text-truncate" style="max-width: 500px;">I've submitted my new Python for Data Analysis course for review. Looking forward to your feedback and approval.</p>
                                        <small class="text-muted">From: John Smith (Instructor) • 3 hours ago</small>
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
                                        <img src="https://placebeard.it/45/45?image=8" class="rounded-circle" alt="Student">
                                    </div>
                                    <div>
                                        <div class="d-flex align-items-center mb-1">
                                            <h6 class="mb-0 fw-bold">Account Recovery</h6>
                                            <span class="badge bg-danger ms-2">Support</span>
                                        </div>
                                        <p class="mb-1 text-truncate" style="max-width: 500px;">I can't access my account. I've tried resetting my password but I'm not receiving the reset email.</p>
                                        <small class="text-muted">From: Sarah Johnson (Student) • 5 hours ago</small>
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
                                        <img src="https://placebeard.it/45/45?image=6" class="rounded-circle" alt="Instructor">
                                    </div>
                                    <div>
                                        <div class="d-flex align-items-center mb-1">
                                            <h6 class="mb-0">Payout Question</h6>
                                        </div>
                                        <p class="mb-1 text-truncate" style="max-width: 500px;">I have a question about my instructor payout for last month. The amount seems lower than expected based on my course enrollments.</p>
                                        <small class="text-muted">From: Maria Garcia (Instructor) • Yesterday</small>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action" data-bs-toggle="modal" data-bs-target="#viewMessageModal">
                            <div class="d-flex w-100 justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <div class="me-3">
                                        <img src="https://placebeard.it/45/45?image=9" class="rounded-circle" alt="Student">
                                    </div>
                                    <div>
                                        <div class="d-flex align-items-center mb-1">
                                            <h6 class="mb-0">Certificate Issue</h6>
                                            <span class="badge bg-danger ms-2">Support</span>
                                        </div>
                                        <p class="mb-1 text-truncate" style="max-width: 500px;">I completed the JavaScript Masterclass course but haven't received my certificate yet. The course shows as 100% complete in my dashboard.</p>
                                        <small class="text-muted">From: Michael Brown (Student) • 2 days ago</small>
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
                        <label for="messageType" class="form-label">Message Type:</label>
                        <select class="form-select" id="messageType" required>
                            <option value="" selected disabled>Select message type</option>
                            <option value="direct">Direct Message</option>
                            <option value="announcement">Platform Announcement</option>
                            <option value="notification">System Notification</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="recipient" class="form-label">To:</label>
                        <select class="form-select" id="recipient" required>
                            <option value="" selected disabled>Select recipient</option>
                            <option value="all">All Users</option>
                            <option value="instructors">All Instructors</option>
                            <option value="students">All Students</option>
                            <option value="custom">Select Specific Users</option>
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
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="priority">
                        <label class="form-check-label" for="priority">Mark as Priority</label>
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
                <h5 class="modal-title" id="viewMessageModalLabel">Payment Issue</h5>
                <div>
                    <button type="button" class="btn btn-sm btn-outline-secondary me-1">
                        <i class="fas fa-flag"></i> Flag
                    </button>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
            </div>
            <div class="modal-body">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="d-flex align-items-center">
                        <img src="https://placebeard.it/50/50?image=7" class="rounded-circle me-3" alt="Student">
                        <div>
                            <h6 class="mb-0">David Wilson <span class="badge bg-info ms-1">Student</span></h6>
                            <small class="text-muted">1 hour ago</small>
                        </div>
                    </div>
                    <div>
                        <span class="badge bg-danger">Support Request</span>
                        <span class="badge bg-warning">Payment</span>
                    </div>
                </div>
                <div class="message-content mb-4">
                    <p>Hello Admin Support,</p>
                    <p>I'm writing because I'm having an issue with a course payment. Yesterday, I purchased the "Advanced JavaScript Techniques" course for $49.99, and the payment was successfully processed through PayPal (Transaction ID: PAY-12345XYZ).</p>
                    <p>However, the course is still showing as "Not Enrolled" in my dashboard, and I can't access any of the content. I've already tried logging out and back in, as well as clearing my browser cache, but the issue persists.</p>
                    <p>Could you please help me resolve this issue? I've attached a screenshot of my payment confirmation for reference.</p>
                    <p>Thank you for your assistance.</p>
                    <p>Best regards,<br>David Wilson</p>
                    <div class="mt-3">
                        <span class="badge bg-light text-dark p-2">
                            <i class="fas fa-paperclip me-1"></i> payment_confirmation.jpg (120 KB)
                        </span>
                    </div>
                </div>
                <hr>
                <div class="user-info-card mb-4 p-3 border rounded bg-light">
                    <h6 class="mb-3"><i class="fas fa-user-circle me-2"></i> User Information</h6>
                    <div class="row">
                        <div class="col-md-6">
                            <p class="mb-1"><strong>User ID:</strong> STU-10042</p>
                            <p class="mb-1"><strong>Email:</strong> david.wilson@example.com</p>
                            <p class="mb-1"><strong>Join Date:</strong> March 15, 2023</p>
                        </div>
                        <div class="col-md-6">
                            <p class="mb-1"><strong>Courses Enrolled:</strong> 3</p>
                            <p class="mb-1"><strong>Last Login:</strong> Today, 10:23 AM</p>
                            <p class="mb-1"><strong>Account Status:</strong> <span class="text-success">Active</span></p>
                        </div>
                    </div>
                </div>
                <div class="reply-section">
                    <h6>Reply:</h6>
                    <textarea class="form-control mb-3" rows="4" placeholder="Type your reply here..."></textarea>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="sendCopy">
                        <label class="form-check-label" for="sendCopy">
                            Send a copy to the payment team
                        </label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="dropdown me-2">
                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="actionDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        Actions
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="actionDropdown">
                        <li><a class="dropdown-item" href="#"><i class="fas fa-user-check me-2"></i> Verify Payment</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-exchange-alt me-2"></i> Transfer to Payment Team</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-archive me-2"></i> Archive</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="#"><i class="fas fa-ban me-2"></i> Mark as Spam</a></li>
                    </ul>
                </div>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Send Reply</button>
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
