<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/header.jsp" %>

<div class="container py-5">
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="mb-3">Database Setup</h2>
            <p class="text-muted">Initialize the database and tables for the SkillForge application.</p>
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
                    <h5 class="mb-0">Database Initialization</h5>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty message}">
                        <div class="alert ${success ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                            ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <p>This utility will perform the following operations:</p>
                    <ul class="mb-4">
                        <li>Check if the database exists and create it if needed</li>
                        <li>Check if all required tables exist and create them if needed</li>
                        <li>Initialize default data if the tables are empty</li>
                    </ul>

                    <div class="alert alert-warning">
                        <div class="d-flex">
                            <div class="me-3">
                                <i class="fas fa-exclamation-triangle fa-2x"></i>
                            </div>
                            <div>
                                <h5 class="alert-heading">Warning</h5>
                                <p class="mb-0">This operation is safe to run multiple times as it only creates missing database objects. However, if you have made manual changes to the database schema, those changes might be affected.</p>
                            </div>
                        </div>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/admin/setup-database" class="mt-4">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-database me-2"></i>Initialize Database
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Database Information</h5>
                </div>
                <div class="card-body p-4">
                    <p class="mb-3">Current database configuration:</p>
                    <ul class="list-group list-group-flush mb-3">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span>Database Name</span>
                            <span class="badge bg-primary rounded-pill">${dbName}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span>Database URL</span>
                            <span class="badge bg-secondary rounded-pill">${dbUrl}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span>Database User</span>
                            <span class="badge bg-info rounded-pill">${dbUsername}</span>
                        </li>
                    </ul>
                    <p class="small text-muted">These settings are configured in your application.properties file.</p>
                </div>
            </div>

            <div class="card shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Need Help?</h5>
                </div>
                <div class="card-body p-4">
                    <p>If you encounter any issues with database setup:</p>
                    <ul class="mb-0">
                        <li>Check your database connection settings</li>
                        <li>Ensure MySQL is running and accessible</li>
                        <li>Verify the database user has sufficient privileges</li>
                        <li>Check application logs for detailed error messages</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
