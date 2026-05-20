<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pgHome"    value="${param.activePage == 'home'    ? 'nav-link--active' : ''}"/>
<c:set var="pgAbout"   value="${param.activePage == 'about'   ? 'nav-link--active' : ''}"/>
<c:set var="pgContact" value="${param.activePage == 'contact' ? 'nav-link--active' : ''}"/>
<c:set var="pgTeam"    value="${param.activePage == 'team'    ? 'nav-link--active' : ''}"/>

<header class="nav-header">
  <div class="nav-inner">

    <a href="${pageContext.request.contextPath}/home" class="nav-brand">
      Explore Nepal
    </a>

    <button class="nav-toggle" id="navToggle" aria-label="Toggle navigation" aria-expanded="false">
      <span></span>
      <span></span>
      <span></span>
    </button>

    <nav class="nav-links" id="navLinks" role="navigation" aria-label="Main navigation">

      <a href="${pageContext.request.contextPath}/home"
         class="nav-link ${pgHome}">Home</a>

      <a href="${pageContext.request.contextPath}/about"
         class="nav-link ${pgAbout}">About Us</a>

      <a href="${pageContext.request.contextPath}/contact"
         class="nav-link ${pgContact}">Contact</a>

      <a href="${pageContext.request.contextPath}/team"
         class="nav-link ${pgTeam}">Our Team</a>

      <c:choose>
        <c:when test="${not empty sessionScope.loggedInUser}">
          <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="nav-link">Dashboard</a>
          </c:if>
<a href="${pageContext.request.contextPath}/profile"
   class="nav-link">Profile</a>
          <span class="nav-user-name">Hi, <c:out value="${sessionScope.loggedInUser.fullName}"/></span>

          <a href="${pageContext.request.contextPath}/logout"
             class="btn btn-secondary">Logout</a>

        </c:when>
        <c:otherwise>

          <a href="${pageContext.request.contextPath}/login"
             class="nav-link">Login</a>

          <a href="${pageContext.request.contextPath}/register"
             class="btn btn-primary">Register</a>

        </c:otherwise>
      </c:choose>

    </nav>
  </div>
</header>

<script src="${pageContext.request.contextPath}/js/main.js" defer></script>