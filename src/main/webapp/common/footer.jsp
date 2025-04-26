<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="modern-footer">
    <div class="container">
        <div class="row g-4">
            <!-- SkillForge Section -->
            <div class="col-lg-4 col-md-6 footer-animate">
                <h5>SkillForge</h5>
                <p>Your gateway to professional skills and knowledge. Learn from industry experts and advance your career.</p>
                <div class="social-icons">
                    <a href="#" class="social-icon-link">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="social-icon-link">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="social-icon-link">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" class="social-icon-link">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                    <a href="#" class="social-icon-link">
                        <i class="fab fa-github"></i>
                    </a>
                </div>
            </div>

            <!-- Quick Links Section -->
            <div class="col-lg-2 col-md-6 footer-animate">
                <h5>Quick Links</h5>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/courses">Courses</a></li>
                    <li><a href="${pageContext.request.contextPath}/instructors">Instructors</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                </ul>
            </div>

            <!-- Contact Us Section -->
            <div class="col-lg-3 col-md-6 footer-animate">
                <h5>Contact Us</h5>
                <div class="contact-info">
                    <a href="mailto:koiralavinay@gmail.com">
                        <i class="fas fa-envelope"></i>
                        koiralavinay@gmail.com
                    </a>
                    <a href="mailto:binaya.koirala@iic.edu.np">
                        <i class="fas fa-envelope"></i>
                        binaya.koirala@iic.edu.np
                    </a>
                </div>
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <div>
                            <p>Start your learning journey today!</p>
                            <a href="${pageContext.request.contextPath}/auth/register" class="dashboard-btn">Join Now</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div>
                            <p>Access your learning materials</p>
                            <a href="${pageContext.request.contextPath}/${sessionScope.userRole}/dashboard" class="dashboard-btn outline">Dashboard</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Newsletter Section -->
            <div class="col-lg-3 col-md-6 footer-animate">
                <h5>Newsletter</h5>
                <p>Subscribe to our newsletter for updates and exclusive content.</p>
                <div class="newsletter-form">
                    <div class="input-group mb-3">
                        <input type="email" class="form-control" placeholder="Enter your email">
                    </div>
                    <button class="btn btn-primary w-100" type="button">
                        <i class="fas fa-paper-plane me-2"></i> Subscribe
                    </button>
                </div>
            </div>
        </div>

        <!-- Footer Bottom -->
        <div class="footer-bottom">
            <div class="copyright">
                <span class="brand-name">Vinay Koirala</span>
                <span>SkillForge &trade; All rights reserved.</span>
                <span>&copy; <span class="year"><%= java.time.Year.now().getValue() %></span></span>
            </div>
        </div>
    </div>
</footer>

<!-- External Resources -->
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>