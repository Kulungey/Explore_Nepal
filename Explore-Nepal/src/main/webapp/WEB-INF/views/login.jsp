<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login — Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

  <jsp:include page="_nav.jsp">
    <jsp:param name="activePage" value=""/>
  </jsp:include>

  <div class="auth-page">
    <div class="auth-card">

      <%-- Brand mark --%>
      <div style="margin-bottom:var(--sp-4);">
        <span style="font-size:1.5rem; font-weight:700; color:var(--color-primary);">Explore Nepal</span>
        <h1 class="auth-title" style="margin-top:var(--sp-2);">Welcome back</h1>
        <p class="auth-subtitle">Sign in to your account to continue.</p>
      </div>

      <%-- Flash messages --%>
      <c:if test="${not empty successMessage}">
        <div class="alert alert-success"><c:out value="${successMessage}"/></div>
      </c:if>
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
      </c:if>

      <%-- Login form --%>
      <form action="${pageContext.request.contextPath}/login" method="post" class="auth-form" novalidate>

        <div class="form-group">
          <label class="form-label" for="email">Email Address</label>
          <input
            class="form-input ${not empty errorMessage ? 'error' : ''}"
            type="email"
            id="email"
            name="email"
            value="${fn:escapeXml(emailValue)}"
            placeholder="you@example.com"
            autocomplete="email"
            required/>
        </div>

        <div class="form-group">
          <label class="form-label" for="password">Password</label>
          <input
            class="form-input ${not empty errorMessage ? 'error' : ''}"
            type="password"
            id="password"
            name="password"
            placeholder="••••••••"
            autocomplete="current-password"
            required/>
        </div>

        <button type="submit" class="btn btn-primary btn-full" style="margin-top:var(--sp-1);">
          Sign In
        </button>
      </form>

      <div class="auth-footer">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/register">Create one</a>
      </div>

    </div>
  </div>

  <footer>
    <div class="container">
      <p>&copy; 2026 Explore Nepal.</p>
    </div>
  </footer>

</body>
</html>
