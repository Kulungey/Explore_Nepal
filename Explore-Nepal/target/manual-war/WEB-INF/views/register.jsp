<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Register — Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

  <jsp:include page="_nav.jsp">
    <jsp:param name="activePage" value=""/>
  </jsp:include>

  <div class="auth-page" style="padding-top:var(--sp-4); padding-bottom:var(--sp-4);">
    <div class="auth-card" style="max-width:520px;">

      <div style="margin-bottom:var(--sp-4);">
        <span style="font-size:1.5rem; font-weight:700; color:var(--color-primary);">Explore Nepal</span>
        <h1 class="auth-title" style="margin-top:var(--sp-2);">Create your account</h1>
        <p class="auth-subtitle">Join thousands of adventurers discovering Nepal.</p>
      </div>

      <%-- Server-side error --%>
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
      </c:if>

      <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" class="auth-form" novalidate>

        <%-- Full Name --%>
        <div class="form-group">
          <label class="form-label" for="fullName">Full Name</label>
          <input
            class="form-input"
            type="text"
            id="fullName"
            name="fullName"
            value="${fn:escapeXml(fullNameValue)}"
            placeholder="Aarav Sharma"
            autocomplete="name"
            required/>
          <span class="form-error-text" id="nameError" style="display:none;">
            Full name must contain only letters (no numbers or symbols).
          </span>
        </div>

        <%-- Email --%>
        <div class="form-group">
          <label class="form-label" for="email">Email Address</label>
          <input
            class="form-input"
            type="email"
            id="email"
            name="email"
            value="${fn:escapeXml(emailValue)}"
            placeholder="you@example.com"
            autocomplete="email"
            required/>
          <span class="form-error-text" id="emailError" style="display:none;">
            Please enter a valid email address.
          </span>
        </div>

        <%-- Phone --%>
        <div class="form-group">
          <label class="form-label" for="phone">Phone Number</label>
          <input
            class="form-input"
            type="tel"
            id="phone"
            name="phone"
            value="${fn:escapeXml(phoneValue)}"
            placeholder="98XXXXXXXX"
            autocomplete="tel"
            maxlength="10"
            required/>
          <span class="form-error-text" id="phoneError" style="display:none;">
            Phone must be 10 digits and start with 9.
          </span>
        </div>

        <%-- Password --%>
        <div class="form-group">
          <label class="form-label" for="password">Password</label>
          <input
            class="form-input"
            type="password"
            id="password"
            name="password"
            placeholder="Min. 8 chars, 1 uppercase, 1 number, 1 special"
            autocomplete="new-password"
            required/>
          <span class="form-error-text" id="pwStrengthError" style="display:none;">
            Password must have at least 1 uppercase letter, 1 number, and 1 special character (!@#$%^&* etc).
          </span>
        </div>

        <%-- Confirm Password --%>
        <div class="form-group">
          <label class="form-label" for="confirmPassword">Confirm Password</label>
          <input
            class="form-input"
            type="password"
            id="confirmPassword"
            name="confirmPassword"
            placeholder="Re-enter password"
            autocomplete="new-password"
            required/>
          <span class="form-error-text" id="pwMatchError" style="display:none;">
            Passwords do not match.
          </span>
        </div>

        <button type="submit" class="btn btn-primary btn-full" style="margin-top:var(--sp-1);">
          Create Account
        </button>
      </form>

      <div class="auth-footer">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login">Sign in</a>
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
