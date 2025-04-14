<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>

<section class="container py-5">
    <div class="row mb-5">
        <div class="col-lg-8 mx-auto text-center">
            <h1 class="display-5 fw-bold mb-4">Contact Us</h1>
            <p class="lead">We'd love to hear from you! Get in touch with our team for any questions or feedback.</p>
            <hr class="my-4 w-25 mx-auto">
        </div>
    </div>

    <div class="row">
        <div class="col-lg-5 mb-5 mb-lg-0">
            <h2 class="fw-bold mb-4">Get In Touch</h2>
            <p class="mb-4">Have questions about our courses, platform, or need technical support? Our team is here to help you with anything you need.</p>

            <div class="d-flex align-items-start mb-3">
                <div class="bg-light p-3 rounded-circle me-3">
                    <i class="fas fa-envelope"></i>
                </div>
                <div>
                    <h5 class="fw-bold">Email Us</h5>
                    <p class="mb-0"><a href="mailto:koiralavinay@gmail.com" class="text-decoration-none">koiralavinay@gmail.com</a></p>
                    <p class="mb-0"><a href="mailto:binaya.koirala@iic.edu.np" class="text-decoration-none">binaya.koirala@iic.edu.np</a></p>
                </div>
            </div>

            <div class="d-flex align-items-start mb-3">
                <div class="bg-light p-3 rounded-circle me-3">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <div>
                    <h5 class="fw-bold">Visit Us</h5>
                    <p class="mb-0">Itahari International College</p>
                    <p class="mb-0">M842+5Q8 Sundar, Dulari Sadak</p>
                    <p class="mb-0">Koshi Haraicha 56705, Nepal</p>
                </div>
            </div>

            <div class="d-flex align-items-start mb-4">
                <div class="bg-light p-3 rounded-circle me-3">
                    <i class="fas fa-phone"></i>
                </div>
                <div>
                    <h5 class="fw-bold">Call Us</h5>
                    <p class="mb-0">+977 9800000000</p>
                </div>
            </div>

            <h4 class="fw-bold mb-3">Connect With Us</h4>
            <div class="d-flex">
                <a href="#" class="btn btn-outline-dark btn-sm rounded-circle me-2"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="btn btn-outline-dark btn-sm rounded-circle me-2"><i class="fab fa-twitter"></i></a>
                <a href="#" class="btn btn-outline-dark btn-sm rounded-circle me-2"><i class="fab fa-instagram"></i></a>
                <a href="#" class="btn btn-outline-dark btn-sm rounded-circle"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-4">
                    <h2 class="fw-bold mb-4">Send Us a Message</h2>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/contact">
                        <div class="row g-3">
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
                                <button type="submit" class="btn btn-primary btn-lg">Send Message</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Map Section -->
<section class="container-fluid px-0 mb-5">
    <div class="row">
        <div class="col-12">
            <div class="p-0">
                <h4 class="fw-bold mb-3 text-center">Our Location</h4>
                <p class="mb-0 text-center">Itahari International College, M842+5Q8 Sundar, Dulari Sadak, Koshi Haraicha 56705</p>
                <p class="mb-0 text-center mb-3">इटहरी अन्तर्राष्ट्रिय कलेज</p>
                <div class="map-responsive">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3571.5600766694!2d87.2833387!3d26.4649999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39ef744e6b3e9c8d%3A0x5c0f179e6d14d2e8!2sItahari%20International%20College!5e0!3m2!1sen!2sus!4v1718193000000!5m2!1sen!2sus"
                            width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
            </div>
        </div>
    </div>
</section>

<style>
    .map-responsive {
        overflow: hidden;
        padding-bottom: 400px;
        position: relative;
        height: 0;
    }
    .map-responsive iframe {
        left: 0;
        top: 0;
        height: 100%;
        width: 100%;
        position: absolute;
    }
</style>

<%@ include file="/common/footer.jsp" %>