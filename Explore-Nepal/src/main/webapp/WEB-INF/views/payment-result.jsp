<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Payment ${success ? 'Successful' : 'Failed'} — Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
  <style>
    .result-card { max-width:480px; margin:60px auto; background:#fff; border-radius:var(--radius-lg); padding:var(--sp-6); box-shadow:var(--shadow-card); border:1px solid var(--color-outline-variant); text-align:center; }
    .icon-circle { width:80px; height:80px; border-radius:50%; display:flex; align-items:center; justify-content:center; margin:0 auto var(--sp-4); }
    .icon-circle.success { background:#dcfce7; }
    .icon-circle.fail    { background:#fee2e2; }
    .ref-box { background:var(--color-surface-low); border-radius:var(--radius); padding:var(--sp-2) var(--sp-3); font-family:'Courier New',monospace; font-size:.9rem; color:var(--color-primary); margin:var(--sp-3) 0; }
  </style>
</head>
<body>

  <jsp:include page="_nav.jsp"/>

  <main class="section">
    <div class="container">
      <div class="result-card">

        <c:choose>
          <c:when test="${success}">
            <div class="icon-circle success">
              <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#16a34a" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <h1 style="font-size:var(--text-2xl); font-weight:700; color:#15803d;">Booking Confirmed!</h1>
            <p style="color:var(--color-slate-gray); margin-top:8px;">Your trip to <strong><c:out value="${destinationName}"/></strong> is booked. Check your email for details.</p>
            <div class="ref-box">Ref: <c:out value="${bookingRef}"/></div>
            <div style="font-size:var(--text-sm); color:var(--color-slate-gray);">Amount charged: <strong>$<c:out value="${amount}"/></strong></div>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary" style="margin-top:var(--sp-4); display:inline-block;">Back to Destinations</a>
          </c:when>
          <c:otherwise>
            <div class="icon-circle fail">
              <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#dc2626" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
            </div>
            <h1 style="font-size:var(--text-2xl); font-weight:700; color:#dc2626;">Payment Failed</h1>
            <p style="color:var(--color-slate-gray); margin-top:8px;"><c:out value="${errorMsg}"/></p>
            <div style="display:flex; gap:var(--sp-2); justify-content:center; margin-top:var(--sp-4);">
              <a href="javascript:history.back()" class="btn btn-primary">Try Again</a>
              <a href="${pageContext.request.contextPath}/contact" class="btn btn-secondary">Contact Support</a>
            </div>
          </c:otherwise>
        </c:choose>

      </div>
    </div>
  </main>

  <footer>
    <div class="container">
      <p>&copy; 2026 Explore Nepal. Built with Java EE &amp; JSP.</p>
    </div>
  </footer>

</body>
</html>