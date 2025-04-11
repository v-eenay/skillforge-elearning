<%@ page language="java" %>
<%@ include file="/common/header.jsp" %>

<div class="container py-4">
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="mb-3">Admin Dashboard</h2>
            <p class="text-muted">Welcome back, ${user.name}! Here's an overview of your platform.</p>
        </div>
        <div class="col-md-4 text-end">
            <button class="btn btn-outline-primary me-2">Notifications <span class="badge bg-danger">3</span></button>
            <button class="btn btn-primary">Settings</button>
        </div>
    </div>
    
    <!-- Stats Overview -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <h5 class="card-title">Total Users</h5>
                    <h2 class="display-4">1,245</h2>
                    <p class="card-text"><small>↑ 12% from last month</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <h5 class="card-title">Active Courses</h5>
                    <h2 class="display-4">87</h2>
                    <p class="card-text"><small>↑ 5% from last month</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-info text-white">
                <div class="card-body">
                    <h5 class="card-title">Enrollments</h5>
                    <h2 class="display-4">3,721</h2>
                    <p class="card-text"><small>↑ 18% from last month</small></p>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-warning text-dark">
                <div class="card-body">
                    <h5 class="card-title">Revenue</h5>
                    <h2 class="display-4">$42K</h2>
                    <p class="card-text"><small>↑ 8% from last month</small></p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <!-- User Management -->
        <div class="col-md-8 mb-4">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Recent Users</h5>
                    <button class="btn btn-sm btn-primary">View All Users</button>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Joined</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="https://placedog.net/40/40?id=1" class="rounded-circle me-2" alt="User">
                                            <div>Rajesh Sharma</div>
                                        </div>
                                    </td>
                                    <td>Student</td>
                                    <td><span class="badge bg-success">Active</span></td>
                                    <td>Apr 10, 2023</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
                                        <button class="btn btn-sm btn-outline-danger">Suspend</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="https://placedog.net/40/40?id=2" class="rounded-circle me-2" alt="User">
                                            <div>Priya Patel</div>
                                        </div>
                                    </td>
                                    <td>Instructor</td>
                                    <td><span class="badge bg-success">Active</span></td>
                                    <td>Mar 22, 2023</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
                                        <button class="btn btn-sm btn-outline-danger">Suspend</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="https://placedog.net/40/40?id=3" class="rounded-circle me-2" alt="User">
                                            <div>Amit Kumar</div>
                                        </div>
                                    </td>
                                    <td>Student</td>
                                    <td><span class="badge bg-warning text-dark">Pending</span></td>
                                    <td>Apr 15, 2023</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
                                        <button class="btn btn-sm btn-outline-danger">Suspend</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="https://placedog.net/40/40?id=4" class="rounded-circle me-2" alt="User">
                                            <div>Sunita Rai</div>
                                        </div>
                                    </td>
                                    <td>Instructor</td>
                                    <td><span class="badge bg-danger">Inactive</span></td>
                                    <td>Feb 28, 2023</td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary me-1">Edit</button>
                                        <button class="btn btn-sm btn-outline-success">Activate</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- System Settings -->
        <div class="col-md-4 mb-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">System Settings</h5>
                </div>
                <div class="card-body">
                    <div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            Site Configuration
                            <span class="badge bg-primary rounded-pill"><i class="bi bi-gear"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            Payment Settings
                            <span class="badge bg-primary rounded-pill"><i class="bi bi-credit-card"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            Email Templates
                            <span class="badge bg-primary rounded-pill"><i class="bi bi-envelope"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            Security Settings
                            <span class="badge bg-primary rounded-pill"><i class="bi bi-shield-lock"></i></span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            Backup & Restore
                            <span class="badge bg-primary rounded-pill"><i class="bi bi-cloud-arrow-up"></i></span>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Notifications -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Recent Notifications</h5>
                    <button class="btn btn-sm btn-primary">View All</button>
                </div>
                <div class="card-body p-0">
                    <div class="list-group list-group-flush">
                        <a href="#" class="list-group-item list-group-item-action py-3">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">New Course Submitted</h6>
                                <small class="text-muted">3 hours ago</small>
                            </div>
                            <p class="mb-1">Instructor Priya Patel submitted a new course for review.</p>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action py-3">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">System Update Completed</h6>
                                <small class="text-muted">1 day ago</small>
                            </div>
                            <p class="mb-1">The system update has been successfully completed.</p>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action py-3">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">Payment Gateway Alert</h6>
                                <small class="text-muted">2 days ago</small>
                            </div>
                            <p class="mb-1">There was an issue with the payment gateway. Please check.</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
