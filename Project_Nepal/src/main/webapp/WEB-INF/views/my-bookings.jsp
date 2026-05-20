<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>My Bookings — Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
  <style>
    .bookings-wrap { max-width:860px; margin:var(--sp-6) auto; padding:0 var(--gutter); }
    h1 { font-size:var(--text-2xl); font-weight:700; color:var(--color-primary); margin-bottom:var(--sp-4); }
    table { width:100%; border-collapse:collapse; background:#fff; border-radius:var(--radius-lg); box-shadow:var(--shadow-card); overflow:hidden; }
    th { background:var(--color-primary); color:#fff; padding:12px 16px; text-align:left; font-size:.85rem; text-transform:uppercase; letter-spacing:.05em; }
    td { padding:14px 16px; border-bottom:1px solid var(--color-outline-variant); font-size:.9rem; }
    tr:last-child td { border-bottom:none; }
    .badge { display:inline-block; padding:3px 10px; border-radius:20px; font-size:.75rem; font-weight:700; text-transform:uppercase; }
    .badge-pending   { background:#FEF3C7; color:#92400E; }
    .badge-confirmed { background:#D1FAE5; color:#065F46; }
    .badge-cancelled { background:#FEE2E2; color:#991B1B; }
    .badge-completed { background:#DBEAFE; color:#1E40AF; }
    .empty-msg { text-align:center; padding:64px; color:var(--color-on-surface-muted); }
  </style>
</head>
<body>

  <jsp:include page="_nav.jsp">
    <jsp:param name="activePage" value="bookings"/>
  </jsp:include>

  <main class="section">
    <div class="bookings-wrap">
      <h1>My Bookings</h1>

      <c:choose>
        <c:when test="${empty bookings}">
          <div class="empty-msg">
            <p style="font-size:1.1rem; font-weight:600;">No bookings yet.</p>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary" style="margin-top:16px; display:inline-block;">Explore Destinations</a>
          </div>
        </c:when>
        <c:otherwise>
          <table>
            <thead>
              <tr>
                <th>Booking Ref</th>
                <th>Destination</th>
                <th>Amount</th>
                <th>Date</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="b" items="${bookings}">
                <tr>
                  <td><strong style="font-family:'Courier New',monospace;">${fn:escapeXml(b.bookingRef)}</strong></td>
                  <td>${fn:escapeXml(b.destinationName)}</td>
                  <td>$${b.amount}</td>
                  <td>${b.createdAt}</td>
                  <td><span class="badge badge-${fn:toLowerCase(b.status)}">${b.status}</span></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </c:otherwise>
      </c:choose>
    </div>
  </main>

  <footer>
    <div class="container">
      <p>&copy; 2026 Explore Nepal. Built with Java EE &amp; JSP.</p>
    </div>
  </footer>

</body>
</html>