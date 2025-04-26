<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>

<section class="modern-hero">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 col-md-7 mb-5 mb-md-0">
                <h1>Unlock Your Potential with SkillForge</h1>
                <p>SkillForge is your gateway to mastering modern skills, accelerating your career, and achieving your goals. Learn from expert instructors with cutting-edge content.</p>
                <a href="${pageContext.request.contextPath}/courses" class="btn btn-light btn-lg">
                    <i class="fas fa-graduation-cap me-2"></i> Explore Courses
                </a>
            </div>
            <div class="col-lg-6 col-md-5 text-center">
                <img src="${pageContext.request.contextPath}/assets/images/hero-image.svg" alt="Learning Platform" class="img-fluid hero-image">
            </div>
        </div>
    </div>
</section>

<section class="featured-courses">
    <div class="container">
        <h2>Featured Courses</h2>
        <p class="section-subtitle">Explore our most popular courses and start your learning journey today with industry-leading content.</p>
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="course-card">
                    <img src="https://placebeard.it/500/300" class="card-img-top" alt="Web Development Course">
                    <div class="card-body">
                        <div class="course-meta">
                            <span class="course-category">Web Development</span>
                            <div class="course-rating">
                                <i class="fas fa-star"></i>
                                <span>4.8 (2,345)</span>
                            </div>
                        </div>
                        <h5 class="card-title">Full-Stack Web Development</h5>
                        <p class="card-text">Master HTML, CSS, JavaScript, React, Node.js and more to become a complete web developer.</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="course-price">$89.99</span>
                            <a href="${pageContext.request.contextPath}/courses" class="btn btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="course-card">
                    <img src="https://placebeard.it/500/300?image=2" class="card-img-top" alt="Data Science Course">
                    <div class="card-body">
                        <div class="course-meta">
                            <span class="course-category">Data Science</span>
                            <div class="course-rating">
                                <i class="fas fa-star"></i>
                                <span>4.9 (1,120)</span>
                            </div>
                        </div>
                        <h5 class="card-title">Data Science & Analytics</h5>
                        <p class="card-text">Learn Python, R, SQL, and statistical analysis to extract insights from complex datasets.</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="course-price">$99.99</span>
                            <a href="${pageContext.request.contextPath}/courses" class="btn btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="course-card">
                    <img src="https://placebeard.it/500/300?image=3" class="card-img-top" alt="Digital Marketing Course">
                    <div class="card-body">
                        <div class="course-meta">
                            <span class="course-category">Marketing</span>
                            <div class="course-rating">
                                <i class="fas fa-star"></i>
                                <span>4.7 (3,210)</span>
                            </div>
                        </div>
                        <h5 class="card-title">Digital Marketing Mastery</h5>
                        <p class="card-text">Develop skills in SEO, social media marketing, content strategy, and PPC advertising.</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="course-price">$79.99</span>
                            <a href="${pageContext.request.contextPath}/courses" class="btn btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary view-all-btn">
                <i class="fas fa-th-list me-2"></i> View All Courses
            </a>
        </div>
    </div>
</section>

<section class="top-instructor">
    <div class="container">
        <h2>Top Instructor</h2>
        <p class="section-subtitle">Meet our highest-rated instructor who has helped thousands of students achieve their goals.</p>
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="instructor-profile">
                    <img src="https://placebeard.it/150/150" alt="Top Instructor">
                    <h5>Santosh Parajuli</h5>
                    <p class="instructor-specialty">Full Stack Development</p>
                    <p class="instructor-bio">15+ years experience in software development and teaching. Former senior developer at Google and Amazon with a passion for helping students master complex concepts.</p>
                    <span class="badge">Top Rated</span>
                    <div class="social-links">
                        <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-github"></i></a>
                        <a href="#" class="social-link"><i class="fas fa-globe"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="instructors-grid">
    <div class="container">
        <h2>Meet Our Expert Instructors</h2>
        <p class="section-subtitle">Learn from industry professionals with years of experience in their respective fields.</p>
        <div class="row g-4">
            <c:forEach var="i" begin="4" end="8">
                <div class="col-lg-3 col-md-6">
                    <div class="instructor-card">
                        <img src="https://placebeard.it/120/120?image=${i}" alt="Instructor">
                        <div class="card-body">
                            <h5 class="card-title">
                                <c:choose>
                                    <c:when test="${i == 4}">Sujan Subedi</c:when>
                                    <c:when test="${i == 5}">Delish Khadka</c:when>
                                    <c:when test="${i == 6}">Sagar Tandan</c:when>
                                    <c:when test="${i == 7}">Romy Khatri</c:when>
                                    <c:when test="${i == 8}">Nikesh Regmi</c:when>
                                    <c:otherwise>Unknown Instructor</c:otherwise>
                                </c:choose>
                            </h5>
                            <p class="instructor-specialty">
                                <c:choose>
                                    <c:when test="${i == 4}">Web Development</c:when>
                                    <c:when test="${i == 5}">Data Science</c:when>
                                    <c:when test="${i == 6}">Digital Marketing</c:when>
                                    <c:when test="${i == 7}">Mobile App Development</c:when>
                                    <c:when test="${i == 8}">UI/UX Design</c:when>
                                    <c:otherwise>Unknown Specialty</c:otherwise>
                                </c:choose>
                            </p>
                            <p class="instructor-bio">
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

