<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>

<section class="about-hero">
    <div class="container">
        <h1>About SkillForge</h1>
        <p>Empowering learners worldwide with cutting-edge skills and knowledge</p>
        <div class="divider"></div>
    </div>
</section>

<section class="about-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 col-md-6 mb-5 mb-md-0">
                <h2>Our Mission</h2>
                <p>At SkillForge, we believe that education should be accessible, engaging, and relevant to today's rapidly evolving job market. Our mission is to bridge the gap between traditional education and industry demands by providing high-quality, practical courses taught by industry experts.</p>
                <p>We are committed to helping individuals acquire the skills they need to advance their careers, pursue their passions, and adapt to technological changes in their fields.</p>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="section-image">
                    <img src="https://placebeard.it/600/400?image=5" alt="Our Mission" class="img-fluid">
                </div>
            </div>
        </div>
    </div>
</section>

<section class="about-section bg-white">
    <div class="container">
        <div class="row align-items-center flex-md-row-reverse">
            <div class="col-lg-6 col-md-6 mb-5 mb-md-0">
                <h2>Our Story</h2>
                <p>SkillForge was founded in 2023 by a group of educators and industry professionals who recognized the need for more practical, skills-focused education. What started as a small collection of programming courses has grown into a comprehensive platform offering hundreds of courses across various disciplines.</p>
                <p>Today, SkillForge serves thousands of learners worldwide, helping them achieve their personal and professional goals through quality education.</p>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="section-image right">
                    <img src="https://placebeard.it/600/400?image=6" alt="Our Story" class="img-fluid">
                </div>
            </div>
        </div>
    </div>
</section>

<section class="team-section">
    <div class="container">
        <h2>Our Team</h2>
        <p class="section-subtitle">Meet the passionate individuals behind SkillForge who are dedicated to transforming education</p>

        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="team-card">
                    <img src="https://placebeard.it/150/150?image=33" alt="Team Member">
                    <div class="card-body">
                        <h5 class="card-title">Binaya Koirala</h5>
                        <p class="team-role">Founder & CEO</p>
                        <p class="team-bio">Passionate about education technology and making quality learning accessible to everyone. With over 15 years of experience in the education sector, Binaya leads our vision and strategy.</p>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="social-link"><i class="fas fa-globe"></i></a>
                            <a href="#" class="social-link"><i class="fas fa-envelope"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="team-card">
                    <img src="https://placebeard.it/150/150?image=34" alt="Team Member">
                    <div class="card-body">
                        <h5 class="card-title">Vinay Koirala</h5>
                        <p class="team-role">Head of Content</p>
                        <p class="team-bio">Curriculum expert with over 10 years of experience in educational content development. Vinay ensures our courses meet the highest standards of quality and relevance.</p>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="social-link"><i class="fas fa-globe"></i></a>
                            <a href="#" class="social-link"><i class="fas fa-envelope"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="team-card">
                    <img src="https://placebeard.it/150/150?image=35" alt="Team Member">
                    <div class="card-body">
                        <h5 class="card-title">Binay Koirala</h5>
                        <p class="team-role">Lead Developer</p>
                        <p class="team-bio">Tech enthusiast dedicated to creating seamless learning experiences through innovative solutions. Binay leads our development team in building and improving our platform.</p>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-github"></i></a>
                            <a href="#" class="social-link"><i class="fas fa-globe"></i></a>
                            <a href="#" class="social-link"><i class="fas fa-envelope"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<c:if test="${empty sessionScope.user}">
<section class="about-cta">
    <div class="container">
        <h2>Join Our Community</h2>
        <p>Become part of our growing community of learners and instructors. Together, we can forge the skills needed for tomorrow's challenges.</p>
        <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-light btn-lg">
            <i class="fas fa-user-plus me-2"></i> Sign Up Today
        </a>
    </div>
</section>
</c:if>

<%@ include file="/common/footer.jsp" %>