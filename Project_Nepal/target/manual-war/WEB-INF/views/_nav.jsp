<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--
  _nav.jsp — Shared navigation bar fragment.

  Usage in any page:
    <jsp:include page="_nav.jsp">
      <jsp:param name="activePage" value="home|about|contact"/>
    </jsp:include>

  For admin pages (which use _sidebar.jsp), pass no activePage or omit param.
--%>

<%-- Compute active classes first — avoids mixing quote styles inside attributes --%>
<c:set var="pgHome"    value="${param.activePage == 'home'    ? 'nav-link--active' : ''}"/>
<c:set var="pgAbout"   value="${param.activePage == 'about'   ? 'nav-link--active' : ''}"/>
<c:set var="pgContact" value="${param.activePage == 'contact' ? 'nav-link--active' : ''}"/>

<header class="nav-header">
  <div class="nav-inner">

    <%-- Brand --%>
    <a href="${pageContext.request.contextPath}/home" class="nav-brand">
      Explore Nepal
    </a>

    <%-- Hamburger button (visible on mobile only via CSS) --%>
    <button class="nav-toggle" id="navToggle" aria-label="Toggle navigation" aria-expanded="false">
      <span></span>
      <span></span>
      <span></span>
    </button>

    <%-- Navigation links --%>
    <nav class="nav-links" id="navLinks" role="navigation" aria-label="Main navigation">

      <a href="${pageContext.request.contextPath}/home"
         class="nav-link ${pgHome}">Home</a>

      <a href="${pageContext.request.contextPath}/about"
         class="nav-link ${pgAbout}">About</a>

      <a href="${pageContext.request.contextPath}/contact"
         class="nav-link ${pgContact}">Contact</a>

      <%-- Auth-aware section --%>
      <c:choose>
        <c:when test="${not empty sessionScope.loggedInUser}">

          <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="nav-link">Dashboard</a>
          </c:if>

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
