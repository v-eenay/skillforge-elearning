<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="bg-dark text-white py-5 mt-auto">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4 mb-md-0">
                <h5 class="mb-3">SkillForge</h5>
                <p class="text-muted">Empowering learners worldwide with high-quality courses and expert instructors.</p>
                <div class="social-icons mt-3">
                    <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
            <div class="col-md-2 mb-4 mb-md-0">
                <h6 class="mb-3">Explore</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/courses" class="text-muted">Courses</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/instructors" class="text-muted">Instructors</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/categories" class="text-muted">Categories</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/blog" class="text-muted">Blog</a></li>
                </ul>
            </div>
            <div class="col-md-2 mb-4 mb-md-0">
                <h6 class="mb-3">For Instructors</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/instructor" class="text-muted">Dashboard</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/instructor/courses/create" class="text-muted">Create Course</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/instructor/resources" class="text-muted">Resources</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/instructor/community" class="text-muted">Community</a></li>
                </ul>
            </div>
            <div class="col-md-2 mb-4 mb-md-0">
                <h6 class="mb-3">Support</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/help" class="text-muted">Help Center</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/contact" class="text-muted">Contact Us</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/faq" class="text-muted">FAQ</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/feedback" class="text-muted">Feedback</a></li>
                </ul>
            </div>
            <div class="col-md-2">
                <h6 class="mb-3">Legal</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/terms" class="text-muted">Terms of Service</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/privacy" class="text-muted">Privacy Policy</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/cookies" class="text-muted">Cookie Policy</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/accessibility" class="text-muted">Accessibility</a></li>
                </ul>
            </div>
        </div>
        <hr class="my-4 bg-secondary">
        <div class="row align-items-center">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0 text-muted">&copy; 2023 SkillForge. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-center text-md-end mt-3 mt-md-0">
                <div class="dropdown d-inline-block">
                    <button class="btn btn-sm btn-outline-light dropdown-toggle" type="button" id="languageDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-globe me-1"></i> English
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="languageDropdown">
                        <li><a class="dropdown-item" href="#">English</a></li>
                        <li><a class="dropdown-item" href="#">Español</a></li>
                        <li><a class="dropdown-item" href="#">Français</a></li>
                        <li><a class="dropdown-item" href="#">Deutsch</a></li>
                        <li><a class="dropdown-item" href="#">日本語</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>
