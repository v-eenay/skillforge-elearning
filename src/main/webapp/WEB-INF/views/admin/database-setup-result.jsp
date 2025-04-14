<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/header.jsp" %>

<div class="container py-5">
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="mb-3">Database Setup Result</h2>
            <p class="text-muted">Results of the database initialization process.</p>
        </div>
        <div class="col-md-4 text-end">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Operation Result</h5>
                </div>
                <div class="card-body p-4">
                    <c:choose>
                        <c:when test="${success}">
                            <div class="text-center mb-4">
                                <div class="mb-3">
                                    <i class="fas fa-check-circle text-success fa-5x"></i>
                                </div>
                                <h4 class="text-success">Database Initialization Successful</h4>
                                <p class="text-muted">All database objects have been created successfully.</p>
                            </div>
                            
                            <div class="alert alert-success">
                                <h5 class="alert-heading">Success Details</h5>
                                <p>${message}</p>
                                <hr>
                                <p class="mb-0">The application is now ready to use with the initialized database.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center mb-4">
                                <div class="mb-3">
                                    <i class="fas fa-exclamation-circle text-danger fa-5x"></i>
                                </div>
                                <h4 class="text-danger">Database Initialization Failed</h4>
                                <p class="text-muted">There was an error during the database initialization process.</p>
                            </div>
                            
                            <div class="alert alert-danger">
                                <h5 class="alert-heading">Error Details</h5>
                                <p>${message}</p>
                                <hr>
                                <p class="mb-0">Please check the server logs for more detailed error information.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="mt-4 d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/admin/setup-database" class="btn btn-outline-secondary">
                            <i class="fas fa-redo me-2"></i>Run Setup Again
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary">
                            <i class="fas fa-tachometer-alt me-2"></i>Go to Dashboard
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Next Steps</h5>
                </div>
                <div class="card-body p-4">
                    <p>Now that your database is set up, you can:</p>
                    <ul class="mb-0">
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/admin/users" class="text-decoration-none">Manage Users</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/admin/dashboard" class="text-decoration-none">View Dashboard</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/" class="text-decoration-none">Go to Homepage</a></li>
                    </ul>
                </div>
            </div>

            <div class="card shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Need Help?</h5>
                </div>
                <div class="card-body p-4">
                    <p>If you encounter any issues with the application:</p>
                    <ul class="mb-0">
                        <li>Check the application logs for error details</li>
                        <li>Verify your database connection is working</li>
                        <li>Ensure all required tables were created</li>
                        <li>Contact the system administrator for assistance</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
