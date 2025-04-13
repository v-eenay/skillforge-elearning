<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>

<section class="hero-section py-5 bg-light">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6 mb-4 mb-md-0">
                <h1 class="display-5 fw-bold">Unlock Your Potential with SkillForge</h1>
                <p class="lead">SkillForge is your gateway to mastering modern skills, accelerating your career, and achieving your goals. Learn from expert instructors with cutting-edge content.</p>
                <a href="${pageContext.request.contextPath}/courses" class="btn btn-dark btn-lg mt-3 px-4">Explore Courses</a>
            </div>
            <div class="col-md-6 text-center">
                <img src="https://placebeard.it/600/400" alt="Learning Platform" class="img-fluid rounded-4 shadow">
            </div>
        </div>
    </div>
</section>

<section class="py-5">
    <div class="container">
        <h2 class="text-center fw-semibold mb-5">Featured Courses</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100">
                    <img src="https://placebeard.it/500/300" class="card-img-top rounded-top" alt="Web Development Course">
                    <div class="card-body">
                        <h5 class="fw-bold">Full-Stack Web Development</h5>
                        <p class="text-muted">Master HTML, CSS, JavaScript, React, Node.js and more to become a complete web developer.</p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="fw-bold text-dark">$89.99</span>
                            <a href="${pageContext.request.contextPath}/courses" class="btn btn-outline-dark btn-sm">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100">
                    <img src="https://placebeard.it/500/300?image=2" class="card-img-top rounded-top" alt="Data Science Course">
                    <div class="card-body">
                        <h5 class="fw-bold">Data Science & Analytics</h5>
                        <p class="text-muted">Learn Python, R, SQL, and statistical analysis to extract insights from complex datasets.</p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="fw-bold text-dark">$99.99</span>
                            <a href="#" class="btn btn-outline-dark btn-sm">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100">
                    <img src="https://placebeard.it/500/300?image=3" class="card-img-top rounded-top" alt="Digital Marketing Course">
                    <div class="card-body">
                        <h5 class="fw-bold">Digital Marketing Mastery</h5>
                        <p class="text-muted">Develop skills in SEO, social media marketing, content strategy, and PPC advertising.</p>
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <span class="fw-bold text-dark">$79.99</span>
                            <a href="#" class="btn btn-outline-dark btn-sm">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="text-center mt-5">
            <a href="#" class="btn btn-dark px-5 py-2">View All Courses</a>
        </div>
    </div>
</section>

