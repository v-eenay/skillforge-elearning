<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>

<%-- Link modern CSS --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern-instructors.css">

<!-- Modern Hero Section -->
<section class="modern-hero instructors-hero">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 col-md-7 mb-5 mb-md-0">
                <h1 class="animate__animated animate__fadeInUp">Meet Our Expert Instructors</h1>
                <p class="animate__animated animate__fadeInUp animate__delay-1s">Learn from industry professionals with years of experience in their fields. Our instructors are passionate about sharing their knowledge and helping you succeed.</p>
                <%-- Modern Search Bar --%>
                <form action="${pageContext.request.contextPath}/instructors" method="get" class="search-container input-group mt-4 animate__animated animate__fadeInUp animate__delay-2s">
                    <span class="input-group-text bg-white border-0"><i class="fas fa-search text-primary"></i></span>
                    <input type="text" name="search" class="form-control form-control-lg border-0" placeholder="Search instructors..." value="${searchTerm}">
                    <button class="btn btn-primary" type="submit">Search</button>
                </form>
            </div>
            <div class="col-lg-6 col-md-5 text-center animate__animated animate__fadeInRight animate__delay-1s">
                <%-- Use a relevant SVG or image --%>
                <img src="${pageContext.request.contextPath}/assets/images/hero-image.svg" alt="Instructors" class="img-fluid hero-image rounded-4 shadow-lg">
            </div>
        </div>
    </div>
</section>

<!-- Featured Instructor -->
<section class="featured-instructor">
    <div class="container">
        <h2>Featured Instructor</h2>
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="featured-instructor-card">
                    <div class="row g-0">
                        <div class="col-md-4 instructor-image-container">
                            <img src="https://placebeard.it/150/150?image=25" alt="Santosh Parajuli" class="instructor-image">
                            <div class="social-links">
                                <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                                <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                                <a href="#" class="social-link"><i class="fab fa-github"></i></a>
                                <a href="#" class="social-link"><i class="fas fa-globe"></i></a>
                            </div>
                            <div class="mt-3">
                                <span class="instructor-badge">Top Rated</span>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="card-body">
                                <h3 class="instructor-name">Santosh Parajuli</h3>
                                <p class="instructor-title">Full Stack Development Expert</p>
                                <div class="instructor-rating">
                                    <div class="rating-stars">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <span>4.9 Instructor Rating</span>
                                </div>
                                <div class="instructor-stats">
                                    <div>
                                        <i class="fas fa-user-graduate me-2"></i>
                                        <span>24,500+ Students</span>
                                    </div>
                                    <div>
                                        <i class="fas fa-book me-2"></i>
                                        <span>8 Courses</span>
                                    </div>
                                </div>
                                <p class="instructor-bio">Santosh is a seasoned software engineer with over 15 years of experience in web development. He has worked with Fortune 500 companies and startups alike, helping them build scalable and robust web applications. His teaching approach focuses on practical, real-world applications of programming concepts.</p>
                                <a href="#" class="btn btn-primary">View Courses</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Instructor Categories -->
<section class="instructor-categories">
    <div class="container">
        <h2>Browse by Expertise</h2>
        <div class="row g-4 justify-content-center">
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card web-dev">
                    <div class="category-icon">
                        <i class="fas fa-laptop-code"></i>
                    </div>
                    <h5>Web Development</h5>
                    <p>12 Instructors</p>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card mobile-dev">
                    <div class="category-icon">
                        <i class="fas fa-mobile-alt"></i>
                    </div>
                    <h5>Mobile Apps</h5>
                    <p>8 Instructors</p>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card data-science">
                    <div class="category-icon">
                        <i class="fas fa-database"></i>
                    </div>
                    <h5>Data Science</h5>
                    <p>9 Instructors</p>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card design">
                    <div class="category-icon">
                        <i class="fas fa-paint-brush"></i>
                    </div>
                    <h5>UI/UX Design</h5>
                    <p>7 Instructors</p>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card security">
                    <div class="category-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h5>Cybersecurity</h5>
                    <p>5 Instructors</p>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="category-card business">
                    <div class="category-icon">
                        <i class="fas fa-robot"></i>
                    </div>
                    <h5>AI & ML</h5>
                    <p>6 Instructors</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- All Instructors -->
