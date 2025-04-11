</main>
    <footer class="bg-dark text-white py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>SkillForge</h5>
                    <p>Your gateway to professional skills and knowledge. Learn from industry experts and advance your career.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Courses</a></li>
                        <li><a href="#" class="text-white">Instructors</a></li>
                        <li><a href="#" class="text-white">About Us</a></li>
                        <li><a href="#" class="text-white">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Contact Us</h5>
                    <address>
                        <strong>Vinay Koirala</strong><br>
                        Email: <a href="mailto:koiralavinay@gmail.com" class="text-white">koiralavinay@gmail.com</a><br>
                        Email: <a href="mailto:binaya.koirala@iic.edu.np" class="text-white">binaya.koirala@iic.edu.np</a>
                    </address>
                    <c:if test="${empty user}">
                        <div class="mt-3">
                            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary">Join Now</a>
                        </div>
                    </c:if>
                </div>
            </div>
            <hr>
            <div class="text-center mt-3">
                <div class="d-flex justify-content-center align-items-center flex-column">
                    <div class="mb-2">
                        <span class="fw-bold" style="font-size: 1.2rem; color: #007bff;">Vinay Koirala</span>
                        <span class="badge bg-primary ms-2">Developer</span>
                    </div>
                    <p class="mb-0">
                        <span class="copyright-year">&copy; <span style="font-weight: 600; letter-spacing: 1px; color: #ffc107;"><%= java.time.Year.now().getValue() %></span></span>
                        <span class="ms-2">SkillForge &trade; All rights reserved.</span>
                    </p>
                </div>
            </div>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>