<section class="top-student">
    <div class="container">
        <h2>Top Student</h2>
        <p class="section-subtitle">Meet our highest-achieving student who has demonstrated exceptional skills and dedication.</p>
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="student-profile">
                    <img src="https://placebeard.it/150/150?image=4" alt="Top Student">
                    <h5>Vinay Koirala</h5>
                    <p class="student-specialty">Full Stack Development</p>
                    <p class="student-bio">Exceptional student with outstanding project portfolio. Completed 15 courses with perfect scores and built several production-ready applications that showcase advanced skills.</p>
                    <span class="badge">Top Performer</span>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="testimonials">
    <div class="container">
        <h2>What Our Students Say</h2>
        <p class="section-subtitle">Hear from our students about how SkillForge has helped them achieve their career goals.</p>
        <div class="row g-4">
            <c:forEach var="t" begin="8" end="10">
                <div class="col-lg-4 col-md-6">
                    <div class="testimonial-card">
                        <img src="https://placebeard.it/100/100?image=${t+10}" alt="Student">
                        <p class="testimonial-text">
                            <c:choose>
                                <c:when test="${t == 8}">"The Full-Stack Web Development course completely transformed my career. Within 3 months of completion, I landed my dream job as a developer."</c:when>
                                <c:when test="${t == 9}">"The instructors are incredibly knowledgeable and supportive. The course content is up-to-date with industry standards and practical examples."</c:when>
                                <c:when test="${t == 10}">"SkillForge provided me with practical skills that I could immediately apply to my job. The ROI on this education has been incredible."</c:when>
                                <c:otherwise>"Great experience with SkillForge."</c:otherwise>
                            </c:choose>
                        </p>
                        <h6 class="testimonial-author">
                            <c:choose>
                                <c:when test="${t == 8}">Karan Pyakurel</c:when>
                                <c:when test="${t == 9}">Manil Neupane</c:when>
                                <c:when test="${t == 10}">Bikash Shrestha</c:when>
                                <c:otherwise>Anonymous Student</c:otherwise>
                            </c:choose>
                        </h6>
                        <p class="testimonial-role">
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
    <section class="modern-cta">
        <div class="container">
            <h2>Ready to Start Your Learning Journey?</h2>
            <p>Join thousands of students who are already advancing their careers with SkillForge.</p>
            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-light btn-lg">
                <i class="fas fa-user-plus me-2"></i> Join Now
            </a>
        </div>
    </section>
</c:if>

<c:if test="${not empty sessionScope.user}">
    <section class="modern-cta">
        <div class="container">
            <h2>Welcome Back!</h2>
            <p>Continue your learning journey with our latest courses and resources.</p>
            <c:choose>
                <c:when test="${sessionScope.userRole eq 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-light btn-lg">
                        <i class="fas fa-tachometer-alt me-2"></i> Go to Dashboard
                    </a>
                </c:when>
                <c:when test="${sessionScope.userRole eq 'instructor'}">
                    <a href="${pageContext.request.contextPath}/instructor/dashboard" class="btn btn-light btn-lg">
                        <i class="fas fa-chalkboard-teacher me-2"></i> Go to Dashboard
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-light btn-lg">
                        <i class="fas fa-graduation-cap me-2"></i> Go to Dashboard
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</c:if>

<%@ include file="/common/footer.jsp" %>