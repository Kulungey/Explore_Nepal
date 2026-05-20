<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>User Management — Admin</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
  <style>
    .admin-wrap { display:flex; min-height:100vh; }
    .main-content { flex:1; padding:32px; }
    h1 { font-size:1.6rem; font-weight:700; margin-bottom:24px; color:var(--color-primary); }
    table { width:100%; border-collapse:collapse; background:#fff; border-radius:var(--radius-lg); box-shadow:var(--shadow-card); overflow:hidden; }
    th { background:var(--color-primary); color:#fff; padding:12px 16px; text-align:left; font-size:.85rem; text-transform:uppercase; letter-spacing:.05em; }
    td { padding:12px 16px; border-bottom:1px solid var(--color-outline-variant); font-size:.9rem; vertical-align:middle; }
    tr:last-child td { border-bottom:none; }
    tr:hover td { background:var(--color-surface-low); }
    .badge-admin    { background:#FEF3C7; color:#92400E; display:inline-block; padding:3px 10px; border-radius:20px; font-size:.75rem; font-weight:700; }
    .badge-user     { background:#DBEAFE; color:#1E40AF; display:inline-block; padding:3px 10px; border-radius:20px; font-size:.75rem; font-weight:700; }
    .badge-approved { background:#D1FAE5; color:#065F46; display:inline-block; padding:3px 10px; border-radius:20px; font-size:.75rem; font-weight:700; }
    .badge-rejected { background:#FEE2E2; color:#991B1B; display:inline-block; padding:3px 10px; border-radius:20px; font-size:.75rem; font-weight:700; }
    .badge-pending  { background:#FEF3C7; color:#92400E; display:inline-block; padding:3px 10px; border-radius:20px; font-size:.75rem; font-weight:700; }
    select.role-select { padding:5px 8px; border-radius:var(--radius); border:1.5px solid var(--color-outline); font-size:.85rem; }
    .btn-update  { padding:5px 12px; background:var(--color-secondary); color:#fff; border:none; border-radius:var(--radius); cursor:pointer; font-size:.82rem; font-weight:600; margin-right:4px; }
    .btn-update:hover { background:var(--color-secondary-hover); }
    .btn-approve { padding:5px 12px; background:#059669; color:#fff; border:none; border-radius:var(--radius); cursor:pointer; font-size:.82rem; font-weight:600; }
    .btn-approve:hover { background:#047857; }
    .btn-del     { padding:5px 12px; background:var(--color-error); color:#fff; border:none; border-radius:var(--radius); cursor:pointer; font-size:.82rem; font-weight:600; }
    .btn-del:hover { background:#93000a; }
    .actions-cell { display:flex; gap:6px; align-items:center; flex-wrap:wrap; }
  </style>
</head>
<body>
<div class="admin-wrap">
  <jsp:include page="_sidebar.jsp">
    <jsp:param name="activePage" value="users"/>
  </jsp:include>
  <div class="main-content">
    <h1>👥 User Management</h1>

    <c:if test="${not empty errorMessage}">
      <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
    </c:if>

    <table>
      <thead>
        <tr>
          <th>#</th>
          <th>Full Name</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Role</th>
          <th>Status</th>
          <th>Joined</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="u" items="${users}" varStatus="s">
          <tr>
            <td>${s.count}</td>
            <td><strong>${fn:escapeXml(u.fullName)}</strong></td>
            <td>${fn:escapeXml(u.email)}</td>
            <td>${fn:escapeXml(u.phone)}</td>
            <td>
              <c:choose>
                <c:when test="${u.roleId == 1}"><span class="badge-admin">ADMIN</span></c:when>
                <c:otherwise><span class="badge-user">USER</span></c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${u.status == 'Approved'}"><span class="badge-approved">Approved</span></c:when>
                <c:when test="${u.status == 'Rejected'}"><span class="badge-rejected">Rejected</span></c:when>
                <c:otherwise><span class="badge-pending">Pending</span></c:otherwise>
              </c:choose>
            </td>
            <td>${u.createdAt}</td>
            <td>
              <div class="actions-cell">
                <%-- Approve / Reject for Pending users --%>
                <c:if test="${u.status == 'Pending'}">
                  <form action="${pageContext.request.contextPath}/admin/users" method="post">
                    <input type="hidden" name="userId" value="${u.id}"/>
                    <input type="hidden" name="action" value="approve"/>
                    <button type="submit" class="btn-approve">Approve</button>
                  </form>
                  <form action="${pageContext.request.contextPath}/admin/users" method="post">
                    <input type="hidden" name="userId" value="${u.id}"/>
                    <input type="hidden" name="action" value="reject"/>
                    <button type="submit" class="btn-del">Reject</button>
                  </form>
                </c:if>
                <%-- Change role --%>
<c:if test="${u.id != sessionScope.loggedInUser.id}">

  <form action="${pageContext.request.contextPath}/admin/users" method="post"
        style="display:flex; gap:4px; align-items:center;">

    <input type="hidden" name="userId" value="${u.id}"/>
    <input type="hidden" name="action" value="role"/>

    <select name="roleId" class="role-select">
      <option value="1" ${u.roleId == 1 ? 'selected' : ''}>ADMIN</option>
      <option value="2" ${u.roleId == 2 ? 'selected' : ''}>USER</option>
    </select>

    <button type="submit" class="btn-update">Save</button>

  </form>

</c:if>
                <%-- Delete --%>
                <c:if test="${u.id != sessionScope.loggedInUser.id}">
                  <form action="${pageContext.request.contextPath}/admin/users" method="post"
                        onsubmit="return confirm('Delete ${fn:escapeXml(u.fullName)}? This cannot be undone.');">
                    <input type="hidden" name="userId" value="${u.id}"/>
                    <input type="hidden" name="action" value="delete"/>
                    <button type="submit" class="btn-del">Delete</button>
                  </form>
                </c:if>
              </div>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>