<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillForge - Online Learning Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">
</head>
<body>
    <header class="bg-dark text-white py-3">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-4">
                    <h1 class="mb-0"><a href="${pageContext.request.contextPath}/" class="text-white text-decoration-none">SkillForge</a></h1>
                </div>
                <div class="col-md-8">
                    <nav class="d-flex justify-content-end">
                        <ul class="nav">
                            <li class="nav-item"><a href="${pageContext.request.contextPath}/" class="nav-link text-white">Home</a></li>
                            <li class="nav-item"><a href="#" class="nav-link text-white">Courses</a></li>
                            <li class="nav-item"><a href="#" class="nav-link text-white">Instructors</a></li>
                            <li class="nav-item"><a href="#" class="nav-link text-white">About</a></li>
                            <li class="nav-item"><a href="#" class="nav-link text-white">Contact</a></li>
                            <li class="nav-item ms-3"><a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm">Login</a></li>
                            <li class="nav-item ms-2"><a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm">Sign Up</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <main class="py-5">