<section class="py-5 bg-white">
    <div class="container">
        <h2 class="text-center fw-semibold mb-5">Top Instructor</h2>
        <div class="row justify-content-center">
            <div class="col-md-6 text-center">
                <div class="p-4 border border-dark rounded-4 shadow-sm">
                    <img src="https://placebeard.it/150/150" alt="Top Instructor" class="rounded-circle mb-3" style="width: 150px; height: 150px; object-fit: cover;">
                    <h5 class="fw-bold text-dark">Santosh Parajuli</h5>
                    <p class="text-muted mb-1">Full Stack Development</p>
                    <p class="text-muted">15+ years experience in software development and teaching</p>
                    <span class="badge bg-dark text-white">Top Rated</span>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="py-5 bg-light">
    <div class="container">
        <h2 class="text-center fw-semibold mb-5">Meet Our Expert Instructors</h2>
        <div class="row g-4">
            <c:forEach var="i" begin="4" end="8">
                <div class="col-md-3">
                    <div class="card text-center border-0 shadow-sm h-100">
                        <img src="https://placebeard.it/120/120?image=${i}" class="card-img-top rounded-circle mx-auto mt-3" style="width: 120px; height: 120px; object-fit: cover;" alt="Instructor">
                        <div class="card-body">
                            <h6 class="fw-bold mb-0">
                                <c:choose>
                                    <c:when test="${i == 4}">Sujan Subedi</c:when>
                                    <c:when test="${i == 5}">Delish Khadka</c:when>
                                    <c:when test="${i == 6}">Sagar Tandan</c:when>
                                    <c:when test="${i == 7}">Romy Khatri</c:when>
                                    <c:when test="${i == 8}">Nikesh Regmi</c:when>
                                    <c:otherwise>Unknown Instructor</c:otherwise>
                                </c:choose>
                            </h6>
                            <p class="text-muted small mb-1">
                                <c:choose>
                                    <c:when test="${i == 4}">Web Development</c:when>
                                    <c:when test="${i == 5}">Data Science</c:when>
                                    <c:when test="${i == 6}">Digital Marketing</c:when>
                                    <c:when test="${i == 7}">Mobile App Development</c:when>
                                    <c:when test="${i == 8}">UI/UX Design</c:when>
                                    <c:otherwise>Unknown Specialty</c:otherwise>
                                </c:choose>
                            </p>
                            <p class="text-muted small">
                                <c:choose>
                                    <c:when test="${i == 4}">10+ years experience at Google and Amazon</c:when>
                                    <c:when test="${i == 5}">Former Lead Data Scientist at Netflix</c:when>
                                    <c:when test="${i == 6}">Marketing Director with 12 years experience</c:when>
                                    <c:when test="${i == 7}">iOS & Android expert, former Apple engineer</c:when>
                                    <c:when test="${i == 8}">Design specialist with expertise in user experience</c:when>
                                    <c:otherwise>Experienced Professional</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<section class="py-5 bg-white">
    <div class="container">
        <h2 class="text-center fw-semibold mb-5">Top Student</h2>
        <div class="row justify-content-center">
            <div class="col-md-6 text-center">
                <div class="p-4 border border-dark rounded-4 shadow-sm">
                    <img src="https://placebeard.it/150/150?image=4" alt="Top Student" class="rounded-circle mb-3" style="width: 150px; height: 150px; object-fit: cover;">
                    <h5 class="fw-bold text-dark">Vinay Koirala</h5>
                    <p class="text-muted mb-1">Full Stack Development</p>
                    <p class="text-muted">Exceptional student with outstanding project portfolio</p>
                    <span class="badge bg-dark text-white">Top Performer</span>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="testimonial-section py-5 bg-light">
    <div class="container">
        <h2 class="text-center fw-semibold mb-5">What Our Students Say</h2>
        <div class="row g-4">
            <c:forEach var="t" begin="8" end="10">
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm h-100 p-4 text-center">
                        <img src="https://placebeard.it/100/100?image=${t+10}" class="rounded-circle mx-auto mb-3" style="width: 100px; height: 100px; object-fit: cover;" alt="Student">
                        <p class="fst-italic text-muted">
                            <c:choose>
                                <c:when test="${t == 8}">"The Full-Stack Web Development course completely transformed my career. Within 3 months of completion, I landed my dream job as a developer."</c:when>
                                <c:when test="${t == 9}">"The instructors are incredibly knowledgeable and supportive. The course content is up-to-date with industry standards and practical examples."</c:when>
                                <c:when test="${t == 10}">"SkillForge provided me with practical skills that I could immediately apply to my job. The ROI on this education has been incredible."</c:when>
                                <c:otherwise>"Great experience with SkillForge."</c:otherwise>
                            </c:choose>
                        </p>
                        <h6 class="fw-bold mt-3">
                            <c:choose>
                                <c:when test="${t == 8}">Karan Pyakurel</c:when>
                                <c:when test="${t == 9}">Manil Neupane</c:when>
                                <c:when test="${t == 10}">Bikash Shrestha</c:when>
                                <c:otherwise>Anonymous Student</c:otherwise>
                            </c:choose>
                        </h6>
                        <p class="text-muted small">
                            <c:choose>
                                <c:when test="${t == 8}">Web Developer at TechCorp</c:when>
                                <c:when test="${t == 9}">Data Analyst at FinTech Solutions</c:when>
                                <c:when test="${t == 10}">Marketing Manager at Global Brands</c:when>
                                <c:otherwise>Professional</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<c:if test="${empty sessionScope.user}">
    <section class="cta-section py-5 bg-dark text-white text-center">
        <div class="container">
            <h2 class="fw-bold text-gradient">Ready to Start Your Learning Journey?</h2>
            <p class="lead mb-4">Join thousands of students who are already advancing their careers with SkillForge.</p>
            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-light btn-lg px-4">Join Now</a>
        </div>
    </section>
</c:if>

<c:if test="${not empty sessionScope.user}">
    <section class="cta-section py-5 bg-light text-center">
        <div class="container">
            <h2 class="fw-bold">Welcome Back!</h2>
            <p class="lead mb-4">Continue your learning journey with our latest courses and resources.</p>
            <c:choose>
                <c:when test="${sessionScope.userRole eq 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-dark btn-lg px-4">Go to Dashboard</a>
                </c:when>
                <c:when test="${sessionScope.userRole eq 'instructor'}">
                    <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-dark btn-lg px-4">Go to Dashboard</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-dark btn-lg px-4">Go to Dashboard</a>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</c:if>

<%@ include file="/common/footer.jsp" %>