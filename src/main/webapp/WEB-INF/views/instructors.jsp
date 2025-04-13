<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>

<!-- Hero Section -->
<section class="bg-light py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-4 mb-lg-0">
                <h1 class="display-5 fw-bold mb-3">Meet Our Expert Instructors</h1>
                <p class="lead mb-4">Learn from industry professionals with years of experience in their fields. Our instructors are passionate about sharing their knowledge and helping you succeed.</p>
                <div class="d-flex gap-2">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search instructors..." aria-label="Search instructors">
                        <button class="btn btn-primary" type="button"><i class="fas fa-search"></i></button>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 text-center">
                <img src="https://placedog.net/600/400?id=20" alt="Instructors" class="img-fluid rounded-4 shadow">
            </div>
        </div>
    </div>
</section>

<!-- Featured Instructor -->
<section class="py-5">
    <div class="container">
        <h2 class="text-center fw-bold mb-5">Featured Instructor</h2>
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="row g-0">
                        <div class="col-md-4 text-center py-4">
                            <img src="https://placedog.net/200/200?id=3" alt="Santosh Parajuli" class="rounded-circle img-fluid mb-3" style="width: 150px; height: 150px; object-fit: cover;">
                            <div class="d-flex justify-content-center gap-2 mb-3">
                                <a href="#" class="text-dark"><i class="fab fa-linkedin fa-lg"></i></a>
                                <a href="#" class="text-dark"><i class="fab fa-twitter fa-lg"></i></a>
                                <a href="#" class="text-dark"><i class="fab fa-github fa-lg"></i></a>
                            </div>
                            <div class="d-flex justify-content-center">
                                <span class="badge bg-primary me-2 px-3 py-2">Top Rated</span>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="card-body p-4">
                                <h3 class="fw-bold mb-2">Santosh Parajuli</h3>
                                <p class="text-muted mb-3">Full Stack Development Expert</p>
                                <div class="mb-3">
                                    <div class="d-flex align-items-center mb-2">
                                        <div class="text-warning me-2">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <span>4.9 Instructor Rating</span>
                                    </div>
                                    <div class="d-flex gap-4">
                                        <div>
                                            <i class="fas fa-user-graduate me-2"></i>
                                            <span>24,500+ Students</span>
                                        </div>
                                        <div>
                                            <i class="fas fa-book me-2"></i>
                                            <span>8 Courses</span>
                                        </div>
                                    </div>
                                </div>
                                <p>Santosh is a seasoned software engineer with over 15 years of experience in web development. He has worked with Fortune 500 companies and startups alike, helping them build scalable and robust web applications. His teaching approach focuses on practical, real-world applications of programming concepts.</p>
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
<section class="py-5 bg-light">
    <div class="container">
        <h2 class="text-center fw-bold mb-5">Browse by Expertise</h2>
        <div class="row g-4 justify-content-center">
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card border-0 shadow-sm h-100 text-center">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-primary bg-opacity-10 p-3 d-inline-flex mb-3">
                            <i class="fas fa-laptop-code text-primary fa-2x"></i>
                        </div>
                        <h5 class="fw-bold">Web Development</h5>
                        <p class="small text-muted mb-0">12 Instructors</p>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card border-0 shadow-sm h-100 text-center">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-success bg-opacity-10 p-3 d-inline-flex mb-3">
                            <i class="fas fa-mobile-alt text-success fa-2x"></i>
                        </div>
                        <h5 class="fw-bold">Mobile Apps</h5>
                        <p class="small text-muted mb-0">8 Instructors</p>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card border-0 shadow-sm h-100 text-center">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-info bg-opacity-10 p-3 d-inline-flex mb-3">
                            <i class="fas fa-database text-info fa-2x"></i>
                        </div>
                        <h5 class="fw-bold">Data Science</h5>
                        <p class="small text-muted mb-0">9 Instructors</p>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card border-0 shadow-sm h-100 text-center">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-warning bg-opacity-10 p-3 d-inline-flex mb-3">
                            <i class="fas fa-paint-brush text-warning fa-2x"></i>
                        </div>
                        <h5 class="fw-bold">UI/UX Design</h5>
                        <p class="small text-muted mb-0">7 Instructors</p>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card border-0 shadow-sm h-100 text-center">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-danger bg-opacity-10 p-3 d-inline-flex mb-3">
                            <i class="fas fa-shield-alt text-danger fa-2x"></i>
                        </div>
                        <h5 class="fw-bold">Cybersecurity</h5>
                        <p class="small text-muted mb-0">5 Instructors</p>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card border-0 shadow-sm h-100 text-center">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-secondary bg-opacity-10 p-3 d-inline-flex mb-3">
                            <i class="fas fa-robot text-secondary fa-2x"></i>
                        </div>
                        <h5 class="fw-bold">AI & ML</h5>
                        <p class="small text-muted mb-0">6 Instructors</p>
                    </div>
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
                        <img src="https://placedog.net/150/150?id=4" alt="Sujan Subedi" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
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
                        <img src="https://placedog.net/150/150?id=5" alt="Delish Khadka" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
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
                        <img src="https://placedog.net/150/150?id=6" alt="Sagar Tandan" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
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
                        <img src="https://placedog.net/150/150?id=7" alt="Romy Khatri" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
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
                        <img src="https://placedog.net/150/150?id=8" alt="Nikesh Regmi" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
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
                        <img src="https://placedog.net/150/150?id=9" alt="Anita Sharma" class="rounded-circle mb-3" style="width: 120px; height: 120px; object-fit: cover;">
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
                <img src="https://placedog.net/500/400?id=12" alt="Become an Instructor" class="img-fluid rounded-4 shadow">
            </div>
        </div>
    </div>
</section>

<%@ include file="/common/footer.jsp" %>
