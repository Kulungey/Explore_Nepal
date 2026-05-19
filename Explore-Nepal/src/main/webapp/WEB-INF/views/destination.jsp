<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>${fn:escapeXml(destination.name)} — Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

  <jsp:include page="_nav.jsp">
    <jsp:param name="activePage" value="home"/>
  </jsp:include>

  <main class="section">
    <div class="container" style="max-width:860px;">

      <c:if test="${empty destination}">
        <div class="alert alert-error">Destination not found.</div>
      </c:if>

      <c:if test="${not empty destination}">

        <%-- Hero image --%>
        <div style="border-radius:var(--radius-lg); overflow:hidden; aspect-ratio:16/7; background:var(--color-surface-low); margin-bottom:var(--sp-5);">
          <c:choose>
            <c:when test="${not empty destination.imageUrl}">
              <img src="${fn:escapeXml(destination.imageUrl)}" alt="${fn:escapeXml(destination.name)}"
                   style="width:100%; height:100%; object-fit:cover;"/>
            </c:when>
            <c:otherwise>
              <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;color:var(--color-slate-gray);font-weight:600;">No Image</div>
            </c:otherwise>
          </c:choose>
        </div>

        <%-- Title row --%>
        <div style="display:flex; justify-content:space-between; align-items:flex-start; flex-wrap:wrap; gap:var(--sp-3); margin-bottom:var(--sp-3);">
          <div>
            <h1 style="font-size:var(--text-3xl); font-weight:700; color:var(--color-primary);"><c:out value="${destination.name}"/></h1>
            <div style="display:flex; gap:8px; margin-top:8px; flex-wrap:wrap;">
              <c:if test="${not empty destination.category}">
                <span class="badge badge-blue"><c:out value="${destination.category}"/></span>
              </c:if>
              <c:choose>
                <c:when test="${destination.difficulty eq 'Hard'}"><span class="badge badge-red"><c:out value="${destination.difficulty}"/></span></c:when>
                <c:when test="${destination.difficulty eq 'Moderate'}"><span class="badge badge-orange"><c:out value="${destination.difficulty}"/></span></c:when>
                <c:otherwise><span class="badge badge-green"><c:out value="${destination.difficulty}"/></span></c:otherwise>
              </c:choose>
            </div>
          </div>
          <div style="text-align:right;">
            <div style="font-size:var(--text-3xl); font-weight:700; color:var(--color-secondary);">$<c:out value="${destination.price}"/></div>
            <div style="font-size:var(--text-sm); color:var(--color-slate-gray);">per person</div>
          </div>
        </div>

        <%-- Meta chips --%>
        <div style="display:flex; gap:var(--sp-3); flex-wrap:wrap; margin-bottom:var(--sp-4); padding:var(--sp-3); background:var(--color-surface-low); border-radius:var(--radius-lg);">
          <div style="display:flex;align-items:center;gap:6px;font-size:var(--text-sm);">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
            <c:out value="${destination.location}"/>
          </div>
          <div style="display:flex;align-items:center;gap:6px;font-size:var(--text-sm);">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
            <c:out value="${destination.durationDays}"/> days
          </div>
          <div style="display:flex;align-items:center;gap:6px;font-size:var(--text-sm);">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
            <c:out value="${destination.region}"/>
          </div>
        </div>

        <%-- Description --%>
        <div style="background:#fff; border-radius:var(--radius-lg); padding:var(--sp-4); box-shadow:var(--shadow-card); border:1px solid var(--color-outline-variant); margin-bottom:var(--sp-5);">
          <h2 style="font-size:var(--text-xl); font-weight:600; margin-bottom:var(--sp-2);">About This Destination</h2>
          <p style="color:var(--color-on-surface-variant); line-height:1.75;"><c:out value="${destination.description}"/></p>
        </div>

        <%-- Book Now button — goes to payment gateway --%>
        <div style="text-align:center;">
          <a href="${pageContext.request.contextPath}/payment?destId=${destination.id}"
             class="btn btn-primary"
             style="font-size:var(--text-lg); padding:14px 48px; border-radius:var(--radius-lg);">
            Book Now — $<c:out value="${destination.price}"/>
          </a>
          <p style="margin-top:12px; font-size:var(--text-sm); color:var(--color-slate-gray);">Secure checkout. No hidden fees.</p>
        </div>

      </c:if>
    </div>
  </main>

  <footer>
    <div class="container">
      <p>&copy; 2026 Explore Nepal. Built with Java EE &amp; JSP.</p>
    </div>
  </footer>

</body>
</html>