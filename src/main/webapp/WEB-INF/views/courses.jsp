<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>

<!-- Hero Section -->
<section class="bg-light py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-4 mb-lg-0">
                <h1 class="display-5 fw-bold mb-3">Explore Our Courses</h1>
                <p class="lead mb-4">Discover a wide range of courses designed to help you master new skills, advance your career, and achieve your goals.</p>
                <div class="d-flex gap-2">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search courses..." aria-label="Search courses">
                        <button class="btn btn-primary" type="button"><i class="fas fa-search"></i></button>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 text-center">
                <img src="https://avatar-placeholder.iran.liara.run/bg_4f46e5/Courses/600x400" alt="Courses" class="img-fluid rounded-4 shadow">
            </div>
        </div>
    </div>
</section>

<!-- Course Categories -->
<section class="py-5">
    <div class="container">
        <h2 class="text-center fw-bold mb-5">Browse by Category</h2>
        <div class="row g-4 justify-content-center">
            <div class="col-6 col-md-4 col-lg-2">
                <div class="card border-0 shadow-sm h-100 text-center">
                    <div class="card-body p-4">
                        <div class="rounded-circle bg-primary bg-opacity-10 p-3 d-inline-flex mb-3">
                            <i class="fas fa-laptop-code text-primary fa-2x"></i>
                        </div>
                        <h5 class="fw-bold">Web Development</h5>
                        <p class="small text-muted mb-0">24 Courses</p>
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
                        <p class="small text-muted mb-0">18 Courses</p>
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
                        <p class="small text-muted mb-0">16 Courses</p>
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
                        <p class="small text-muted mb-0">12 Courses</p>
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
                        <p class="small text-muted mb-0">9 Courses</p>
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
                        <p class="small text-muted mb-0">14 Courses</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Featured Courses -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold mb-0">Featured Courses</h2>
            <div class="dropdown">
                <button class="btn btn-outline-primary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    Sort by: Popular
                </button>
                <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                    <li><a class="dropdown-item" href="#">Popular</a></li>
                    <li><a class="dropdown-item" href="#">Newest</a></li>
                    <li><a class="dropdown-item" href="#">Price: Low to High</a></li>
                    <li><a class="dropdown-item" href="#">Price: High to Low</a></li>
                    <li><a class="dropdown-item" href="#">Rating</a></li>
                </ul>
            </div>
        </div>
        <div class="row g-4">
            <!-- Course 1 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="position-relative">
                        <img src="https://avatar-placeholder.iran.liara.run/bg_4f46e5/Web%20Dev/500x300" class="card-img-top" alt="Web Development Course">
                        <span class="badge bg-primary position-absolute top-0 end-0 m-3">Bestseller</span>
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-light text-dark">Web Development</span>
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <span class="ms-1">4.9 (2,405)</span>
                            </div>
                        </div>
                        <h5 class="fw-bold mb-3">Full-Stack Web Development Bootcamp</h5>
                        <p class="text-muted">Master HTML, CSS, JavaScript, React, Node.js and more to become a complete web developer.</p>
                        <div class="d-flex align-items-center mb-3">
                            <img src="https://avatar-placeholder.iran.liara.run/boy?username=Santosh" class="rounded-circle me-2" style="width: 40px; height: 40px;" alt="Instructor">
                            <span>Santosh Parajuli</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold fs-5">$89.99</span>
                                <span class="text-muted text-decoration-line-through ms-2">$129.99</span>
                            </div>
                            <a href="#" class="btn btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Course 2 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="position-relative">
                        <img src="https://avatar-placeholder.iran.liara.run/bg_10b981/Data%20Science/500x300" class="card-img-top" alt="Data Science Course">
                        <span class="badge bg-success position-absolute top-0 end-0 m-3">New</span>
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-light text-dark">Data Science</span>
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <span class="ms-1">4.7 (1,208)</span>
                            </div>
                        </div>
                        <h5 class="fw-bold mb-3">Data Science & Analytics Masterclass</h5>
                        <p class="text-muted">Learn Python, R, SQL, and statistical analysis to extract insights from complex datasets.</p>
                        <div class="d-flex align-items-center mb-3">
                            <img src="https://avatar-placeholder.iran.liara.run/boy?username=Sujan" class="rounded-circle me-2" style="width: 40px; height: 40px;" alt="Instructor">
                            <span>Sujan Subedi</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold fs-5">$99.99</span>
                                <span class="text-muted text-decoration-line-through ms-2">$149.99</span>
                            </div>
                            <a href="#" class="btn btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Course 3 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="position-relative">
                        <img src="https://avatar-placeholder.iran.liara.run/bg_f59e0b/UI%20UX/500x300" class="card-img-top" alt="UI/UX Design Course">
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-light text-dark">UI/UX Design</span>
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <span class="ms-1">4.8 (956)</span>
                            </div>
                        </div>
                        <h5 class="fw-bold mb-3">UI/UX Design: From Beginner to Professional</h5>
                        <p class="text-muted">Learn to create beautiful, user-friendly interfaces that engage and delight users.</p>
                        <div class="d-flex align-items-center mb-3">
                            <img src="https://avatar-placeholder.iran.liara.run/boy?username=Delish" class="rounded-circle me-2" style="width: 40px; height: 40px;" alt="Instructor">
                            <span>Delish Khadka</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold fs-5">$79.99</span>
                                <span class="text-muted text-decoration-line-through ms-2">$119.99</span>
                            </div>
                            <a href="#" class="btn btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Course 4 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="position-relative">
                        <img src="https://avatar-placeholder.iran.liara.run/bg_6366f1/Mobile%20Dev/500x300" class="card-img-top" alt="Mobile Development Course">
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-light text-dark">Mobile Development</span>
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <span class="ms-1">4.6 (782)</span>
                            </div>
                        </div>
                        <h5 class="fw-bold mb-3">Flutter & Dart: Build iOS and Android Apps</h5>
                        <p class="text-muted">Create beautiful, natively compiled applications for mobile from a single codebase.</p>
                        <div class="d-flex align-items-center mb-3">
                            <img src="https://avatar-placeholder.iran.liara.run/boy?username=Sagar" class="rounded-circle me-2" style="width: 40px; height: 40px;" alt="Instructor">
                            <span>Sagar Tandan</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold fs-5">$94.99</span>
                                <span class="text-muted text-decoration-line-through ms-2">$139.99</span>
                            </div>
                            <a href="#" class="btn btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Course 5 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="position-relative">
                        <img src="https://avatar-placeholder.iran.liara.run/bg_ef4444/Security/500x300" class="card-img-top" alt="Cybersecurity Course">
                        <span class="badge bg-danger position-absolute top-0 end-0 m-3">Hot</span>
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-light text-dark">Cybersecurity</span>
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <span class="ms-1">4.9 (605)</span>
                            </div>
                        </div>
                        <h5 class="fw-bold mb-3">Ethical Hacking & Cybersecurity Fundamentals</h5>
                        <p class="text-muted">Learn to protect systems and networks from cyber threats and vulnerabilities.</p>
                        <div class="d-flex align-items-center mb-3">
                            <img src="https://avatar-placeholder.iran.liara.run/boy?username=Romy" class="rounded-circle me-2" style="width: 40px; height: 40px;" alt="Instructor">
                            <span>Romy Khatri</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold fs-5">$109.99</span>
                                <span class="text-muted text-decoration-line-through ms-2">$159.99</span>
                            </div>
                            <a href="#" class="btn btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Course 6 -->
            <div class="col-md-6 col-lg-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="position-relative">
                        <img src="https://avatar-placeholder.iran.liara.run/bg_64748b/AI%20ML/500x300" class="card-img-top" alt="AI Course">
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-light text-dark">AI & Machine Learning</span>
                            <div class="text-warning">
                                <i class="fas fa-star"></i>
                                <span class="ms-1">4.7 (423)</span>
                            </div>
                        </div>
                        <h5 class="fw-bold mb-3">Machine Learning & AI: Python & TensorFlow</h5>
                        <p class="text-muted">Build intelligent systems and models using Python, TensorFlow, and other ML frameworks.</p>
                        <div class="d-flex align-items-center mb-3">
                            <img src="https://avatar-placeholder.iran.liara.run/boy?username=Nikesh" class="rounded-circle me-2" style="width: 40px; height: 40px;" alt="Instructor">
                            <span>Nikesh Regmi</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold fs-5">$119.99</span>
                                <span class="text-muted text-decoration-line-through ms-2">$169.99</span>
                            </div>
                            <a href="#" class="btn btn-outline-primary">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <div class="d-flex justify-content-center mt-5">
            <nav aria-label="Course pagination">
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

