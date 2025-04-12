<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Occurred - SkillForge</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-5 text-center">
                        <div class="mb-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" fill="currentColor" class="bi bi-exclamation-circle-fill text-danger" viewBox="0 0 16 16">
                                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4zm.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"></path>
                            </svg>
                        </div>
                        <h1 class="display-5 fw-bold mb-3">Oops! Something Went Wrong</h1>
                        <p class="lead mb-4">We're sorry, but an unexpected error has occurred. Our team has been notified and is working to fix the issue.</p>
                        <% if (exception != null) { %>
                            <div class="alert alert-danger text-start mb-4">
                                <p><strong>Error Details:</strong> <%= exception.getMessage() %></p>
                            </div>
                        <% } %>
                        <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg px-4 gap-3">Return to Home</a>
                            <button onclick="window.history.back()" class="btn btn-outline-secondary btn-lg px-4">Go Back</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>