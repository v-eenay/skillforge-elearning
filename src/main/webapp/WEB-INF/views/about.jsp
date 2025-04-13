<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>

<section class="container py-5">
    <div class="row mb-5">
        <div class="col-lg-8 mx-auto text-center">
            <h1 class="display-5 fw-bold mb-4">About SkillForge</h1>
            <p class="lead">Empowering learners worldwide with cutting-edge skills and knowledge</p>
            <hr class="my-4 w-25 mx-auto">
        </div>
    </div>

    <div class="row align-items-center mb-5">
        <div class="col-md-6 mb-4 mb-md-0">
            <h2 class="fw-bold mb-3">Our Mission</h2>
            <p>At SkillForge, we believe that education should be accessible, engaging, and relevant to today's rapidly evolving job market. Our mission is to bridge the gap between traditional education and industry demands by providing high-quality, practical courses taught by industry experts.</p>
            <p>We are committed to helping individuals acquire the skills they need to advance their careers, pursue their passions, and adapt to technological changes in their fields.</p>
        </div>
        <div class="col-md-6 text-center">
            <img src="https://placebeard.it/500/300?image=5" alt="Our Mission" class="img-fluid rounded-4 shadow">
        </div>
    </div>

    <div class="row align-items-center mb-5 flex-md-row-reverse">
        <div class="col-md-6 mb-4 mb-md-0">
            <h2 class="fw-bold mb-3">Our Story</h2>
            <p>SkillForge was founded in 2023 by a group of educators and industry professionals who recognized the need for more practical, skills-focused education. What started as a small collection of programming courses has grown into a comprehensive platform offering hundreds of courses across various disciplines.</p>
            <p>Today, SkillForge serves thousands of learners worldwide, helping them achieve their personal and professional goals through quality education.</p>
        </div>
        <div class="col-md-6 text-center">
            <img src="https://placebeard.it/500/300?image=6" alt="Our Story" class="img-fluid rounded-4 shadow">
        </div>
    </div>

    <div class="row mb-5">
        <div class="col-12 text-center mb-4">
            <h2 class="fw-bold">Our Team</h2>
            <p class="lead">Meet the passionate individuals behind SkillForge</p>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow-sm h-100 text-center">
                <div class="card-body p-4">
                    <img src="https://placebeard.it/150/150?image=33" alt="Team Member" class="rounded-circle mb-3" style="width: 150px; height: 150px; object-fit: cover;">
                    <h5 class="fw-bold">Binaya Koirala</h5>
                    <p class="text-muted">Founder & CEO</p>
                    <p>Passionate about education technology and making quality learning accessible to everyone.</p>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow-sm h-100 text-center">
                <div class="card-body p-4">
                    <img src="https://placebeard.it/150/150?image=34" alt="Team Member" class="rounded-circle mb-3" style="width: 150px; height: 150px; object-fit: cover;">
                    <h5 class="fw-bold">Vinay Koirala</h5>
                    <p class="text-muted">Head of Content</p>
                    <p>Curriculum expert with over 10 years of experience in educational content development.</p>
                </div>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow-sm h-100 text-center">
                <div class="card-body p-4">
                    <img src="https://placebeard.it/150/150?image=35" alt="Team Member" class="rounded-circle mb-3" style="width: 150px; height: 150px; object-fit: cover;">
                    <h5 class="fw-bold">Binay Koirala</h5>
                    <p class="text-muted">Lead Developer</p>
                    <p>Tech enthusiast dedicated to creating seamless learning experiences through innovative solutions.</p>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${empty sessionScope.user}">
    <div class="row">
        <div class="col-lg-8 mx-auto text-center">
            <h2 class="fw-bold mb-4">Join Our Community</h2>
            <p class="mb-4">Become part of our growing community of learners and instructors. Together, we can forge the skills needed for tomorrow's challenges.</p>
            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary btn-lg px-4">Sign Up Today</a>
        </div>
    </div>
    </c:if>
</section>

<%@ include file="/common/footer.jsp" %>