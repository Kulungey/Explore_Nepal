<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Contact — Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

  <jsp:include page="_nav.jsp">
    <jsp:param name="activePage" value="contact"/>
  </jsp:include>

  <main class="section">
    <div class="container" style="max-width:900px;">

      <div class="page-header">
        <div>
          <h1>Get in Touch</h1>
          <p>Have a question or need help planning your trip? We'd love to hear from you.</p>
        </div>
      </div>
      

      <div class="grid-2" style="gap:var(--sp-6); align-items:start;">

        <%-- ── Contact Form ─────────────────────────────────────── --%>
        <div style="background:#fff; border-radius:var(--radius-lg); padding:var(--sp-4); box-shadow:var(--shadow-card); border:1px solid var(--color-outline-variant);">
          <h2 style="font-size:var(--text-xl); font-weight:600; color:var(--color-primary); margin-bottom:var(--sp-3);">Send us a Message</h2>

          <c:if test="${not empty successMessage}">
            <div class="alert alert-success"><c:out value="${successMessage}"/></div>
          </c:if>
          <c:if test="${not empty errorMessage}">
            <div class="alert alert-error"><c:out value="${errorMessage}"/></div>
          </c:if>

          <form action="${pageContext.request.contextPath}/contact" method="post"
                style="display:flex; flex-direction:column; gap:var(--sp-2);" novalidate>

            <div class="form-group">
              <label class="form-label" for="name">Full Name</label>
              <input class="form-input" type="text" id="name" name="name"
                     value="${fn:escapeXml(nameValue)}" placeholder="Aarav Sharma" required/>
            </div>

            <div class="form-group">
              <label class="form-label" for="email">Email Address</label>
              <input class="form-input" type="email" id="email" name="email"
                     value="${fn:escapeXml(emailValue)}" placeholder="you@example.com" required/>
            </div>

            <div class="form-group">
              <label class="form-label" for="subject">Subject</label>
              <input class="form-input" type="text" id="subject" name="subject"
                     value="${fn:escapeXml(subjectValue)}" placeholder="Trekking inquiry, booking help…" required/>
            </div>

            <div class="form-group">
              <label class="form-label" for="message">Message</label>
              <textarea class="form-textarea" id="message" name="message"
                        placeholder="Tell us how we can help…" required><c:out value="${messageValue}"/></textarea>
            </div>

            <button type="submit" class="btn btn-primary btn-full" style="margin-top:var(--sp-1);">
              Send Message
            </button>
          </form>
        </div>

        <%-- ── Contact Info ─────────────────────────────────────── --%>
        <div style="display:flex; flex-direction:column; gap:var(--sp-3);">

          <%-- Info card helper macro via repeated markup --%>
          <div class="stat-card">
            <div style="display:flex; align-items:center; gap:var(--sp-2);">
              <div style="width:40px;height:40px;background:var(--color-primary);border-radius:var(--radius);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
              </div>
              <div>
                <div style="font-size:var(--text-xs);text-transform:uppercase;letter-spacing:.08em;font-weight:600;color:var(--color-slate-gray);">Address</div>
                <div style="font-size:var(--text-sm); color:var(--color-primary); font-weight:500; margin-top:2px;">Thamel, Kathmandu 44600, Nepal</div>
              </div>
            </div>
          </div>

          <div class="stat-card">
            <div style="display:flex; align-items:center; gap:var(--sp-2);">
              <div style="width:40px;height:40px;background:var(--color-primary);border-radius:var(--radius);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 12a19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 3.6 1.27h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.91 8a16 16 0 0 0 6.08 6.08l.91-.91a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
              </div>
              <div>
                <div style="font-size:var(--text-xs);text-transform:uppercase;letter-spacing:.08em;font-weight:600;color:var(--color-slate-gray);">Phone</div>
                <div style="font-size:var(--text-sm); color:var(--color-primary); font-weight:500; margin-top:2px;">+977-01-4XXXXXX</div>
              </div>
            </div>
          </div>

          <div class="stat-card">
            <div style="display:flex; align-items:center; gap:var(--sp-2);">
              <div style="width:40px;height:40px;background:var(--color-primary);border-radius:var(--radius);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
              </div>
              <div>
                <div style="font-size:var(--text-xs);text-transform:uppercase;letter-spacing:.08em;font-weight:600;color:var(--color-slate-gray);">Email</div>
                <div style="font-size:var(--text-sm); color:var(--color-primary); font-weight:500; margin-top:2px;">info@explorenepal.com</div>
              </div>
            </div>
          </div>

          <div class="stat-card">
            <div style="display:flex; align-items:center; gap:var(--sp-2);">
              <div style="width:40px;height:40px;background:var(--color-primary);border-radius:var(--radius);display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
              </div>
              <div>
                <div style="font-size:var(--text-xs);text-transform:uppercase;letter-spacing:.08em;font-weight:600;color:var(--color-slate-gray);">Office Hours</div>
                <div style="font-size:var(--text-sm); color:var(--color-primary); font-weight:500; margin-top:2px;">Sun – Fri &nbsp;|&nbsp; 9:00 AM – 6:00 PM NPT</div>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
<%-- ── Team Section ───────────────────────────────────────── --%>
<div style="margin-top:var(--sp-6); text-align:center;">

  <h2 style="font-size:var(--text-2xl); color:var(--color-primary); margin-bottom:var(--sp-4);">
    Meet Our Team
  </h2>

  <div style="display:flex; justify-content:center; gap:var(--sp-5); flex-wrap:wrap;">

    <%-- Team Member 1 --%>
    <div style="text-align:center;">
      <img
        src="${pageContext.request.contextPath}/images/ayush.jpg"
        alt="Team Member 1"
        style="width:140px; height:140px; object-fit:cover; border-radius:50%; border:4px solid #fff; box-shadow:var(--shadow-card);"
      />
      <p style="margin-top:var(--sp-2); font-weight:600; color:var(--color-primary);">
        Ayush Rai
      </p>
    </div>

    <%-- Team Member 2 --%>
    <div style="text-align:center;">
      <img
        src="${pageContext.request.contextPath}/images/kamchor.jpg"
        alt="Team Member 2"
        style="width:140px; height:140px; object-fit:cover; border-radius:50%; border:4px solid #fff; box-shadow:var(--shadow-card);"
      />
      <p style="margin-top:var(--sp-2); font-weight:600; color:var(--color-primary);">
        Amitabh Manandhar
      </p>
    </div>

    <%-- Team Member 3 --%>
    <div style="text-align:center;">
      <img
        src="${pageContext.request.contextPath}/images/kamchor-2.jpg"
        alt="Team Member 3"
        style="width:140px; height:140px; object-fit:cover; border-radius:50%; border:4px solid #fff; box-shadow:var(--shadow-card);"
      />
      <p style="margin-top:var(--sp-2); font-weight:600; color:var(--color-primary);">
        Rising Maharjan
      </p>
    </div>

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
