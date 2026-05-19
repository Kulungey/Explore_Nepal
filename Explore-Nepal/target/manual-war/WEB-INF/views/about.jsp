<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>About — Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

  <jsp:include page="_nav.jsp">
    <jsp:param name="activePage" value="about"/>
  </jsp:include>

  <%-- ── Page Hero ───────────────────────────────────────────────── --%>
  <section style="background:var(--color-primary); color:#fff; padding:var(--sp-8) var(--gutter); text-align:center;">
    <div class="container">
      <h1 style="font-size:var(--text-4xl); font-weight:700; letter-spacing:-0.02em; line-height:1.2;">
        About Explore Nepal
      </h1>
      <p style="font-size:var(--text-lg); color:#bec6e0; margin-top:var(--sp-2); max-width:600px; margin-left:auto; margin-right:auto;">
        We are a team of passionate explorers dedicated to helping travellers discover the breathtaking landscapes, rich culture, and spiritual heritage of Nepal.
      </p>
    </div>
  </section>

  <main class="section">
    <div class="container" style="max-width:860px;">

      <%-- ── Mission ─────────────────────────────────────────────── --%>
      <section style="margin-bottom:var(--sp-6);">
        <div class="page-header">
          <div>
            <h2 class="section-title">Our Mission</h2>
          </div>
        </div>
        <p style="color:var(--color-on-surface-muted); line-height:1.8; font-size:var(--text-lg);">
          Explore Nepal was founded with a single purpose: to make the wonders of Nepal accessible to every kind of traveller. Whether you seek the raw challenge of high-altitude trekking, the tranquility of ancient temples, or the warmth of local village life, our platform curates authentic, responsible experiences that honour both travellers and the communities they visit.
        </p>
      </section>

      <%-- ── Values grid ─────────────────────────────────────────── --%>
      <section style="margin-bottom:var(--sp-6);">
        <h2 class="section-title" style="margin-bottom:var(--sp-3);">What We Stand For</h2>
        <div class="grid-3" style="gap:var(--sp-3);">

          <div class="stat-card">
            <div style="width:40px;height:40px;background:var(--color-primary);border-radius:var(--radius);display:flex;align-items:center;justify-content:center;">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
            </div>
            <h3 style="font-weight:600; color:var(--color-primary); margin-top:var(--sp-1);">Community First</h3>
            <p style="font-size:var(--text-sm); color:var(--color-slate-gray); line-height:1.7;">Every itinerary is built in partnership with local guides and communities, ensuring tourism benefits those who call Nepal home.</p>
            <div class="stat-accent"></div>
          </div>

          <div class="stat-card">
            <div style="width:40px;height:40px;background:var(--color-primary);border-radius:var(--radius);display:flex;align-items:center;justify-content:center;">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>
            </div>
            <h3 style="font-weight:600; color:var(--color-primary); margin-top:var(--sp-1);">Sustainable Travel</h3>
            <p style="font-size:var(--text-sm); color:var(--color-slate-gray); line-height:1.7;">We promote low-impact trekking, responsible waste management, and culturally sensitive tourism across all our destinations.</p>
            <div class="stat-accent"></div>
          </div>

          <div class="stat-card">
            <div style="width:40px;height:40px;background:var(--color-primary);border-radius:var(--radius);display:flex;align-items:center;justify-content:center;">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
            </div>
            <h3 style="font-weight:600; color:var(--color-primary); margin-top:var(--sp-1);">Safety &amp; Reliability</h3>
            <p style="font-size:var(--text-sm); color:var(--color-slate-gray); line-height:1.7;">All destinations are vetted by experienced mountaineers. We provide up-to-date trail conditions, permit information, and emergency contacts.</p>
            <div class="stat-accent"></div>
          </div>

        </div>
      </section>

      <%-- ── Stats ───────────────────────────────────────────────── --%>
      <section style="background:var(--color-primary);border-radius:var(--radius-lg);padding:var(--sp-6);color:#fff;margin-bottom:var(--sp-6);">
        <div class="grid-3" style="text-align:center;">
          <div>
            <div style="font-size:var(--text-4xl);font-weight:700;line-height:1;letter-spacing:-0.02em;">50+</div>
            <div style="font-size:var(--text-xs);text-transform:uppercase;letter-spacing:.1em;color:#bec6e0;margin-top:8px;font-weight:600;">Destinations</div>
          </div>
          <div style="border-left:1px solid rgba(255,255,255,.15); border-right:1px solid rgba(255,255,255,.15);">
            <div style="font-size:var(--text-4xl);font-weight:700;line-height:1;letter-spacing:-0.02em;">10K+</div>
            <div style="font-size:var(--text-xs);text-transform:uppercase;letter-spacing:.1em;color:#bec6e0;margin-top:8px;font-weight:600;">Happy Travellers</div>
          </div>
          <div>
            <div style="font-size:var(--text-4xl);font-weight:700;line-height:1;letter-spacing:-0.02em;">8</div>
            <div style="font-size:var(--text-xs);text-transform:uppercase;letter-spacing:.1em;color:#bec6e0;margin-top:8px;font-weight:600;">Years of Experience</div>
          </div>
        </div>
      </section>

      <%-- ── CTA ────────────────────────────────────────────────── --%>
      <section style="text-align:center; padding:var(--sp-4) 0;">
        <h2 style="font-size:var(--text-2xl); font-weight:600; color:var(--color-primary);">Ready to explore?</h2>
        <p style="color:var(--color-slate-gray); margin-top:8px; margin-bottom:var(--sp-3);">Browse our destinations or get in touch — our team is happy to help plan your journey.</p>
        <div style="display:flex; gap:var(--sp-2); justify-content:center; flex-wrap:wrap;">
          <a href="${pageContext.request.contextPath}/home"    class="btn btn-primary">View Destinations</a>
          <a href="${pageContext.request.contextPath}/contact" class="btn btn-secondary">Contact Us</a>
        </div>
      </section>

    </div>
  </main>

  <footer>
    <div class="container">
      <p>&copy; 2026 Explore Nepal. Built with Java EE &amp; JSP.</p>
    </div>
  </footer>

</body>
</html>
