<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>

<section class="contact-hero">
    <div class="container">
        <h1>Contact Us</h1>
        <p>We'd love to hear from you! Get in touch with our team for any questions or feedback.</p>
        <div class="divider"></div>
    </div>
</section>

<section class="contact-form-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="contact-form-card">
                    <h2>Send Us a Message</h2>
                    <p>Have questions about our courses, platform, or need technical support? Our team is here to help you with anything you need.</p>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i> ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/contact" class="contact-form">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <label for="name" class="form-label">Your Name</label>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <input type="text" class="form-control" id="name" name="name" value="${sessionScope.user.name}" readonly>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email Address</label>
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <input type="email" class="form-control" id="email" name="email" value="${sessionScope.user.email}" readonly>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-12">
                                <label for="subject" class="form-label">Subject</label>
                                <input type="text" class="form-control" id="subject" name="subject" placeholder="Enter subject">
                            </div>
                            <div class="col-12">
                                <label for="message" class="form-label">Message</label>
                                <textarea class="form-control" id="message" name="message" rows="5" placeholder="Enter your message" required></textarea>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-paper-plane me-2"></i> Send Message
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="contact-info-section">
    <div class="container">
        <h2>Get In Touch</h2>
        <p>Connect with us through any of these channels. We're here to help!</p>

        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="contact-info-card">
                    <div class="info-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <h5>Email Us</h5>
                    <p><a href="mailto:koiralavinay@gmail.com">koiralavinay@gmail.com</a></p>
                    <p><a href="mailto:binaya.koirala@iic.edu.np">binaya.koirala@iic.edu.np</a></p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="contact-info-card">
                    <div class="info-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <h5>Visit Us</h5>
                    <p>Itahari International College<br>
                    M842+5Q8 Sundar, Dulari Sadak<br>
                    Koshi Haraicha 56705, Nepal</p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="contact-info-card">
                    <div class="info-icon">
                        <i class="fas fa-phone"></i>
                    </div>
                    <h5>Call Us</h5>
                    <p>+977 9800000000</p>
                    <div class="social-links mt-4">
                        <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="map-section">
    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3571.5600766694!2d87.2833387!3d26.4649999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39ef744e6b3e9c8d%3A0x5c0f179e6d14d2e8!2sItahari%20International%20College!5e0!3m2!1sen!2sus!4v1718193000000!5m2!1sen!2sus"
            allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
</section>

<%@ include file="/common/footer.jsp" %>