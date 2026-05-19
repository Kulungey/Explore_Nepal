<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--
  _sidebar.jsp — Admin sidebar fragment.

  Include on every admin page:
    <jsp:include page="_sidebar.jsp">
      <jsp:param name="activePage" value="dashboard|destinations|destination-form"/>
    </jsp:include>
--%>

<%-- Compute active classes up front — same pattern as _nav.jsp --%>
<c:set var="isDashboard"   value="${param.activePage == 'dashboard'}"/>
<c:set var="isDestList"    value="${param.activePage == 'destinations'}"/>
<c:set var="isDestForm"    value="${param.activePage == 'destination-form'}"/>

<aside class="admin-sidebar">

  <%-- Brand --%>
  <div style="padding:var(--sp-2) var(--sp-3);
              border-bottom:1px solid rgba(255,255,255,.08);
              margin-bottom:var(--sp-1);">
    <a href="${pageContext.request.contextPath}/home"
       style="font-size:1.125rem; font-weight:700; color:#ffffff; letter-spacing:-0.01em;">
      Explore Nepal
    </a>
    <div style="font-size:10px; font-weight:700; text-transform:uppercase;
                letter-spacing:.12em; color:#64748b; margin-top:3px;">
      Admin Panel
    </div>
  </div>

  <%-- ── Main ─────────────────────────────────────────────── --%>
  <div class="sidebar-section-label">Main</div>

  <a href="${pageContext.request.contextPath}/admin/dashboard"
     class="sidebar-link ${isDashboard ? 'sidebar-link--active' : ''}">
    <%-- Grid / Dashboard icon --%>
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
         stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
      <rect x="3" y="3" width="7" height="7"/>
      <rect x="14" y="3" width="7" height="7"/>
      <rect x="14" y="14" width="7" height="7"/>
      <rect x="3" y="14" width="7" height="7"/>
    </svg>
    Dashboard
  </a>

  <%-- ── Content ───────────────────────────────────────────── --%>
  <div class="sidebar-section-label" style="margin-top:var(--sp-2);">Content</div>

  <a href="${pageContext.request.contextPath}/admin/destinations"
     class="sidebar-link ${isDestList ? 'sidebar-link--active' : ''}">
    <%-- Map pin icon --%>
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
         stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
      <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
      <circle cx="12" cy="10" r="3"/>
    </svg>
    All Destinations
  </a>

  <a href="${pageContext.request.contextPath}/admin/destination-form"
     class="sidebar-link ${isDestForm ? 'sidebar-link--active' : ''}">
    <%-- Plus circle icon --%>
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
         stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
      <circle cx="12" cy="12" r="10"/>
      <line x1="12" y1="8" x2="12" y2="16"/>
      <line x1="8" y1="12" x2="16" y2="12"/>
    </svg>
    Add Destination
  </a>

  <%-- ── Account ───────────────────────────────────────────── --%>
  <div class="sidebar-section-label" style="margin-top:var(--sp-2);">Account</div>

  <a href="${pageContext.request.contextPath}/home" class="sidebar-link">
    <%-- House icon --%>
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
         stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
      <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
      <polyline points="9 22 9 12 15 12 15 22"/>
    </svg>
    View Site
  </a>

  <a href="${pageContext.request.contextPath}/logout" class="sidebar-link">
    <%-- Log-out icon --%>
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
         stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
      <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
      <polyline points="16 17 21 12 16 7"/>
      <line x1="21" y1="12" x2="9" y2="12"/>
    </svg>
    Logout
  </a>

  <%-- ── Logged-in user badge ──────────────────────────────── --%>
  <div style="margin-top:auto;
              padding:var(--sp-2) var(--sp-3);
              border-top:1px solid rgba(255,255,255,.08);
              margin-top:var(--sp-6);">
    <div style="display:flex; align-items:center; gap:10px;">
      <%-- Avatar initial --%>
      <div style="width:32px; height:32px; border-radius:50%;
                  background:var(--color-secondary); color:#0F172A;
                  font-size:13px; font-weight:700;
                  display:flex; align-items:center; justify-content:center;
                  flex-shrink:0; text-transform:uppercase;">
        <c:out value="${sessionScope.loggedInUser.initial}"/>
      </div>
      <div style="min-width:0;">
        <div style="font-size:var(--text-sm); font-weight:600; color:#ffffff;
                    white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
          <c:out value="${sessionScope.loggedInUser.fullName}"/>
        </div>
        <div style="font-size:10px; color:#64748b; margin-top:1px;
                    white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
          <c:out value="${sessionScope.loggedInUser.email}"/>
        </div>
      </div>
    </div>
  </div>

</aside>
