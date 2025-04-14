<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>

<section class="container py-5">
    <div class="row mb-4">
        <div class="col-lg-8">
            <h1 class="display-5 fw-bold mb-2">Contact Management</h1>
            <p class="lead">View and manage contact form submissions</p>
        </div>
        <div class="col-lg-4 text-lg-end d-flex align-items-center justify-content-lg-end">
            <div class="dropdown">
                <button class="btn btn-outline-primary dropdown-toggle" type="button" id="statusFilterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-filter me-2"></i>
                    <c:choose>
                        <c:when test="${not empty currentStatus}">
                            <c:choose>
                                <c:when test="${currentStatus eq 'new'}">New</c:when>
                                <c:when test="${currentStatus eq 'read'}">Read</c:when>
                                <c:when test="${currentStatus eq 'replied'}">Replied</c:when>
                                <c:otherwise>All Contacts</c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>All Contacts</c:otherwise>
                    </c:choose>
                </button>
                <ul class="dropdown-menu" aria-labelledby="statusFilterDropdown">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/contacts">All Contacts</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/contacts?status=new">New</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/contacts?status=read">Read</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/contacts?status=replied">Replied</a></li>
                </ul>
            </div>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Subject</th>
                            <th scope="col">Date</th>
                            <th scope="col">Status</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty contacts}">
                                <tr>
                                    <td colspan="7" class="text-center py-4">No contact submissions found.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="contact" items="${contacts}">
                                    <tr>
                                        <td>${contact.contactId}</td>
                                        <td>${contact.name}</td>
                                        <td><a href="mailto:${contact.email}">${contact.email}</a></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${empty contact.subject}">
                                                    <span class="text-muted">(No subject)</span>
                                                </c:when>
                                                <c:otherwise>
                                                    ${contact.subject}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <fmt:parseDate value="${contact.submittedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                            <fmt:formatDate value="${parsedDate}" pattern="MMM d, yyyy h:mm a" />
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${contact.status eq 'new_status'}">
                                                    <span class="badge bg-primary">New</span>
                                                </c:when>
                                                <c:when test="${contact.status eq 'read'}">
                                                    <span class="badge bg-info">Read</span>
                                                </c:when>
                                                <c:when test="${contact.status eq 'replied'}">
                                                    <span class="badge bg-success">Replied</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="contactActionDropdown${contact.contactId}" data-bs-toggle="dropdown" aria-expanded="false">
                                                    Actions
                                                </button>
                                                <ul class="dropdown-menu" aria-labelledby="contactActionDropdown${contact.contactId}">
                                                    <li>
                                                        <button type="button" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#viewContactModal${contact.contactId}">
                                                            <i class="fas fa-eye me-2"></i> View Details
                                                        </button>
                                                    </li>
                                                    <c:if test="${contact.status ne 'read' && contact.status ne 'replied'}">
                                                        <li>
                                                            <form action="${pageContext.request.contextPath}/admin/contacts" method="post">
                                                                <input type="hidden" name="action" value="markAsRead">
                                                                <input type="hidden" name="contactId" value="${contact.contactId}">
                                                                <button type="submit" class="dropdown-item">
                                                                    <i class="fas fa-check me-2"></i> Mark as Read
                                                                </button>
                                                            </form>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${contact.status ne 'replied'}">
                                                        <li>
                                                            <form action="${pageContext.request.contextPath}/admin/contacts" method="post">
                                                                <input type="hidden" name="action" value="markAsReplied">
                                                                <input type="hidden" name="contactId" value="${contact.contactId}">
                                                                <button type="submit" class="dropdown-item">
                                                                    <i class="fas fa-reply me-2"></i> Mark as Replied
                                                                </button>
                                                            </form>
                                                        </li>
                                                    </c:if>
                                                    <li>
                                                        <a href="mailto:${contact.email}?subject=Re: ${contact.subject}" class="dropdown-item">
                                                            <i class="fas fa-envelope me-2"></i> Reply via Email
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    
                                    <!-- View Contact Modal -->
                                    <div class="modal fade" id="viewContactModal${contact.contactId}" tabindex="-1" aria-labelledby="viewContactModalLabel${contact.contactId}" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="viewContactModalLabel${contact.contactId}">Contact Details</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row mb-3">
                                                        <div class="col-md-6">
                                                            <p class="mb-1"><strong>Name:</strong> ${contact.name}</p>
                                                            <p class="mb-1"><strong>Email:</strong> <a href="mailto:${contact.email}">${contact.email}</a></p>
                                                            <p class="mb-1">
                                                                <strong>Status:</strong>
                                                                <c:choose>
                                                                    <c:when test="${contact.status eq 'new_status'}">
                                                                        <span class="badge bg-primary">New</span>
                                                                    </c:when>
                                                                    <c:when test="${contact.status eq 'read'}">
                                                                        <span class="badge bg-info">Read</span>
                                                                    </c:when>
                                                                    <c:when test="${contact.status eq 'replied'}">
                                                                        <span class="badge bg-success">Replied</span>
                                                                    </c:when>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <p class="mb-1">
                                                                <strong>Date:</strong>
                                                                <fmt:parseDate value="${contact.submittedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                                                <fmt:formatDate value="${parsedDate}" pattern="MMM d, yyyy h:mm a" />
                                                            </p>
                                                            <p class="mb-1">
                                                                <strong>User:</strong>
                                                                <c:choose>
                                                                    <c:when test="${not empty contact.userId}">
                                                                        <a href="${pageContext.request.contextPath}/admin/users?id=${contact.userId}">User #${contact.userId}</a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Guest</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                            <p class="mb-1">
                                                                <strong>Subject:</strong>
                                                                <c:choose>
                                                                    <c:when test="${empty contact.subject}">
                                                                        <span class="text-muted">(No subject)</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${contact.subject}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <h6 class="fw-bold">Message:</h6>
                                                        <div class="p-3 bg-light rounded">
                                                            <p class="mb-0" style="white-space: pre-wrap;">${contact.message}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <c:if test="${contact.status ne 'read' && contact.status ne 'replied'}">
                                                        <form action="${pageContext.request.contextPath}/admin/contacts" method="post" class="me-2">
                                                            <input type="hidden" name="action" value="markAsRead">
                                                            <input type="hidden" name="contactId" value="${contact.contactId}">
                                                            <button type="submit" class="btn btn-outline-primary">
                                                                <i class="fas fa-check me-2"></i> Mark as Read
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                    <c:if test="${contact.status ne 'replied'}">
                                                        <form action="${pageContext.request.contextPath}/admin/contacts" method="post" class="me-2">
                                                            <input type="hidden" name="action" value="markAsReplied">
                                                            <input type="hidden" name="contactId" value="${contact.contactId}">
                                                            <button type="submit" class="btn btn-outline-primary">
                                                                <i class="fas fa-reply me-2"></i> Mark as Replied
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                    <a href="mailto:${contact.email}?subject=Re: ${contact.subject}" class="btn btn-primary">
                                                        <i class="fas fa-envelope me-2"></i> Reply via Email
                                                    </a>
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<%@ include file="/common/footer.jsp" %>
