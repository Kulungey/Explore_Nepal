<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Destinations - Admin | Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

  <jsp:include page="../_nav.jsp">
    <jsp:param name="activePage" value=""/>
  </jsp:include>

  <div class="admin-wrapper">

    <jsp:include page="_sidebar.jsp">
      <jsp:param name="activePage" value="destinations"/>
    </jsp:include>

    <main class="admin-content">

      <div class="page-header" style="margin-bottom:var(--sp-3);">
        <div>
          <h1>Destinations</h1>
          <p>Manage all trekking and travel destinations listed on the platform.</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/destination-form" class="btn btn-primary btn-sm">
          + Add Destination
        </a>
      </div>

      <c:if test="${not empty param.success}">
        <div class="alert alert-success"><c:out value="${param.success}"/></div>
      </c:if>
      <c:if test="${not empty param.error}">
        <div class="alert alert-error"><c:out value="${param.error}"/></div>
      </c:if>
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
      </c:if>

      <form action="${pageContext.request.contextPath}/admin/destinations" method="get"
            style="display:flex; gap:var(--sp-1); margin-bottom:var(--sp-3); max-width:480px;">
        <input class="form-input" type="text" name="q"
               value="${fn:escapeXml(searchQuery)}" placeholder="Search destinations"/>
        <button type="submit" class="btn btn-primary btn-sm">Search</button>
        <c:if test="${not empty searchQuery}">
          <a href="${pageContext.request.contextPath}/admin/destinations" class="btn btn-secondary btn-sm">Clear</a>
        </c:if>
      </form>

      <c:choose>
        <c:when test="${empty destinations}">
          <div style="text-align:center; padding:var(--sp-8) 0; color:var(--color-slate-gray);">
            <p style="font-size:var(--text-lg); font-weight:600;">No destinations found.</p>
            <p style="font-size:var(--text-sm); margin-top:8px;">
              <c:choose>
                <c:when test="${not empty searchQuery}">
                  No results for "<strong><c:out value="${searchQuery}"/></strong>". Try a different term.
                </c:when>
                <c:otherwise>
                  Start by <a href="${pageContext.request.contextPath}/admin/destination-form" style="color:var(--color-primary); font-weight:600;">adding your first destination</a>.
                </c:otherwise>
              </c:choose>
            </p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="table-wrapper">
            <table>
              <thead>
                <tr>
                  <th>#</th>
                  <th>Name</th>
                  <th>Location</th>
                  <th>Region</th>
                  <th>Category</th>
                  <th>Difficulty</th>
                  <th>Duration</th>
                  <th>Price (USD)</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="dest" items="${destinations}" varStatus="status">
                  <tr>
                    <td style="color:var(--color-slate-gray); font-size:var(--text-xs); font-weight:600;">${status.index + 1}</td>
                    <td>
                      <span style="font-weight:600; color:var(--color-primary);"><c:out value="${dest.name}"/></span>
                      <c:if test="${not empty dest.description}">
                        <div style="font-size:var(--text-xs); color:var(--color-slate-gray); margin-top:2px; max-width:220px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
                          <c:out value="${dest.description}"/>
                        </div>
                      </c:if>
                    </td>
                    <td><c:out value="${dest.location}"/></td>
                    <td>
                      <c:if test="${not empty dest.region}">
                        <span class="badge badge-slate"><c:out value="${dest.region}"/></span>
                      </c:if>
                    </td>
                    <td>
                      <c:if test="${not empty dest.category}">
                        <span class="badge badge-blue"><c:out value="${dest.category}"/></span>
                      </c:if>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${dest.difficulty eq 'Hard'}">
                          <span class="badge badge-red"><c:out value="${dest.difficulty}"/></span>
                        </c:when>
                        <c:when test="${dest.difficulty eq 'Moderate'}">
                          <span class="badge badge-orange"><c:out value="${dest.difficulty}"/></span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge badge-green"><c:out value="${dest.difficulty}"/></span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>${dest.durationDays} day<c:if test="${dest.durationDays ne 1}">s</c:if></td>
                    <td style="font-weight:600;">$<c:out value="${dest.price}"/></td>
                    <td>
                      <div class="table-actions">
                        <a href="${pageContext.request.contextPath}/admin/destination-form?id=${dest.id}"
                           class="action-link action-link-edit">Edit</a>

                        <form action="${pageContext.request.contextPath}/admin/destination-delete"
                              method="post"
                              class="js-delete-destination-form"
                              data-destination-name="${fn:escapeXml(dest.name)}"
                              style="display:inline;">
                          <input type="hidden" name="id" value="${dest.id}"/>
                          <button type="submit" class="action-link action-link-delete">Delete</button>
                        </form>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>

          <div style="margin-top:var(--sp-2); font-size:var(--text-xs); color:var(--color-slate-gray); font-weight:600; text-transform:uppercase; letter-spacing:.06em;">
            Showing ${fn:length(destinations)} destination<c:if test="${fn:length(destinations) ne 1}">s</c:if>
            <c:if test="${not empty searchQuery}"> for "<strong><c:out value="${searchQuery}"/></strong>"</c:if>
          </div>
        </c:otherwise>
      </c:choose>

    </main>
  </div>

</body>
</html>
