<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/header.jsp" %>
<%-- Link modern CSS --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modern-login.css">

<body class="modern-login-page">

<div class="login-container">
    <h1>Login to SkillForge</h1>
    <p class="lead">Access your account to continue learning.</p>

                    <%@ include file="/common/alert-messages.jsp" %>

                    <form action="${pageContext.request.contextPath}/auth/login" method="post">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="username" name="username" placeholder="Email or Username" required>
                            <label for="username">Email or Username</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                            <label for="password">Password</label>
                        </div>
                        <div class="mb-3 form-check text-start">
                            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                            <label class="form-check-label" for="rememberMe">Remember me</label>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">Login</button>
                        </div>
                    </form>

                    <div class="links">
                        <a href="#">Forgot password?</a> | <a href="${pageContext.request.contextPath}/auth/register">Don't have an account? Sign up</a>
                    </div>
</div> <%-- End login-container --%>

</body>
<%@ include file="/common/footer.jsp" %>
