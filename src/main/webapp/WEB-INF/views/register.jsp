<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/header.jsp" %>
<%-- Link modern CSS --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern-signup.css">

<body class="modern-signup-page">

<div class="signup-container">
    <h1>Create Your SkillForge Account</h1>
    <p class="lead">Join our community and start learning today!</p>

                    <%@ include file="/common/alert-messages.jsp" %>

                    <form action="${pageContext.request.contextPath}/auth/register" method="post">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="name" name="name" placeholder="Full Name" required>
                            <label for="name">Full Name</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email Address" required>
                            <label for="email">Email Address</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
                            <label for="username">Username</label>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <div class="form-floating">
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                                    <label for="password">Password</label>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="form-floating">
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
                                    <label for="confirmPassword">Confirm Password</label>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3 text-start">
                            <label class="form-label d-block">Account Type</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="role" id="roleStudent" value="student" checked required>
                                <label class="form-check-label" for="roleStudent">Student</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="role" id="roleInstructor" value="instructor" required>
                                <label class="form-check-label" for="roleInstructor">Instructor</label>
                            </div>
                            <small class="form-text text-muted d-block mt-1">Admin accounts require manual setup.</small>
                        </div>
                        <div class="form-floating mb-3">
                            <textarea class="form-control" id="bio" name="bio" placeholder="Bio (Optional)" style="height: 100px"></textarea>
                            <label for="bio">Bio (Optional)</label>
                        </div>
                        <div class="mb-3 form-check text-start">
                            <input type="checkbox" class="form-check-input" id="termsAgreement" name="termsAgreement" required>
                            <label class="form-check-label" for="termsAgreement">I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></label>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">Create Account</button>
                        </div>
                    </form>

                    <div class="links">
                        <a href="${pageContext.request.contextPath}/auth/login">Already have an account? Login</a>
                    </div>
</div> <%-- End signup-container --%>

</body>
<%@ include file="/common/footer.jsp" %>
