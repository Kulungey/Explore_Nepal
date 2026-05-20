<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<footer class="footer-expanded">
  <div class="container">
    <div class="footer-grid">
      <div>
        <div class="footer-brand">Explore Nepal</div>
        <div class="footer-tagline">Your gateway to the world's most extraordinary Himalayan adventures. Curated, safe, and unforgettable.</div>
      </div>
      <div>
        <div class="footer-heading">Quick Links</div>
        <div class="footer-links">
          <a href="${pageContext.request.contextPath}/home">Home</a>
          <a href="${pageContext.request.contextPath}/about">About</a>
          <a href="${pageContext.request.contextPath}/contact">Contact</a>
          <a href="${pageContext.request.contextPath}/team">Meet The Team</a>
        </div>
      </div>
      <div>
        <div class="footer-heading">Account</div>
        <div class="footer-links">
          <c:choose>
            <c:when test="${not empty sessionScope.loggedInUser}">
              <a href="${pageContext.request.contextPath}/my-bookings">My Bookings</a>
              <a href="${pageContext.request.contextPath}/logout">Logout</a>
              <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a>
              </c:if>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/login">Login</a>
              <a href="${pageContext.request.contextPath}/register">Register</a>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      &copy; 2026 Explore Nepal. Built with Java EE &amp; JSP. All rights reserved.
    </div>
  </div>
</footer>