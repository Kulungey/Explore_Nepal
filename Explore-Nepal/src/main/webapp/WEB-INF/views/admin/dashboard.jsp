<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Dashboard — Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

  <%-- Top nav (minimal for admin) --%>
  <jsp:include page="../_nav.jsp">
    <jsp:param name="activePage" value=""/>
  </jsp:include>

  <div class="admin-wrapper">

    <%-- Sidebar --%>
    <jsp:include page="_sidebar.jsp">
      <jsp:param name="activePage" value="dashboard"/>
    </jsp:include>

    <%-- Main content --%>
    <main class="admin-content">

      <div class="page-header" style="margin-bottom:var(--sp-4);">
        <div>
          <h1>Dashboard</h1>
          <p>Welcome back, <strong><c:out value="${sessionScope.loggedInUser.fullName}"/></strong>. Here's what's happening.</p>
        </div>
      </div>

      <%-- Error --%>
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
      </c:if>

      <%-- ── Stat cards ─────────────────────────────────────────── --%>
      <div class="grid-3" style="margin-bottom:var(--sp-6);">

        <div class="stat-card">
          <div class="stat-label">Total Destinations</div>
          <div class="stat-value"><c:out value="${totalDestinations}"/></div>
          <div class="stat-accent"></div>
          <a href="${pageContext.request.contextPath}/admin/destinations"
             style="font-size:var(--text-xs); font-weight:600; color:var(--color-primary); margin-top:var(--sp-1); display:inline-block;">
            View all →
          </a>
        </div>

        <div class="stat-card">
          <div class="stat-label">Registered Users</div>
          <div class="stat-value"><c:out value="${totalUsers}"/></div>
          <div class="stat-accent" style="background:var(--color-secondary);"></div>
        </div>

        <div class="stat-card">
          <div class="stat-label">Platform Status</div>
          <div class="stat-value" style="font-size:1.5rem; color:#166534;">Live</div>
          <div class="stat-accent" style="background:#22c55e;"></div>
          <span style="font-size:var(--text-xs); color:var(--color-slate-gray); margin-top:4px; display:block;">All systems operational</span>
        </div>

      </div>

      <%-- ── Quick actions ─────────────────────────────────────── --%>
      <section style="background:#fff; border-radius:var(--radius-lg); border:1px solid var(--color-outline-variant); padding:var(--sp-4); box-shadow:var(--shadow-card);">
        <h2 style="font-size:var(--text-xl); font-weight:600; color:var(--color-primary); margin-bottom:var(--sp-3);">Quick Actions</h2>
        <div style="display:flex; gap:var(--sp-2); flex-wrap:wrap;">
          <a href="${pageContext.request.contextPath}/admin/destination-form" class="btn btn-primary">
            + Add Destination
          </a>
          <a href="${pageContext.request.contextPath}/admin/destinations" class="btn btn-secondary">
            Manage Destinations
          </a>
          <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">
            View Public Site
          </a>
        </div>
      </section>

      <%-- ── Info row ─────────────────────────────────────────── --%>
      <section style="margin-top:var(--sp-4); background:#fff; border-radius:var(--radius-lg); border:1px solid var(--color-outline-variant); padding:var(--sp-4); box-shadow:var(--shadow-card);">
        <h2 style="font-size:var(--text-xl); font-weight:600; color:var(--color-primary); margin-bottom:var(--sp-2);">System Info</h2>
        <table style="width:auto; font-size:var(--text-sm);">
          <tbody>
            <tr>
              <td style="padding:6px 16px 6px 0; color:var(--color-slate-gray); font-weight:600;">Role</td>
              <td style="padding:6px 0;"><c:out value="${sessionScope.loggedInUser.role}"/></td>
            </tr>
            <tr>
              <td style="padding:6px 16px 6px 0; color:var(--color-slate-gray); font-weight:600;">Email</td>
              <td style="padding:6px 0;"><c:out value="${sessionScope.loggedInUser.email}"/></td>
            </tr>
            <tr>
              <td style="padding:6px 16px 6px 0; color:var(--color-slate-gray); font-weight:600;">Server Time</td>
              <td style="padding:6px 0;"><c:out value="${serverTime}"/></td>
            </tr>
          </tbody>
        </table>
      </section>

    </main>
  </div>

</body>
</html>
