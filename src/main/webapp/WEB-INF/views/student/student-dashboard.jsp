<%@ include file="/common/header.jsp" %>

<div class="container py-4">
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="mb-3">Student Dashboard</h2>
            <p class="text-muted">Welcome back, ${sessionScope.user.name}! Track your learning progress and discover new courses.</p>
        </div>
        <div class="col-md-4 text-end">
            <button class="btn btn-outline-primary me-2">Messages <span class="badge bg-danger">2</span></button>
            <button class="btn btn-primary">My Profile</button>
        </div>
    </div>
    
    <!-- Progress Overview -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <h5 class="card-title">Enrolled Courses</h5>
                    <h2 class="display-4">4</h2>
                    <p class="card-text"><small>2 in progress, 2 completed</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title">Certificates</h5>
                    <h2 class="display-4">2</h2>
                    <p class="card-text"><small>Download or share them</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title">Hours Learned</h5>
                    <h2 class="display-4">27</h2>
                    <p class="card-text"><small>This month</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-warning text-dark">
                <div class="card-body">
                    <h5 class="card-title">Assignments</h5>
                    <h2 class="display-4">3</h2>
                    <p class="card-text"><small>1 pending submission</small></p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <!-- Current Courses -->
        <div class="col-md-8 mb-4">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">My Courses</h5>
                    <div>
                        <button class="btn btn-sm btn-outline-secondary me-2">All</button>
                        <button class="btn btn-sm btn-primary">In Progress</button>
                        <button class="btn btn-sm btn-outline-secondary">Completed</button>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Course 1 -->
                    <div class="d-flex mb-3 p-3 border-bottom">
                        <img src="https://placedog.net/100/70?id=1" class="me-3" alt="Course">
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="mb-1">Web Development Fundamentals</h5>
                                    <p class="text-muted mb-0">Instructor: Priya Patel</p>
                                </div>
                                <span class="badge bg-primary">In Progress</span>
                            </div>
                            <div class="progress mt-2" style="height: 8px;">
                                <div class="progress-bar" role="progressbar" style="width: 65%" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <small class="text-muted">65% Complete</small>
                                <button class="btn btn-sm btn-primary">Continue Learning</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Course 2 -->
                    <div class="d-flex mb-3 p-3 border-bottom">
                        <img src="https://placedog.net/100/70?id=2" class="me-3" alt="Course">
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="mb-1">Data Science Essentials</h5>
                                    <p class="text-muted mb-0">Instructor: Amit Kumar</p>
                                </div>
                                <span class="badge bg-primary">In Progress</span>
                            </div>
                            <div class="progress mt-2" style="height: 8px;">
                                <div class="progress-bar" role="progressbar" style="width: 32%" aria-valuenow="32" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <small class="text-muted">32% Complete</small>
                                <button class="btn btn-sm btn-primary">Continue Learning</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Course 3 -->
                    <div class="d-flex mb-3 p-3 border-bottom">
                        <img src="https://placedog.net/100/70?id=3" class="me-3" alt="Course">
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="mb-1">Digital Marketing Masterclass</h5>
                                    <p class="text-muted mb-0">Instructor: Sunita Rai</p>
                                </div>
                                <span class="badge bg-success">Completed</span>
                            </div>
                            <div class="progress mt-2" style="height: 8px;">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <small class="text-muted">Certificate Earned</small>
                                <button class="btn btn-sm btn-outline-success">View Certificate</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Course 4 -->
                    <div class="d-flex p-3">
                        <img src="https://placedog.net/100/70?id=4" class="me-3" alt="Course">
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="mb-1">Project Management Professional</h5>
                                    <p class="text-muted mb-0">Instructor: Bikash Shrestha</p>
                                </div>
                                <span class="badge bg-success">Completed</span>
                            </div>
                            <div class="progress mt-2" style="height: 8px;">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <small class="text-muted">Certificate Earned</small>
                                <button class="btn btn-sm btn-outline-success">View Certificate</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Sidebar -->
        <div class="col-md-4">
            <!-- Upcoming Deadlines -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Upcoming Deadlines</h5>
                </div>
                <div class="card-body p-0">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-0">Final Project Submission</h6>
                                <small class="text-muted">Web Development Fundamentals</small>
                            </div>
                            <span class="badge bg-danger rounded-pill">2 days left</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-0">Quiz: Data Analysis</h6>
                                <small class="text-muted">Data Science Essentials</small>
                            </div>
                            <span class="badge bg-warning text-dark rounded-pill">5 days left</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="mb-0">Group Discussion</h6>
                                <small class="text-muted">Data Science Essentials</small>
                            </div>
                            <span class="badge bg-info rounded-pill">1 week left</span>
                        </li>
                    </ul>
                </div>
            </div>
            
            <!-- Recommended Courses -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Recommended For You</h5>
                </div>
                <div class="card-body p-0">
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action py-3">
                            <div class="d-flex">
                                <img src="https://placedog.net/70/70?id=5" class="me-3" alt="Course">
                                <div>
                                    <h6 class="mb-1">Advanced JavaScript</h6>
                                    <p class="mb-1 text-muted">Take your web development skills to the next level</p>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-success me-2">Bestseller</span>
                                        <small class="text-muted">4.8 <i class="fa-solid fa-star"></i> (2,345 ratings)</small>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action py-3">
                            <div class="d-flex">
                                <img src="https://placedog.net/70/70?id=6" class="me-3" alt="Course">
                                <div>
                                    <h6 class="mb-1">Machine Learning Fundamentals</h6>
                                    <p class="mb-1 text-muted">Perfect next step after Data Science Essentials</p>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-primary me-2">New</span>
                                        <small class="text-muted">4.9 <i class="fa-solid fa-star"></i> (1,120 ratings)</small>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action py-3">
                            <div class="d-flex">
                                <img src="https://placedog.net/70/70?id=7" class="me-3" alt="Course">
                                <div>
                                    <h6 class="mb-1">UI/UX Design Principles</h6>
                                    <p class="mb-1 text-muted">Complement your web development skills</p>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-warning text-dark me-2">Popular</span>
                                        <small class="text-muted">4.7 <i class="fa-solid fa-star"></i> (3,210 ratings)</small>
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
