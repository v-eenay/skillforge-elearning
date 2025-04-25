<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Initialize Categories - SkillForge Admin</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/common/header.jsp" />
    
    <div class="container-fluid">
        <div class="row">
            <!-- Include Admin Sidebar -->
            <jsp:include page="/WEB-INF/views/admin/sidebar.jsp" />
            
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Initialize Categories</h1>
                </div>
                
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card shadow-sm mb-4">
                            <div class="card-header bg-white py-3">
                                <h5 class="mb-0">Category Initialization</h5>
                            </div>
                            <div class="card-body p-4">
                                <c:if test="${not empty sessionScope.categoryInitMessage}">
                                    <div class="alert ${sessionScope.categoryInitSuccess ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                                        ${sessionScope.categoryInitMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                    <c:remove var="categoryInitMessage" scope="session" />
                                    <c:remove var="categoryInitSuccess" scope="session" />
                                </c:if>
                                
                                <p>This utility will initialize default categories for courses:</p>
                                <ul class="mb-4">
                                    <li>Web Development</li>
                                    <li>Mobile Development</li>
                                    <li>Data Science</li>
                                    <li>Programming Languages</li>
                                    <li>Database Management</li>
                                    <li>DevOps</li>
                                    <li>Cloud Computing</li>
                                    <li>Cybersecurity</li>
                                    <li>Game Development</li>
                                    <li>UI/UX Design</li>
                                </ul>
                                
                                <div class="alert alert-info">
                                    <div class="d-flex">
                                        <div class="me-3">
                                            <i class="fas fa-info-circle fa-2x"></i>
                                        </div>
                                        <div>
                                            <h5 class="alert-heading">Information</h5>
                                            <p class="mb-0">This operation is safe to run multiple times as it only creates categories that don't already exist.</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <form method="post" action="${pageContext.request.contextPath}/admin/initialize-categories" class="mt-4">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-tags me-2"></i>Initialize Categories
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4">
                        <div class="card shadow-sm mb-4">
                            <div class="card-header bg-white py-3">
                                <h5 class="mb-0">Help</h5>
                            </div>
                            <div class="card-body p-4">
                                <p>Categories are used to organize courses into logical groups. Each course must belong to a category.</p>
                                <p>If you need to add custom categories, you can do so from the course creation page.</p>
                                <p>This utility is provided as a convenience to initialize the system with common categories.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="/common/footer.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
