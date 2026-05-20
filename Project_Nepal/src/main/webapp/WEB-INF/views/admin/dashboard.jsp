<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Dashboard — Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

  <jsp:include page="../_nav.jsp">
    <jsp:param name="activePage" value=""/>
  </jsp:include>

  <div class="admin-wrapper">

    <jsp:include page="_sidebar.jsp">
      <jsp:param name="activePage" value="dashboard"/>
    </jsp:include>

    <main class="admin-content">

      <div class="page-header" style="margin-bottom:var(--sp-4);">
        <div>
          <h1>Dashboard</h1>
          <p>Welcome back, <strong><c:out value="${sessionScope.loggedInUser.fullName}"/></strong>. Here's what's happening.</p>
        </div>
      </div>

      <c:if test="${not empty errorMessage}">
        <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
      </c:if>

      <%-- Stat cards --%>
      <div class="grid-3" style="margin-bottom:var(--sp-4);">

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
          <a href="${pageContext.request.contextPath}/admin/users"
             style="font-size:var(--text-xs); font-weight:600; color:var(--color-primary); margin-top:var(--sp-1); display:inline-block;">
            Manage users →
          </a>
        </div>

        <div class="stat-card">
          <div class="stat-label">Total Bookings</div>
          <div class="stat-value"><c:out value="${totalBookings}"/></div>
          <div class="stat-accent" style="background:#8b5cf6;"></div>
          <a href="${pageContext.request.contextPath}/admin/bookings"
             style="font-size:var(--text-xs); font-weight:600; color:var(--color-primary); margin-top:var(--sp-1); display:inline-block;">
            View orders →
          </a>
        </div>

      </div>

      <%-- Revenue card --%>
      <div style="background:#fff; border-radius:var(--radius-lg); border:1px solid var(--color-outline-variant);
                  padding:var(--sp-3) var(--sp-4); box-shadow:var(--shadow-card); margin-bottom:var(--sp-4);
                  display:flex; align-items:center; gap:var(--sp-3);">
        <div style="flex:1;">
          <div style="font-size:var(--text-sm); color:var(--color-slate-gray); font-weight:600; text-transform:uppercase; letter-spacing:.06em;">Total Revenue (Confirmed + Completed)</div>
          <div style="font-size:2rem; font-weight:700; color:var(--color-secondary); margin-top:4px;">
            $<fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00"/>
          </div>
        </div>
        <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="var(--color-secondary)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" opacity=".4">
          <line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/>
        </svg>
      </div>

      <%-- Quick actions --%>
      <section style="background:#fff; border-radius:var(--radius-lg); border:1px solid var(--color-outline-variant); padding:var(--sp-4); box-shadow:var(--shadow-card); margin-bottom:var(--sp-4);">
        <h2 style="font-size:var(--text-xl); font-weight:600; color:var(--color-primary); margin-bottom:var(--sp-3);">Quick Actions</h2>
        <div style="display:flex; gap:var(--sp-2); flex-wrap:wrap;">
          <a href="${pageContext.request.contextPath}/admin/destination-form" class="btn btn-primary">+ Add Destination</a>
          <a href="${pageContext.request.contextPath}/admin/destinations" class="btn btn-secondary">Manage Destinations</a>
          <a href="${pageContext.request.contextPath}/admin/bookings" class="btn btn-secondary">Order Tracker</a>
          <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Manage Users</a>
          <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">View Public Site</a>
        </div>
      </section>

      <%-- System info --%>
      <section style="background:#fff; border-radius:var(--radius-lg); border:1px solid var(--color-outline-variant); padding:var(--sp-4); box-shadow:var(--shadow-card);">
        <h2 style="font-size:var(--text-xl); font-weight:600; color:var(--color-primary); margin-bottom:var(--sp-2);">System Info</h2>
        <table style="width:auto; font-size:var(--text-sm);">
          <tbody>
            <tr>
              <td style="padding:6px 16px 6px 0; color:var(--color-slate-gray); font-weight:600;">Role</td>
              <td><c:out value="${sessionScope.loggedInUser.role}"/></td>
            </tr>
            <tr>
              <td style="padding:6px 16px 6px 0; color:var(--color-slate-gray); font-weight:600;">Email</td>
              <td><c:out value="${sessionScope.loggedInUser.email}"/></td>
            </tr>
            <tr>
              <td style="padding:6px 16px 6px 0; color:var(--color-slate-gray); font-weight:600;">Server Time</td>
              <td><c:out value="${serverTime}"/></td>
            </tr>
          </tbody>
        </table>
      </section>

    </main>
  </div>

</body>
</html>