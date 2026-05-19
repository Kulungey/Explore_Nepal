<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Bookings — Admin</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
  <style>
    .admin-wrap { display:flex; min-height:100vh; }
    .main-content { flex:1; padding: 32px; }
    h1 { font-size:1.6rem; font-weight:700; margin-bottom:24px; color:var(--color-primary); }
    table { width:100%; border-collapse:collapse; background:#fff;
            border-radius:var(--radius-lg); box-shadow:var(--shadow-card); overflow:hidden; }
    th { background:var(--color-primary); color:#fff; padding:12px 16px;
         text-align:left; font-size:.85rem; text-transform:uppercase; letter-spacing:.05em; }
    td { padding:12px 16px; border-bottom:1px solid var(--color-outline-variant);
         font-size:.9rem; vertical-align:middle; }
    tr:last-child td { border-bottom:none; }
    tr:hover td { background:var(--color-surface-low); }
    .badge {
      display:inline-block; padding:3px 10px; border-radius:20px;
      font-size:.75rem; font-weight:700; text-transform:uppercase;
    }
    .badge-pending  { background:#FEF3C7; color:#92400E; }
    .badge-confirmed{ background:#D1FAE5; color:#065F46; }
    .badge-cancelled{ background:#FEE2E2; color:#991B1B; }
    .badge-completed{ background:#DBEAFE; color:#1E40AF; }
    select.status-select {
      padding:5px 8px; border-radius:var(--radius); border:1.5px solid var(--color-outline);
      font-size:.85rem; cursor:pointer;
    }
    .btn-update {
      padding:5px 12px; background:var(--color-secondary); color:#fff;
      border:none; border-radius:var(--radius); cursor:pointer; font-size:.82rem; font-weight:600;
    }
    .btn-update:hover { background:var(--color-secondary-hover); }
    .empty-msg { text-align:center; padding:48px; color:var(--color-on-surface-muted); }
  </style>
</head>
<body>
<div class="admin-wrap">
  <jsp:include page="_sidebar.jsp"/>
  <div class="main-content">
    <h1>📋 Order Tracker</h1>

    <c:choose>
      <c:when test="${empty bookings}">
        <div class="empty-msg">No bookings yet.</div>
      </c:when>
      <c:otherwise>
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Booking Ref</th>
              <th>Customer</th>
              <th>Destination</th>
              <th>Amount</th>
              <th>Date</th>
              <th>Status</th>
              <th>Update</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="b" items="${bookings}" varStatus="s">
              <tr>
                <td>${s.count}</td>
                <td><strong>${fn:escapeXml(b.bookingRef)}</strong></td>
                <td>
                  ${fn:escapeXml(b.userFullName)}<br/>
                  <small style="color:var(--color-slate-gray)">${fn:escapeXml(b.userEmail)}</small>
                </td>
                <td>${fn:escapeXml(b.destinationName)}</td>
                <td>$${b.amount}</td>
                <td>${b.createdAt}</td>
                <td>
                  <span class="badge badge-${fn:toLowerCase(b.status)}">${b.status}</span>
                </td>
                <td>
                  <form action="${pageContext.request.contextPath}/admin/bookings" method="post"
                        style="display:flex; gap:6px; align-items:center;">
                    <input type="hidden" name="bookingId" value="${b.id}"/>
                    <select name="status" class="status-select">
                      <option value="Pending"   ${b.status=='Pending'   ? 'selected':''}> Pending</option>
                      <option value="Confirmed" ${b.status=='Confirmed' ? 'selected':''}> Confirmed</option>
                      <option value="Completed" ${b.status=='Completed' ? 'selected':''}> Completed</option>
                      <option value="Cancelled" ${b.status=='Cancelled' ? 'selected':''}> Cancelled</option>
                    </select>
                    <button type="submit" class="btn-update">Save</button>
                  </form>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:otherwise>
    </c:choose>
  </div>
</div>
</body>
</html>