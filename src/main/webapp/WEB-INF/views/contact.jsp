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
                    <p class="mb-0">Subidhanagar</p>
                    <p class="mb-0">Itahari - 08, Nepal</p>
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
                    <form>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="name" class="form-label">Your Name</label>
                                <input type="text" class="form-control" id="name" placeholder="Enter your name" required>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" placeholder="Enter your email" required>
                            </div>
                            <div class="col-12">
                                <label for="subject" class="form-label">Subject</label>
                                <input type="text" class="form-control" id="subject" placeholder="Enter subject">
                            </div>
                            <div class="col-12">
                                <label for="message" class="form-label">Message</label>
                                <textarea class="form-control" id="message" rows="5" placeholder="Enter your message" required></textarea>
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
            <div class="bg-light p-4 text-center">
                <h4 class="fw-bold mb-3">Our Location</h4>
                <p class="mb-0">This is where a Google Map would typically be embedded. For privacy and API key reasons, we're showing this placeholder instead.</p>
                <p class="mb-0">Enjoy this cute dog picture instead</p>
                <img src="https://avatar-placeholder.iran.liara.run/bg_3b82f6/SkillForge%20HQ/300x200" alt="SkillForge HQ" class="img-fluid mt-3">
            </div>
        </div>
    </div>
</section>

<%@ include file="/common/footer.jsp" %>