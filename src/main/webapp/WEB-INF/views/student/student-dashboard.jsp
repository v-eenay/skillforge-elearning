<%@ include file="/common/header.jsp" %>

<div class="dashboard-container">
    <div class="container">
        <div class="row dashboard-header">
            <div class="col-md-8">
                <h2>Student Dashboard</h2>
                <p>Welcome back, ${sessionScope.user.name}! Track your learning progress and discover new courses.</p>
            </div>
            <div class="col-md-4">
                <div class="dashboard-actions">
                    <a href="${pageContext.request.contextPath}/courses" class="btn btn-primary">
                        <i class="fas fa-search"></i> Browse Courses
                    </a>
                </div>
            </div>
        </div>

    <!-- Progress Overview -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-primary text-white">
                <div class="card-body">
                    <h5 class="card-title">Enrolled Courses</h5>
                    <h2 class="display-4">4</h2>
                    <p class="card-text"><i class="fas fa-book-open"></i> 2 in progress, 2 completed</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title">Certificates</h5>
                    <h2 class="display-4">2</h2>
                    <p class="card-text"><i class="fas fa-certificate"></i> Download or share them</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title">Hours Learned</h5>
                    <h2 class="display-4">27</h2>
                    <p class="card-text"><i class="fas fa-clock"></i> This month</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stats-card bg-warning text-white">
                <div class="card-body">
                    <h5 class="card-title">Assignments</h5>
                    <h2 class="display-4">3</h2>
                    <p class="card-text"><i class="fas fa-tasks"></i> 1 pending submission</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Current Courses -->
        <div class="col-md-8 mb-4">
            <div class="content-card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5>My Courses</h5>
                    <div class="filter-buttons">
                        <button class="btn btn-sm btn-outline-secondary">All</button>
                        <button class="btn btn-sm btn-primary">In Progress</button>
                        <button class="btn btn-sm btn-outline-secondary">Completed</button>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Course 1 -->
                    <div class="course-item">
                        <img src="https://placedog.net/100/70?id=1" alt="Course">
                        <div class="course-item-content">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5>Web Development Fundamentals</h5>
                                    <p><i class="fas fa-user-tie"></i> Instructor: Priya Patel</p>
                                </div>
                                <span class="badge bg-primary">In Progress</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style="width: 65%" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <span><i class="fas fa-chart-line"></i> 65% Complete</span>
                                <button class="btn btn-sm btn-primary"><i class="fas fa-play-circle"></i> Continue Learning</button>
                            </div>
                        </div>
                    </div>

                    <!-- Course 2 -->
                    <div class="course-item">
                        <img src="https://placedog.net/100/70?id=2" alt="Course">
                        <div class="course-item-content">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5>Data Science Essentials</h5>
                                    <p><i class="fas fa-user-tie"></i> Instructor: Amit Kumar</p>
                                </div>
                                <span class="badge bg-primary">In Progress</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" style="width: 32%" aria-valuenow="32" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <span><i class="fas fa-chart-line"></i> 32% Complete</span>
                                <button class="btn btn-sm btn-primary"><i class="fas fa-play-circle"></i> Continue Learning</button>
                            </div>
                        </div>
                    </div>

                    <!-- Course 3 -->
                    <div class="course-item">
                        <img src="https://placedog.net/100/70?id=3" alt="Course">
                        <div class="course-item-content">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5>Digital Marketing Masterclass</h5>
                                    <p><i class="fas fa-user-tie"></i> Instructor: Sunita Rai</p>
                                </div>
                                <span class="badge bg-success">Completed</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <span><i class="fas fa-certificate"></i> Certificate Earned</span>
                                <button class="btn btn-sm btn-outline-success"><i class="fas fa-award"></i> View Certificate</button>
                            </div>
                        </div>
                    </div>

                    <!-- Course 4 -->
                    <div class="course-item">
                        <img src="https://placedog.net/100/70?id=4" alt="Course">
                        <div class="course-item-content">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5>Project Management Professional</h5>
                                    <p><i class="fas fa-user-tie"></i> Instructor: Bikash Shrestha</p>
                                </div>
                                <span class="badge bg-success">Completed</span>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <span><i class="fas fa-certificate"></i> Certificate Earned</span>
                                <button class="btn btn-sm btn-outline-success"><i class="fas fa-award"></i> View Certificate</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="col-md-4">
            <!-- Upcoming Deadlines -->
            <div class="sidebar-card mb-4">
                <div class="card-header">
                    <h5>Upcoming Deadlines</h5>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <h6>Final Project Submission</h6>
                                <small><i class="fas fa-book"></i> Web Development Fundamentals</small>
                            </div>
                            <span class="badge bg-danger">2 days left</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <h6>Quiz: Data Analysis</h6>
                                <small><i class="fas fa-book"></i> Data Science Essentials</small>
                            </div>
                            <span class="badge bg-warning">5 days left</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <h6>Group Discussion</h6>
                                <small><i class="fas fa-book"></i> Data Science Essentials</small>
                            </div>
                            <span class="badge bg-info">1 week left</span>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Recommended Courses -->
            <div class="sidebar-card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5>Recommended For You</h5>
                    <button class="btn btn-sm btn-primary">View All</button>
                </div>
                <div class="card-body">
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex">
                                <img src="https://placebeard.it/70/70?image=42" class="me-3" alt="Course" style="width: 70px; height: 70px; object-fit: cover; border-radius: 8px;">
                                <div>
                                    <h6>Advanced JavaScript</h6>
                                    <p>Take your web development skills to the next level</p>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-success me-2">Bestseller</span>
                                        <small><i class="fas fa-star text-warning"></i> 4.8 (2,345 ratings)</small>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex">
                                <img src="https://placebeard.it/70/70?image=43" class="me-3" alt="Course" style="width: 70px; height: 70px; object-fit: cover; border-radius: 8px;">
                                <div>
                                    <h6>Machine Learning Fundamentals</h6>
                                    <p>Perfect next step after Data Science Essentials</p>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-primary me-2">New</span>
                                        <small><i class="fas fa-star text-warning"></i> 4.9 (1,120 ratings)</small>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex">
                                <img src="https://placebeard.it/70/70?image=44" class="me-3" alt="Course" style="width: 70px; height: 70px; object-fit: cover; border-radius: 8px;">
                                <div>
                                    <h6>UI/UX Design Principles</h6>
                                    <p>Complement your web development skills</p>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-warning me-2">Popular</span>
                                        <small><i class="fas fa-star text-warning"></i> 4.7 (3,210 ratings)</small>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
