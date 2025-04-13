<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/header.jsp" %>

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">User Management</h2>
        <div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-primary me-2">
                <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
            </a>
        </div>
    </div>

    <!-- Alerts -->
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

    <!-- User Management Card -->
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white p-4 border-0 d-flex justify-content-between align-items-center">
            <h4 class="fw-bold mb-0">All Users</h4>
            <div class="d-flex">
                <div class="input-group me-3" style="width: 300px;">
                    <input type="text" class="form-control" placeholder="Search users..." id="userSearch">
                    <button class="btn btn-outline-secondary" type="button">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <div class="dropdown">
                    <button class="btn btn-outline-primary dropdown-toggle" type="button" id="filterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        Filter
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="filterDropdown">
                        <li><a class="dropdown-item" href="#">All Users</a></li>
                        <li><a class="dropdown-item" href="#">Admins</a></li>
                        <li><a class="dropdown-item" href="#">Instructors</a></li>
                        <li><a class="dropdown-item" href="#">Students</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">Active</a></li>
                        <li><a class="dropdown-item" href="#">Suspended</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">User</th>
                            <th scope="col">Email</th>
                            <th scope="col">Role</th>
                            <th scope="col">Status</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.userId}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <c:choose>
                                            <c:when test="${not empty user.profileImage}">
                                                <img src="${user.profileImage}" alt="${user.name}" class="rounded-circle me-2" width="40" height="40" style="object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 40px; height: 40px;">
                                                    ${fn:substring(user.name, 0, 1)}
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div>
                                            <h6 class="mb-0">${user.name}</h6>
                                            <small class="text-muted">@${user.userName}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>${user.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.role == 'admin'}">
                                            <span class="badge bg-danger">Admin</span>
                                        </c:when>
                                        <c:when test="${user.role == 'instructor'}">
                                            <span class="badge bg-info">Instructor</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-primary">Student</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.status == 'active'}">
                                            <span class="badge bg-success">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning text-dark">Suspended</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="dropdown">
                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="actionDropdown${user.userId}" data-bs-toggle="dropdown" aria-expanded="false">
                                            Actions
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="actionDropdown${user.userId}">
                                            <li>
                                                <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#viewUserModal${user.userId}">
                                                    <i class="fas fa-eye me-2"></i> View Details
                                                </a>
                                            </li>
                                            <c:if test="${user.role != 'admin'}">
                                                <c:choose>
                                                    <c:when test="${user.status == 'active'}">
                                                        <li>
                                                            <form action="${pageContext.request.contextPath}/admin/users" method="post" class="suspend-form">
                                                                <input type="hidden" name="action" value="suspend">
                                                                <input type="hidden" name="userId" value="${user.userId}">
                                                                <button type="submit" class="dropdown-item text-warning">
                                                                    <i class="fas fa-ban me-2"></i> Suspend
                                                                </button>
                                                            </form>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li>
                                                            <form action="${pageContext.request.contextPath}/admin/users" method="post" class="activate-form">
                                                                <input type="hidden" name="action" value="activate">
                                                                <input type="hidden" name="userId" value="${user.userId}">
                                                                <button type="submit" class="dropdown-item text-success">
                                                                    <i class="fas fa-check-circle me-2"></i> Activate
                                                                </button>
                                                            </form>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                                <li><hr class="dropdown-divider"></li>
                                                <li>
                                                    <form action="${pageContext.request.contextPath}/admin/users" method="post" class="delete-form">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="userId" value="${user.userId}">
                                                        <button type="submit" class="dropdown-item text-danger" onclick="return confirm('Are you sure you want to delete this user? This action cannot be undone.')">
                                                            <i class="fas fa-trash-alt me-2"></i> Delete
                                                        </button>
                                                    </form>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </div>

                                    <!-- User Details Modal -->
                                    <div class="modal fade" id="viewUserModal${user.userId}" tabindex="-1" aria-labelledby="viewUserModalLabel${user.userId}" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="viewUserModalLabel${user.userId}">User Details</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-4 text-center mb-4 mb-md-0">
                                                            <c:choose>
                                                                <c:when test="${not empty user.profileImage}">
                                                                    <img src="${user.profileImage}" alt="${user.name}" class="rounded-circle img-fluid mb-3" style="width: 150px; height: 150px; object-fit: cover;">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 150px; height: 150px; font-size: 4rem;">
                                                                        ${fn:substring(user.name, 0, 1)}
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <h4 class="fw-bold">${user.name}</h4>
                                                            <p class="text-muted">@${user.userName}</p>
                                                            <div class="d-flex justify-content-center">
                                                                <c:choose>
                                                                    <c:when test="${user.role == 'admin'}">
                                                                        <span class="badge bg-danger me-2 px-3 py-2">Admin</span>
                                                                    </c:when>
                                                                    <c:when test="${user.role == 'instructor'}">
                                                                        <span class="badge bg-info me-2 px-3 py-2">Instructor</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-primary me-2 px-3 py-2">Student</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <c:choose>
                                                                    <c:when test="${user.status == 'active'}">
                                                                        <span class="badge bg-success px-3 py-2">Active</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-warning text-dark px-3 py-2">Suspended</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <h5 class="fw-bold mb-3">User Information</h5>
                                                            <div class="mb-3">
                                                                <p class="mb-1 fw-bold">User ID</p>
                                                                <p>${user.userId}</p>
                                                            </div>
                                                            <div class="mb-3">
                                                                <p class="mb-1 fw-bold">Email</p>
                                                                <p>${user.email}</p>
                                                            </div>
                                                            <div class="mb-3">
                                                                <p class="mb-1 fw-bold">Bio</p>
                                                                <p>${not empty user.bio ? user.bio : 'No bio provided'}</p>
                                                            </div>
                                                            <div class="mb-3">
                                                                <p class="mb-1 fw-bold">Joined</p>
                                                                <p>April 2023</p>
                                                            </div>
                                                            <c:if test="${user.role == 'student'}">
                                                                <div class="mb-3">
                                                                    <p class="mb-1 fw-bold">Enrolled Courses</p>
                                                                    <p>4 courses</p>
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${user.role == 'instructor'}">
                                                                <div class="mb-3">
                                                                    <p class="mb-1 fw-bold">Published Courses</p>
                                                                    <p>5 courses</p>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <p class="mb-1 fw-bold">Total Students</p>
                                                                    <p>247 students</p>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    <c:if test="${user.role != 'admin'}">
                                                        <c:choose>
                                                            <c:when test="${user.status == 'active'}">
                                                                <form action="${pageContext.request.contextPath}/admin/users" method="post" class="d-inline">
                                                                    <input type="hidden" name="action" value="suspend">
                                                                    <input type="hidden" name="userId" value="${user.userId}">
                                                                    <button type="submit" class="btn btn-warning">Suspend User</button>
                                                                </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form action="${pageContext.request.contextPath}/admin/users" method="post" class="d-inline">
                                                                    <input type="hidden" name="action" value="activate">
                                                                    <input type="hidden" name="userId" value="${user.userId}">
                                                                    <button type="submit" class="btn btn-success">Activate User</button>
                                                                </form>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer bg-white p-3 border-0">
            <nav aria-label="User pagination">
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

<script>
    // Client-side search functionality
    document.getElementById('userSearch').addEventListener('keyup', function() {
        const searchValue = this.value.toLowerCase();
        const tableRows = document.querySelectorAll('tbody tr');

        tableRows.forEach(row => {
            const userName = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
            const userEmail = row.querySelector('td:nth-child(3)').textContent.toLowerCase();

            if (userName.includes(searchValue) || userEmail.includes(searchValue)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });

    // Confirm before form submission
    document.querySelectorAll('.delete-form').forEach(form => {
        form.addEventListener('submit', function(e) {
            if (!confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                e.preventDefault();
            }
        });
    });

    document.querySelectorAll('.suspend-form').forEach(form => {
        form.addEventListener('submit', function(e) {
            if (!confirm('Are you sure you want to suspend this user?')) {
                e.preventDefault();
            }
        });
    });
</script>

<%@ include file="/common/footer.jsp" %>
