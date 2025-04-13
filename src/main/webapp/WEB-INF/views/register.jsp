<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-body p-5">
                    <h2 class="text-center mb-4">Create Your SkillForge Account</h2>

                    <%@ include file="/common/alert-messages.jsp" %>

                    <form action="${pageContext.request.contextPath}/auth/register" method="post">
                        <div class="mb-3">
                            <label for="name" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Account Type</label>
                            <div class="d-flex">
                                <div class="form-check me-4">
                                    <input class="form-check-input" type="radio" name="role" id="roleStudent" value="student" checked required>
                                    <label class="form-check-label" for="roleStudent">
                                        Student
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="role" id="roleInstructor" value="instructor" required>
                                    <label class="form-check-label" for="roleInstructor">
                                        Instructor
                                    </label>
                                </div>
                            </div>
                            <small class="text-muted">Note: Admin accounts can only be created through the backend.</small>
                        </div>
                        <div class="mb-3">
                            <label for="bio" class="form-label">Bio (Optional)</label>
                            <textarea class="form-control" id="bio" name="bio" rows="3" placeholder="Tell us a bit about yourself"></textarea>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="termsAgreement" name="termsAgreement" required>
                            <label class="form-check-label" for="termsAgreement">I agree to the <a href="#" class="text-primary">Terms of Service</a> and <a href="#" class="text-primary">Privacy Policy</a></label>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg">Create Account</button>
                        </div>
                    </form>

                    <div class="text-center mt-4">
                        <p>Already have an account? <a href="${pageContext.request.contextPath}/auth/login" class="text-primary">Login here</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/common/footer.jsp" %>
