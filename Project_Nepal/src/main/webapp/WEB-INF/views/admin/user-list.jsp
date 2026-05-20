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
    .badge-admin { background:#FEF3C7; color:#92400E; display:inline-block; padding:3px 10px; border-radius:20px; font-size:.75rem; font-weight:700; }
    .badge-user  { background:#DBEAFE; color:#1E40AF; display:inline-block; padding:3px 10px; border-radius:20px; font-size:.75rem; font-weight:700; }
    select.role-select { padding:5px 8px; border-radius:var(--radius); border:1.5px solid var(--color-outline); font-size:.85rem; }
    .btn-update { padding:5px 12px; background:var(--color-secondary); color:#fff; border:none; border-radius:var(--radius); cursor:pointer; font-size:.82rem; font-weight:600; }
    .btn-update:hover { background:var(--color-secondary-hover); }
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
          <th>Joined</th>
          <th>Change Role</th>
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
            <td>${u.createdAt}</td>
            <td>
              <form action="${pageContext.request.contextPath}/admin/users" method="post"
                    style="display:flex; gap:6px; align-items:center;">
                <input type="hidden" name="userId" value="${u.id}"/>
                <select name="roleId" class="role-select">
                  <option value="1" ${u.roleId == 1 ? 'selected' : ''}>ADMIN</option>
                  <option value="2" ${u.roleId == 2 ? 'selected' : ''}>USER</option>
                </select>
                <button type="submit" class="btn-update">Save</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>