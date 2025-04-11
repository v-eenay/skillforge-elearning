<%@ page language="java" %>
<%@ include file="/common/header.jsp" %>

<div class="container py-4">
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="mb-3">Instructor Dashboard</h2>
            <p class="text-muted">Welcome back, ${user.name}! Manage your courses and track student performance.</p>
        </div>
        <div class="col-md-4 text-end">
            <button class="btn btn-outline-primary me-2">Student Messages <span class="badge bg-danger">5</span></button>
            <button class="btn btn-primary">Create Course</button>
        </div>
    </div>
    
    <!-- Stats Overview -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <h5 class="card-title">Active Courses</h5>
                    <h2 class="display-4">5</h2>
                    <p class="card-text"><small>2 pending approval</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title">Total Students</h5>
                    <h2 class="display-4">247</h2>
                    <p class="card-text"><small>↑ 12% from last month</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title">Course Rating</h5>
                    <h2 class="display-4">4.8</h2>
                    <p class="card-text"><small>Based on 183 reviews</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-warning text-dark">
                <div class="card-body">
                    <h5 class="card-title">Earnings</h5>
                    <h2 class="display-4">$3.2K</h2>
                    <p class="card-text"><small>This month</small></p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <!-- Course Management -->
        <div class="col-md-8 mb-4">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">My Courses</h5>
                    <div>
                        <button class="btn btn-sm btn-outline-secondary me-2">All</button>
                        <button class="btn btn-sm btn-primary">Published</button>
                        <button class="btn btn-sm btn-outline-secondary">Draft</button>
                    </div>
                </div>
                <div class="card-body">
                    <!-- Course 1 -->
                    <div class="d-flex mb-3 p-3 border-bottom">
                        <img src="https://placedog.net/100/70?id=8" class="me-3" alt="Course">
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="mb-1">Web Development Fundamentals</h5>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-success me-2">Published</span>
                                        <small class="text-muted">Last updated: 2 weeks ago</small>
                                    </div>
                                </div>
                                <div>
                                    <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
                                    <button class="btn btn-sm btn-outline-secondary">Statistics</button>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <div>
                                    <small class="text-muted me-3"><strong>Students:</strong> 87</small>
                                    <small class="text-muted me-3"><strong>Rating:</strong> 4.9 ★ (42 reviews)</small>
                                    <small class="text-muted"><strong>Revenue:</strong> $1,740</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Course 2 -->
                    <div class="d-flex mb-3 p-3 border-bottom">
                        <img src="https://placedog.net/100/70?id=9" class="me-3" alt="Course">
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="mb-1">Advanced JavaScript Techniques</h5>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-success me-2">Published</span>
                                        <small class="text-muted">Last updated: 1 month ago</small>
                                    </div>
                                </div>
                                <div>
                                    <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
                                    <button class="btn btn-sm btn-outline-secondary">Statistics</button>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <div>
                                    <small class="text-muted me-3"><strong>Students:</strong> 64</small>
                                    <small class="text-muted me-3"><strong>Rating:</strong> 4.7 ★ (38 reviews)</small>
                                    <small class="text-muted"><strong>Revenue:</strong> $1,280</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Course 3 -->
                    <div class="d-flex mb-3 p-3 border-bottom">
                        <img src="https://placedog.net/100/70?id=10" class="me-3" alt="Course">
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="mb-1">Responsive Web Design Masterclass</h5>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-success me-2">Published</span>
                                        <small class="text-muted">Last updated: 3 months ago</small>
                                    </div>
                                </div>
                                <div>
                                    <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
                                    <button class="btn btn-sm btn-outline-secondary">Statistics</button>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <div>
                                    <small class="text-muted me-3"><strong>Students:</strong> 96</small>
                                    <small class="text-muted me-3"><strong>Rating:</strong> 4.8 ★ (52 reviews)</small>
                                    <small class="text-muted"><strong>Revenue:</strong> $1,920</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Course 4 (Draft) -->
                    <div class="d-flex p-3">
                        <img src="https://placedog.net/100/70?id=11" class="me-3" alt="Course">
                        <div class="flex-grow-1">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h5 class="mb-1">Full Stack Development with MERN</h5>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-secondary me-2">Draft</span>
                                        <small class="text-muted">Last updated: 2 days ago</small>
                                    </div>
                                </div>
                                <div>
                                    <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
                                    <button class="btn btn-sm btn-success">Publish</button>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <div>
                                    <small class="text-muted"><strong>Completion:</strong> 85%</small>
                                    <div class="progress mt-1" style="height: 5px; width: 200px;">
                                        <div class="progress-bar" role="progressbar" style="width: 85%" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Sidebar -->
        <div class="col-md-4">
            <!-- Student Performance -->
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Student Performance</h5>
                    <button class="btn btn-sm btn-primary">View All</button>
                </div>
                <div class="card-body p-0">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <h6 class="mb-1">Web Development Fundamentals</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">Average Completion Rate</small>
                                <span>78%</span>
                            </div>
                            <div class="progress mt-1" style="height: 5px;">
                                <div class="progress-bar" role="progressbar" style="width: 78%" aria-valuenow="78" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <h6 class="mb-1">Advanced JavaScript Techniques</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">Average Completion Rate</small>
                                <span>65%</span>
                            </div>
                            <div class="progress mt-1" style="height: 5px;">
                                <div class="progress-bar" role="progressbar" style="width: 65%" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <h6 class="mb-1">Responsive Web Design Masterclass</h6>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">Average Completion Rate</small>
                                <span>82%</span>
                            </div>
                            <div class="progress mt-1" style="height: 5px;">
                                <div class="progress-bar" role="progressbar" style="width: 82%" aria-valuenow="82" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            
            <!-- Earnings Overview -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Earnings Overview</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0">This Month</h6>
                        <h5 class="text-success mb-0">$3,240</h5>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0">Last Month</h6>
                        <h5 class="mb-0">$2,890</h5>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">Year to Date</h6>
                        <h5 class="mb-0">$18,650</h5>
                    </div>
                    <hr>
                    <div class="d-grid">
                        <button class="btn btn-outline-primary">View Earnings Report</button>
                    </div>
                </div>
            </div>
            
            <!-- Recent Reviews -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Recent Reviews</h5>
                    <button class="btn btn-sm btn-primary">View All</button>
                </div>
                <div class="card-body p-0">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item py-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <h6 class="mb-0">Rajesh Sharma</h6>
                                <div>
                                    <span class="text-warning">★★★★★</span>
                                    <small class="text-muted ms-1">5.0</small>
                                </div>
                            </div>
                            <p class="mb-1">"Excellent course! The instructor explains complex concepts in a very understandable way."</p>
                            <small class="text-muted">Web Development Fundamentals • 2 days ago</small>
                        </div>
                        <div class="list-group-item py-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <h6 class="mb-0">Sunita Rai</h6>
                                <div>
                                    <span class="text-warning">★★★★</span>
                                    <small class="text-muted ms-1">4.0</small>
                                </div>
                            </div>
                            <p class="mb-1">"Great content but would love more practical examples. Overall very helpful."</p>
                            <small class="text-muted">Advanced JavaScript Techniques • 1 week ago</small>
                        </div>
                        <div class="list-group-item py-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <h6 class="mb-0">Amit Kumar</h6>
                                <div>
                                    <span class="text-warning">★★★★★</span>
                                    <small class="text-muted ms-1">5.0</small>
                                </div>
                            </div>
                            <p class="mb-1">"This course transformed my understanding of responsive design. Highly recommended!"</p>
                            <small class="text-muted">Responsive Web Design Masterclass • 2 weeks ago</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