<!-- Testimonials -->
<section class="py-5">
    <div class="container">
        <h2 class="text-center fw-bold mb-5">What Our Students Say</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 p-4">
                    <div class="d-flex mb-3">
                        <img src="https://avatar-placeholder.iran.liara.run/boy?username=Rajesh" class="rounded-circle me-3" style="width: 60px; height: 60px;" alt="Student">
                        <div>
                            <h5 class="fw-bold mb-1">Rajesh Sharma</h5>
                            <p class="text-muted mb-0">Web Developer</p>
                        </div>
                    </div>
                    <div class="text-warning mb-3">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="fst-italic mb-0">"The Full-Stack Web Development course completely transformed my career. Within 3 months of completion, I landed my dream job as a developer."</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 p-4">
                    <div class="d-flex mb-3">
                        <img src="https://avatar-placeholder.iran.liara.run/girl?username=Priya" class="rounded-circle me-3" style="width: 60px; height: 60px;" alt="Student">
                        <div>
                            <h5 class="fw-bold mb-1">Priya Patel</h5>
                            <p class="text-muted mb-0">Data Analyst</p>
                        </div>
                    </div>
                    <div class="text-warning mb-3">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <p class="fst-italic mb-0">"The Data Science course provided me with practical skills that I use daily in my job. The instructors were knowledgeable and the projects were challenging but rewarding."</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 p-4">
                    <div class="d-flex mb-3">
                        <img src="https://avatar-placeholder.iran.liara.run/boy?username=Amit" class="rounded-circle me-3" style="width: 60px; height: 60px;" alt="Student">
                        <div>
                            <h5 class="fw-bold mb-1">Amit Kumar</h5>
                            <p class="text-muted mb-0">UI/UX Designer</p>
                        </div>
                    </div>
                    <div class="text-warning mb-3">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="fst-italic mb-0">"The UI/UX Design course helped me transition from graphic design to UX design. The curriculum was comprehensive and the feedback from instructors was invaluable."</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="py-5 bg-primary text-white">
    <div class="container text-center">
        <h2 class="fw-bold mb-3">Ready to Start Learning?</h2>
        <p class="lead mb-4">Join thousands of students who are already advancing their careers with SkillForge.</p>
        <div class="d-flex justify-content-center gap-3">
            <a href="#" class="btn btn-light btn-lg px-4">Browse All Courses</a>
            <c:if test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-outline-light btn-lg px-4">Sign Up Now</a>
            </c:if>
        </div>
    </div>
</section>

<%@ include file="/common/footer.jsp" %>