<section class="py-5">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold mb-0">Our Instructors</h2>
            <div class="dropdown">
                <button class="btn btn-outline-primary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    Sort by: Rating
                </button>
                <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                    <li><a class="dropdown-item" href="#">Rating</a></li>
                    <li><a class="dropdown-item" href="#">Popularity</a></li>
                    <li><a class="dropdown-item" href="#">Courses Count</a></li>
                    <li><a class="dropdown-item" href="#">Students Count</a></li>
                </ul>
            </div>
        </div>
        <div class="row g-4">
            <!-- Instructor 1 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body p-4 text-center">
                        <img src="https://placebeard.it/120/120?image=26" alt="Sujan Subedi" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
                        <h4 class="fw-bold mb-1">Sujan Subedi</h4>
                        <p class="text-muted mb-3">Data Science Expert</p>
                        <div class="d-flex justify-content-center mb-3">
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                                <span class="ms-1 text-dark">4.7</span>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center gap-3 mb-3">
                            <div>
                                <i class="fas fa-user-graduate me-1"></i>
                                <span>18,200</span>
                            </div>
                            <div>
                                <i class="fas fa-book me-1"></i>
                                <span>6</span>
                            </div>
                        </div>
                        <p class="mb-3">Data scientist with expertise in Python, R, and machine learning. Specializes in predictive analytics and data visualization.</p>
                        <div class="d-flex justify-content-center gap-2 mb-3">
                            <a href="#" class="text-dark"><i class="fab fa-linkedin"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-github"></i></a>
                        </div>
                        <a href="#" class="btn btn-outline-primary">View Profile</a>
                    </div>
                </div>
            </div>

            <!-- Instructor 2 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body p-4 text-center">
                        <img src="https://placebeard.it/120/120?image=27" alt="Delish Khadka" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
                        <h4 class="fw-bold mb-1">Delish Khadka</h4>
                        <p class="text-muted mb-3">UI/UX Design Specialist</p>
                        <div class="d-flex justify-content-center mb-3">
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <span class="ms-1 text-dark">4.9</span>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center gap-3 mb-3">
                            <div>
                                <i class="fas fa-user-graduate me-1"></i>
                                <span>15,800</span>
                            </div>
                            <div>
                                <i class="fas fa-book me-1"></i>
                                <span>5</span>
                            </div>
                        </div>
                        <p class="mb-3">Award-winning UI/UX designer with a background in psychology. Creates user-centered designs that are both beautiful and functional.</p>
                        <div class="d-flex justify-content-center gap-2 mb-3">
                            <a href="#" class="text-dark"><i class="fab fa-linkedin"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-dribbble"></i></a>
                        </div>
                        <a href="#" class="btn btn-outline-primary">View Profile</a>
                    </div>
                </div>
            </div>

            <!-- Instructor 3 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body p-4 text-center">
                        <img src="https://placebeard.it/120/120?image=28" alt="Sagar Tandan" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
                        <h4 class="fw-bold mb-1">Sagar Tandan</h4>
                        <p class="text-muted mb-3">Mobile Development Expert</p>
                        <div class="d-flex justify-content-center mb-3">
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <span class="ms-1 text-dark">4.8</span>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center gap-3 mb-3">
                            <div>
                                <i class="fas fa-user-graduate me-1"></i>
                                <span>14,500</span>
                            </div>
                            <div>
                                <i class="fas fa-book me-1"></i>
                                <span>7</span>
                            </div>
                        </div>
                        <p class="mb-3">Mobile app developer with expertise in Flutter, React Native, and native iOS/Android development. Has published over 20 apps.</p>
                        <div class="d-flex justify-content-center gap-2 mb-3">
                            <a href="#" class="text-dark"><i class="fab fa-linkedin"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-github"></i></a>
                        </div>
                        <a href="#" class="btn btn-outline-primary">View Profile</a>
                    </div>
                </div>
            </div>

            <!-- Instructor 4 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body p-4 text-center">
                        <img src="https://placebeard.it/120/120?image=29" alt="Romy Khatri" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
                        <h4 class="fw-bold mb-1">Romy Khatri</h4>
                        <p class="text-muted mb-3">Cybersecurity Specialist</p>
                        <div class="d-flex justify-content-center mb-3">
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                                <span class="ms-1 text-dark">4.6</span>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center gap-3 mb-3">
                            <div>
                                <i class="fas fa-user-graduate me-1"></i>
                                <span>12,300</span>
                            </div>
                            <div>
                                <i class="fas fa-book me-1"></i>
                                <span>4</span>
                            </div>
                        </div>
                        <p class="mb-3">Certified ethical hacker and cybersecurity consultant. Has helped secure systems for government agencies and Fortune 500 companies.</p>
                        <div class="d-flex justify-content-center gap-2 mb-3">
                            <a href="#" class="text-dark"><i class="fab fa-linkedin"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-medium"></i></a>
                        </div>
                        <a href="#" class="btn btn-outline-primary">View Profile</a>
                    </div>
                </div>
            </div>

            <!-- Instructor 5 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body p-4 text-center">
                        <img src="https://placebeard.it/120/120?image=30" alt="Nikesh Regmi" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
                        <h4 class="fw-bold mb-1">Nikesh Regmi</h4>
                        <p class="text-muted mb-3">AI & Machine Learning Expert</p>
                        <div class="d-flex justify-content-center mb-3">
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <span class="ms-1 text-dark">4.8</span>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center gap-3 mb-3">
                            <div>
                                <i class="fas fa-user-graduate me-1"></i>
                                <span>13,700</span>
                            </div>
                            <div>
                                <i class="fas fa-book me-1"></i>
                                <span>5</span>
                            </div>
                        </div>
                        <p class="mb-3">AI researcher and practitioner with expertise in deep learning, computer vision, and natural language processing.</p>
                        <div class="d-flex justify-content-center gap-2 mb-3">
                            <a href="#" class="text-dark"><i class="fab fa-linkedin"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-github"></i></a>
                        </div>
                        <a href="#" class="btn btn-outline-primary">View Profile</a>
                    </div>
                </div>
            </div>

            <!-- Instructor 6 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body p-4 text-center">
                        <img src="https://placebeard.it/120/120?image=31" alt="Anita Sharma" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
                        <h4 class="fw-bold mb-1">Anita Sharma</h4>
                        <p class="text-muted mb-3">Frontend Development Specialist</p>
                        <div class="d-flex justify-content-center mb-3">
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                                <span class="ms-1 text-dark">4.7</span>
                            </div>
                        </div>
                        <div class="d-flex justify-content-center gap-3 mb-3">
                            <div>
                                <i class="fas fa-user-graduate me-1"></i>
                                <span>11,900</span>
                            </div>
                            <div>
                                <i class="fas fa-book me-1"></i>
                                <span>4</span>
                            </div>
                        </div>
                        <p class="mb-3">Frontend developer with expertise in React, Vue, and Angular. Creates beautiful, responsive, and accessible web interfaces.</p>
                        <div class="d-flex justify-content-center gap-2 mb-3">
                            <a href="#" class="text-dark"><i class="fab fa-linkedin"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-dark"><i class="fab fa-codepen"></i></a>
                        </div>
                        <a href="#" class="btn btn-outline-primary">View Profile</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <div class="d-flex justify-content-center mt-5">
            <nav aria-label="Instructor pagination">
                <ul class="pagination">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</section>

<!-- Become an Instructor -->
<section class="py-5 bg-primary text-white">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-7 mb-4 mb-lg-0">
                <h2 class="fw-bold mb-3">Become an Instructor</h2>
                <p class="lead mb-4">Join our community of expert instructors and share your knowledge with students around the world. Create engaging courses and help others achieve their goals.</p>
                <ul class="list-unstyled mb-4">
                    <li class="mb-2"><i class="fas fa-check-circle me-2"></i> Reach thousands of students globally</li>
                    <li class="mb-2"><i class="fas fa-check-circle me-2"></i> Earn revenue from course sales</li>
                    <li class="mb-2"><i class="fas fa-check-circle me-2"></i> Access professional course creation tools</li>
                    <li><i class="fas fa-check-circle me-2"></i> Join a supportive community of educators</li>
                </ul>
                <a href="#" class="btn btn-light btn-lg px-4">Apply to Teach</a>
            </div>
            <div class="col-lg-5 text-center">
                <img src="https://placebeard.it/500/400?image=32" alt="Become an Instructor" class="img-fluid rounded-4 shadow">
            </div>
        </div>
    </div>
</section>

<%@ include file="/common/footer.jsp" %>
