<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Explore Nepal — Discover the Himalayas</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

  <%-- ── Navigation ─────────────────────────────────────────── --%>
  <jsp:include page="_nav.jsp">
    <jsp:param name="activePage" value="home"/>
  </jsp:include>

  <%-- ── Hero ──────────────────────────────────────────────────── --%>
  <section class="hero">
    <div class="container">
      <h1>Discover the Soul of Nepal</h1>
      <p>From the peaks of Everest to the temples of Kathmandu — explore hand-curated destinations built for every type of adventurer.</p>
      <div class="hero-cta">
        <a href="#destinations" class="btn btn-primary">Browse Destinations</a>
        <a href="${pageContext.request.contextPath}/about" class="btn btn-secondary" style="color:#fff; border-color:rgba(255,255,255,.4);">Learn More</a>
      </div>
    </div>
  </section>

  <%-- ── Destinations Grid ──────────────────────────────────────── --%>
  <main class="section" id="destinations">
    <div class="container">

      <div class="page-header">
        <div>
          <h1>Our Destinations</h1>
          <p>A curated index of Nepal's premier locations across diverse terrain and difficulty levels.</p>
        </div>
        <span class="text-muted" style="font-size:.75rem; font-weight:600; text-transform:uppercase; letter-spacing:.08em;">
          ${fn:length(destinations)} Results
        </span>
      </div>

      <%-- Error state --%>
      <c:if test="${not empty errorMessage}">
        <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
      </c:if>

      <%-- Empty state --%>
      <c:if test="${empty destinations}">
        <div class="text-center" style="padding: 64px 0; color: var(--color-slate-gray);">
          <p style="font-size:1.125rem; font-weight:600;">No destinations available yet.</p>
          <p style="margin-top:8px; font-size:.875rem;">Check back soon — more adventures are being added.</p>
        </div>
      </c:if>

      <%-- Destination cards --%>
      <c:if test="${not empty destinations}">
        <div class="grid-4">
          <c:forEach var="dest" items="${destinations}" varStatus="status">
            <article class="card">

              <%-- Image --%>
              <div style="position:relative; overflow:hidden; aspect-ratio:16/9; background:var(--color-surface-low);">
                <c:choose>
                  <c:when test="${not empty dest.imageUrl}">
                    <img src="${fn:escapeXml(dest.imageUrl)}" alt="${fn:escapeXml(dest.name)}" class="card-img" loading="lazy"/>
                  </c:when>
                  <c:otherwise>
                    <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;background:var(--color-surface-low);color:var(--color-slate-gray);font-size:.75rem;font-weight:600;">
                      No Image
                    </div>
                  </c:otherwise>
                </c:choose>
                <span style="position:absolute;top:12px;right:12px;background:var(--color-primary);color:#fff;font-size:10px;font-weight:700;padding:2px 8px;border-radius:var(--radius-sm);">
                  <c:if test="${status.index + 1 lt 10}">0</c:if>${status.index + 1}
                </span>
              </div>

              <%-- Body --%>
              <div class="card-body">
                <div class="flex justify-between items-center">
                  <h3 class="card-title"><c:out value="${dest.name}"/></h3>
                  <span class="card-price">$<c:out value="${dest.price}"/></span>
                </div>

                <%-- Badges --%>
                <div class="flex flex-wrap" style="gap:6px; margin-top:4px;">
                  <c:if test="${not empty dest.category}">
                    <span class="badge badge-blue"><c:out value="${dest.category}"/></span>
                  </c:if>
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
                </div>

                <%-- Duration --%>
                <div class="card-meta">
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                  <span>${dest.durationDays} day<c:if test="${dest.durationDays ne 1}">s</c:if></span>
                  <c:if test="${not empty dest.location}">
                    &nbsp;·&nbsp;
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
                    <span><c:out value="${dest.location}"/></span>
                  </c:if>
                </div>
              </div>
            </article>
          </c:forEach>
        </div>
      </c:if>

    </div>
  </main>

  <%-- ── Footer ─────────────────────────────────────────────────── --%>
  <footer>
    <div class="container">
      <p>&copy; 2026 Explore Nepal. Built with Java EE &amp; JSP.</p>
    </div>
  </footer>

</body>
</html>
