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
  <style>
    /* ── Hero animated gradient ── */
    @keyframes heroShift {
      0%   { background-position: 0% 50%; }
      50%  { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }
    .hero {
      background: linear-gradient(135deg, #0F172A 0%, #1E3A5F 40%, #0c2340 70%, #0F172A 100%);
      background-size: 300% 300%;
      animation: heroShift 10s ease infinite;
      padding: 100px var(--gutter) 80px;
      text-align: center;
      color: #fff;
      position: relative;
      overflow: hidden;
    }
    .hero::before {
      content: '';
      position: absolute;
      inset: 0;
      background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
    }
    @keyframes fadeInUp {
      from { opacity: 0; transform: translateY(40px); }
      to   { opacity: 1; transform: translateY(0); }
    }
    .hero-content { position: relative; z-index: 1; }
    .hero-badge {
      display: inline-block;
      background: rgba(245,158,11,.15);
      border: 1px solid rgba(245,158,11,.4);
      color: var(--color-secondary);
      font-size: var(--text-xs);
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: .12em;
      padding: 6px 16px;
      border-radius: var(--radius-full);
      margin-bottom: var(--sp-3);
      animation: fadeInUp 0.6s ease both;
    }
    .hero h1 {
      font-size: clamp(2rem, 5vw, 3.5rem);
      font-weight: 800;
      letter-spacing: -0.03em;
      line-height: 1.1;
      animation: fadeInUp 0.6s ease 0.1s both;
    }
    .hero h1 span { color: var(--color-secondary); }
    .hero p {
      font-size: var(--text-lg);
      color: #bec6e0;
      margin: var(--sp-2) auto 0;
      max-width: 600px;
      line-height: 1.7;
      animation: fadeInUp 0.6s ease 0.2s both;
    }
    .hero-cta {
      margin-top: var(--sp-4);
      display: flex;
      gap: var(--sp-2);
      justify-content: center;
      flex-wrap: wrap;
      animation: fadeInUp 0.6s ease 0.3s both;
    }
    .hero-scroll {
      margin-top: var(--sp-6);
      animation: fadeInUp 0.6s ease 0.4s both;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      font-size: var(--text-xs);
      color: rgba(255,255,255,.4);
      letter-spacing: .08em;
      text-transform: uppercase;
    }
    @keyframes bounce {
      0%, 100% { transform: translateY(0); }
      50%       { transform: translateY(6px); }
    }
    .hero-scroll svg { animation: bounce 1.5s ease infinite; }

    /* ── Stats strip ── */
    .stats-strip {
      background: var(--color-secondary);
      padding: var(--sp-3) 0;
    }
    .stats-inner {
      max-width: var(--container-max);
      margin: 0 auto;
      padding: 0 var(--gutter);
      display: flex;
      justify-content: space-around;
      flex-wrap: wrap;
      gap: var(--sp-2);
    }
    .stat-item { text-align: center; }
    .stat-num  { font-size: var(--text-2xl); font-weight: 800; color: var(--color-primary); line-height: 1; }
    .stat-lbl  { font-size: var(--text-xs); font-weight: 700; text-transform: uppercase; letter-spacing: .08em; color: rgba(15,23,42,.7); margin-top: 2px; }

    /* ── Why choose us ── */
    .features-section { padding: var(--sp-8) 0; background: #fff; }
    .features-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: var(--sp-3);
      margin-top: var(--sp-4);
    }
    @media (max-width: 768px) { .features-grid { grid-template-columns: 1fr; } }
    .feature-card {
      background: var(--color-snow-white);
      border-radius: var(--radius-lg);
      padding: var(--sp-4);
      text-align: center;
      border: 1px solid var(--color-outline-variant);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .feature-card:hover { transform: translateY(-4px); box-shadow: var(--shadow-card-hover); }
    .feature-icon { font-size: 2.5rem; margin-bottom: var(--sp-2); }
    .feature-title { font-size: var(--text-lg); font-weight: 700; color: var(--color-primary); margin-bottom: 8px; }
    .feature-desc  { font-size: var(--text-sm); color: var(--color-slate-gray); line-height: 1.6; }

    /* ── Destinations section ── */
    .dest-section { padding: var(--sp-8) 0; background: var(--color-snow-white); }
    .section-eyebrow {
      font-size: var(--text-xs);
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: .12em;
      color: var(--color-secondary);
      margin-bottom: 8px;
    }
    .section-heading { font-size: var(--text-2xl); font-weight: 800; color: var(--color-primary); letter-spacing: -0.02em; }
    .section-sub     { color: var(--color-slate-gray); margin-top: 8px; font-size: var(--text-base); }

    /* Search bar */
    .search-wrap {
      display: flex;
      gap: 10px;
      margin: var(--sp-4) 0;
      max-width: 520px;
    }
    .search-input {
      flex: 1;
      padding: 12px 16px;
      border: 1.5px solid var(--color-outline);
      border-radius: var(--radius);
      font-size: var(--text-base);
      font-family: var(--font-base);
      outline: none;
      transition: border-color .2s, box-shadow .2s;
    }
    .search-input:focus {
      border-color: var(--color-primary);
      box-shadow: 0 0 0 3px rgba(15,23,42,.08);
    }

    /* Cards */
    .card-link { text-decoration: none; color: inherit; display: block; }
    .dest-card {
      background: #fff;
      border-radius: var(--radius-lg);
      overflow: hidden;
      box-shadow: var(--shadow-card);
      border: 1px solid var(--color-outline-variant);
      transition: transform 0.3s cubic-bezier(.4,0,.2,1), box-shadow 0.3s ease;
    }
    .dest-card:hover { transform: translateY(-6px); box-shadow: var(--shadow-card-hover); }
    .dest-card-img {
      position: relative;
      overflow: hidden;
      aspect-ratio: 4/3;
      background: var(--color-surface-low);
    }
    .dest-card-img img { width:100%; height:100%; object-fit:cover; transition: transform 0.4s ease; }
    .dest-card:hover .dest-card-img img { transform: scale(1.05); }
    .dest-card-num {
      position: absolute; top: 12px; left: 12px;
      background: rgba(15,23,42,.7);
      color: #fff;
      font-size: 10px; font-weight: 700;
      padding: 3px 8px;
      border-radius: var(--radius-sm);
      backdrop-filter: blur(4px);
    }
    .dest-card-price {
      position: absolute; bottom: 12px; right: 12px;
      background: var(--color-secondary);
      color: var(--color-primary);
      font-size: var(--text-sm); font-weight: 800;
      padding: 4px 12px;
      border-radius: var(--radius-full);
    }
    .dest-card-body { padding: var(--sp-2) var(--sp-3) var(--sp-3); }
    .dest-card-title { font-size: var(--text-base); font-weight: 700; color: var(--color-primary); margin-bottom: 6px; }
    .dest-card-meta  { display:flex; align-items:center; gap:6px; font-size:var(--text-xs); color:var(--color-slate-gray); flex-wrap:wrap; }
    .dest-card-badges { display:flex; gap:4px; flex-wrap:wrap; margin-top:8px; }

    /* ── Testimonials ── */
    .testimonials-section { padding: var(--sp-8) 0; background: var(--color-primary); color: #fff; }
    .testimonials-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: var(--sp-3); margin-top: var(--sp-4); }
    @media (max-width: 768px) { .testimonials-grid { grid-template-columns: 1fr; } }
    .testimonial-card {
      background: rgba(255,255,255,.06);
      border: 1px solid rgba(255,255,255,.1);
      border-radius: var(--radius-lg);
      padding: var(--sp-3);
      backdrop-filter: blur(10px);
    }
    .testimonial-stars { color: var(--color-secondary); font-size: 1rem; margin-bottom: var(--sp-1); letter-spacing: 2px; }
    .testimonial-text  { font-size: var(--text-sm); color: #bec6e0; line-height: 1.7; margin-bottom: var(--sp-2); font-style: italic; }
    .testimonial-author { display:flex; align-items:center; gap:10px; }
    .testimonial-avatar {
      width: 38px; height: 38px; border-radius: 50%;
      background: var(--color-secondary);
      color: var(--color-primary);
      font-size: 13px; font-weight: 700;
      display: flex; align-items: center; justify-content: center;
      flex-shrink: 0;
    }
    .testimonial-name { font-size: var(--text-sm); font-weight: 700; color: #fff; }
    .testimonial-loc  { font-size: var(--text-xs); color: #64748b; }

    /* ── Footer expanded ── */
    .footer-expanded {
      background: #060d18;
      color: #bec6e0;
      padding: var(--sp-6) var(--gutter) var(--sp-4);
    }
    .footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: var(--sp-4); margin-bottom: var(--sp-4); }
    @media (max-width: 768px) { .footer-grid { grid-template-columns: 1fr; } }
    .footer-brand { font-size: var(--text-xl); font-weight: 700; color: #fff; margin-bottom: 8px; }
    .footer-tagline { font-size: var(--text-sm); line-height: 1.6; }
    .footer-heading { font-size: var(--text-xs); font-weight: 700; text-transform: uppercase; letter-spacing: .1em; color: #fff; margin-bottom: var(--sp-2); }
    .footer-links { display: flex; flex-direction: column; gap: 8px; }
    .footer-links a { font-size: var(--text-sm); color: #bec6e0; transition: color .2s; }
    .footer-links a:hover { color: var(--color-secondary); }
    .footer-bottom { border-top: 1px solid rgba(255,255,255,.08); padding-top: var(--sp-2); text-align: center; font-size: var(--text-xs); color: #475569; }

    /* ── Scroll reveal ── */
    .reveal { opacity: 0; transform: translateY(30px); transition: opacity 0.6s ease, transform 0.6s ease; }
    .reveal.visible { opacity: 1; transform: translateY(0); }
    .reveal-delay-1 { transition-delay: 0.1s; }
    .reveal-delay-2 { transition-delay: 0.2s; }
    .reveal-delay-3 { transition-delay: 0.3s; }
  </style>
</head>
<body>

  <jsp:include page="_nav.jsp">
    <jsp:param name="activePage" value="home"/>
  </jsp:include>

  <%-- ── HERO ── --%>
  <section class="hero">
    <div class="hero-content">
      <div class="hero-badge">🏔 Nepal's #1 Adventure Platform</div>
      <h1>Discover the Soul of <span>Nepal</span></h1>
      <p>From the frozen peaks of Everest to the ancient temples of Kathmandu — hand-curated destinations for every type of adventurer.</p>
      <div class="hero-cta">
        <a href="#destinations" class="btn btn-primary" style="padding:14px 28px; font-size:var(--text-base);">Browse Destinations</a>
        <a href="${pageContext.request.contextPath}/about" class="btn btn-secondary"
           style="color:#fff; border-color:rgba(255,255,255,.3); padding:14px 28px; font-size:var(--text-base);">
          Learn More
        </a>
      </div>
      <div class="hero-scroll">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>
        Scroll to explore
      </div>
    </div>
  </section>

  <%-- ── STATS STRIP ── --%>
  <div class="stats-strip">
    <div class="stats-inner">
      <div class="stat-item">
        <div class="stat-num">${fn:length(destinations)}+</div>
        <div class="stat-lbl">Destinations</div>
      </div>
      <div class="stat-item">
        <div class="stat-num">5</div>
        <div class="stat-lbl">Regions</div>
      </div>
      <div class="stat-item">
        <div class="stat-num">8,849m</div>
        <div class="stat-lbl">Highest Peak</div>
      </div>
      <div class="stat-item">
        <div class="stat-num">100%</div>
        <div class="stat-lbl">Safe Treks</div>
      </div>
      <div class="stat-item">
        <div class="stat-num">24/7</div>
        <div class="stat-lbl">Support</div>
      </div>
    </div>
  </div>

  <%-- ── WHY CHOOSE US ── --%>
  <section class="features-section">
    <div class="container">
      <div class="reveal" style="text-align:center;">
        <div class="section-eyebrow">Why Explore Nepal</div>
        <h2 class="section-heading">Adventure, Done Right</h2>
        <p class="section-sub">We don't just book trips — we craft journeys that stay with you forever.</p>
      </div>
      <div class="features-grid">
        <div class="feature-card reveal reveal-delay-1">
          <div class="feature-icon">🧭</div>
          <div class="feature-title">Expert Local Guides</div>
          <div class="feature-desc">Every route is led by certified Nepali guides with decades of mountain experience. Your safety is never negotiable.</div>
        </div>
        <div class="feature-card reveal reveal-delay-2">
          <div class="feature-icon">🏅</div>
          <div class="feature-title">Curated Itineraries</div>
          <div class="feature-desc">Each destination is hand-picked and reviewed. No generic packages — every itinerary is tailored to the terrain and traveller.</div>
        </div>
        <div class="feature-card reveal reveal-delay-3">
          <div class="feature-icon">💳</div>
          <div class="feature-title">Transparent Pricing</div>
          <div class="feature-desc">What you see is what you pay. No hidden fees, no last-minute surprises. Secure checkout with instant booking confirmation.</div>
        </div>
      </div>
    </div>
  </section>

  <%-- ── DESTINATIONS ── --%>
  <section class="dest-section" id="destinations">
    <div class="container">

      <div class="reveal" style="display:flex; justify-content:space-between; align-items:flex-end; flex-wrap:wrap; gap:var(--sp-2);">
        <div>
          <div class="section-eyebrow">Explore</div>
          <h2 class="section-heading">Our Destinations</h2>
          <p class="section-sub">
            <c:choose>
              <c:when test="${not empty searchKeyword}">
                Showing <strong>${fn:length(destinations)}</strong> results for "<strong>${fn:escapeXml(searchKeyword)}</strong>"
              </c:when>
              <c:otherwise>
                ${fn:length(destinations)} curated adventures across Nepal
              </c:otherwise>
            </c:choose>
          </p>
        </div>
      </div>

      <%-- Search --%>
      <form action="${pageContext.request.contextPath}/home" method="get" class="search-wrap">
        <input type="text" name="search" class="search-input"
               value="${fn:escapeXml(searchKeyword)}"
               placeholder="Search by name, region, category…"/>
        <button type="submit" class="btn btn-primary">Search</button>
        <c:if test="${not empty searchKeyword}">
          <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">Clear</a>
        </c:if>
      </form>

      <c:if test="${not empty errorMessage}">
        <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
      </c:if>

      <c:if test="${empty destinations}">
        <div style="text-align:center; padding:64px 0; color:var(--color-slate-gray);">
          <p style="font-size:1.125rem; font-weight:600;">No destinations found.</p>
          <p style="margin-top:8px; font-size:.875rem;">Try a different search term.</p>
          <a href="${pageContext.request.contextPath}/home" class="btn btn-primary" style="margin-top:var(--sp-2);">View All</a>
        </div>
      </c:if>

      <c:if test="${not empty destinations}">
        <div class="grid-4" style="margin-top:var(--sp-3);">
          <c:forEach var="dest" items="${destinations}" varStatus="status">
            <a href="${pageContext.request.contextPath}/destination?id=${dest.id}" class="card-link reveal">
              <article class="dest-card">
                <div class="dest-card-img">
                  <c:choose>
                    <c:when test="${not empty dest.imageUrl}">
                      <img src="${fn:escapeXml(dest.imageUrl)}" alt="${fn:escapeXml(dest.name)}" loading="lazy"/>
                    </c:when>
                    <c:otherwise>
                      <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;background:var(--color-surface-low);color:var(--color-slate-gray);font-size:.75rem;font-weight:600;">No Image</div>
                    </c:otherwise>
                  </c:choose>
                  <span class="dest-card-num">
                    <c:if test="${status.index + 1 lt 10}">0</c:if>${status.index + 1}
                  </span>
                  <span class="dest-card-price">$<c:out value="${dest.price}"/></span>
                </div>
                <div class="dest-card-body">
                  <div class="dest-card-title"><c:out value="${dest.name}"/></div>
                  <div class="dest-card-meta">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                    ${dest.durationDays} day<c:if test="${dest.durationDays ne 1}">s</c:if>
                    <c:if test="${not empty dest.location}">
                      &nbsp;·&nbsp;
                      <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
                      <c:out value="${dest.location}"/>
                    </c:if>
                    <c:if test="${not empty dest.region}">
                      &nbsp;·&nbsp; <c:out value="${dest.region}"/>
                    </c:if>
                  </div>
                  <div class="dest-card-badges">
                    <c:if test="${not empty dest.category}">
                      <span class="badge badge-blue"><c:out value="${dest.category}"/></span>
                    </c:if>
                    <c:choose>
                      <c:when test="${dest.difficulty eq 'Hard'}"><span class="badge badge-red"><c:out value="${dest.difficulty}"/></span></c:when>
                      <c:when test="${dest.difficulty eq 'Moderate'}"><span class="badge badge-orange"><c:out value="${dest.difficulty}"/></span></c:when>
                      <c:otherwise><span class="badge badge-green"><c:out value="${dest.difficulty}"/></span></c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </article>
            </a>
          </c:forEach>
        </div>
      </c:if>

    </div>
  </section>

  <%-- ── TESTIMONIALS ── --%>
  <section class="testimonials-section">
    <div class="container">
      <div class="reveal" style="text-align:center;">
        <div class="section-eyebrow" style="color:var(--color-secondary);">Traveller Stories</div>
        <h2 class="section-heading" style="color:#fff;">What Our Adventurers Say</h2>
      </div>
      <div class="testimonials-grid" style="margin-top:var(--sp-4);">
        <div class="testimonial-card reveal reveal-delay-1">
          <div class="testimonial-stars">★★★★★</div>
          <div class="testimonial-text">"The Everest Base Camp trek was the most transformative experience of my life. The guides were incredibly knowledgeable and the booking process was seamless."</div>
          <div class="testimonial-author">
            <div class="testimonial-avatar">JM</div>
            <div>
              <div class="testimonial-name">James Mitchell</div>
              <div class="testimonial-loc">🇬🇧 London, UK</div>
            </div>
          </div>
        </div>
        <div class="testimonial-card reveal reveal-delay-2">
          <div class="testimonial-stars">★★★★★</div>
          <div class="testimonial-text">"I was worried about trekking solo but the team made me feel completely safe. Annapurna Circuit was breathtaking — every rupee was worth it."</div>
          <div class="testimonial-author">
            <div class="testimonial-avatar" style="background:#7c3aed;">SK</div>
            <div>
              <div class="testimonial-name">Sara Kim</div>
              <div class="testimonial-loc">🇰🇷 Seoul, South Korea</div>
            </div>
          </div>
        </div>
        <div class="testimonial-card reveal reveal-delay-3">
          <div class="testimonial-stars">★★★★★</div>
          <div class="testimonial-text">"Booked the Chitwan safari package and it exceeded all expectations. The wildlife, the people, the culture — Nepal is truly magical."</div>
          <div class="testimonial-author">
            <div class="testimonial-avatar" style="background:#065f46;">AR</div>
            <div>
              <div class="testimonial-name">Aisha Rahman</div>
              <div class="testimonial-loc">🇦🇪 Dubai, UAE</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <jsp:include page="_footer.jsp"/>

  <script>
    // Scroll reveal
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
    }, { threshold: 0.12 });
    document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
  </script>

</body>
</html>