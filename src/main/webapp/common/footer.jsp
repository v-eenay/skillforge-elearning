<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<footer class="py-4">
    <div class="container">
        <div class="row g-4">
            <!-- SkillForge Section -->
            <div class="col-lg-4 col-md-6">
                <h5 class="mb-4">SkillForge</h5>
                <p class="mb-4">Your gateway to professional skills and knowledge. Learn from industry experts and advance your career.</p>
                <a href="#" class="btn btn-outline-light btn-sm rounded-circle me-2"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="btn btn-outline-light btn-sm rounded-circle me-2"><i class="fab fa-instagram"></i></a>
                <a href="#" class="btn btn-outline-light btn-sm rounded-circle"><i class="fab fa-github"></i></a>
            </div>

            <!-- Quick Links Section -->
            <div class="col-lg-2 col-md-6">
                <h5 class="mb-4">Quick Links</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="text-decoration-none">Courses</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none">Instructors</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none">About Us</a></li>
                    <li class="mb-2"><a href="#" class="text-decoration-none">Contact</a></li>
                </ul>
            </div>

            <!-- Contact Us Section -->
            <div class="col-lg-3 col-md-6">
                <h5 class="mb-4">Contact Us</h5>
                <address class="mb-4">
                    <p class="mb-1"><a href="mailto:koiralavinay@gmail.com" class="text-decoration-none">koiralavinay@gmail.com</a></p>
                    <p class="mb-0"><a href="mailto:binaya.koirala@iic.edu.np" class="text-decoration-none">binaya.koirala@iic.edu.np</a></p>
                </address>
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <div class="mt-4">
                            <p class="mb-3">Start your learning journey today!</p>
                            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary rounded-pill">Join Now</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mt-4">
                            <p class="mb-3">Access your learning materials</p>
                            <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-outline-light rounded-pill">Dashboard</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Newsletter Section -->
            <div class="col-lg-3 col-md-6">
                <h5 class="mb-4">Newsletter</h5>
                <p class="mb-3 ">Subscribe to our newsletter for updates and exclusive content.</p>
                <div class="input-group mb-3">
                    <input type="email" class="form-control rounded-pill" placeholder="Enter your email">
                    <button class="btn btn-primary rounded-pill ms-2" type="button">Subscribe</button>
                </div>
            </div>
        </div>

        <!-- Footer Bottom -->
        <hr class="my-4">
        <div class="text-center">
            <div class="d-flex justify-content-center align-items-center flex-column">
                <div class="mb-3">
                    <span class="fw-bold fs-5">Vinay Koirala</span>
                    <span class="ms-2">SkillForge &trade; All rights reserved.</span>
                    <span class="copyright-year">&copy; <span class="fw-semibold"><%= java.time.Year.now().getValue() %></span></span>
                </div>
            </div>
        </div>
    </div></footer>

<!-- External Resources -->
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>