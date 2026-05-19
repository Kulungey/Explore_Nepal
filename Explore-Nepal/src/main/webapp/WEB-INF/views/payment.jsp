<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Secure Payment — Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
  <style>
    /* ── Payment page layout ── */
    .payment-wrapper {
      display: grid;
      grid-template-columns: 1fr 420px;
      gap: var(--sp-4);
      max-width: 900px;
      margin: var(--sp-6) auto;
      padding: 0 var(--gutter);
      align-items: start;
    }
    @media (max-width: 720px) {
      .payment-wrapper { grid-template-columns: 1fr; }
      .payment-summary { order: -1; }
    }

    /* ── Card visual mock ── */
    .card-visual {
      perspective: 1000px;
      height: 200px;
      margin-bottom: var(--sp-4);
    }
    .card-inner {
      position: relative;
      width: 100%;
      height: 100%;
      transform-style: preserve-3d;
      transition: transform 0.6s cubic-bezier(.4,0,.2,1);
    }
    .card-inner.flipped { transform: rotateY(180deg); }

    .card-face {
      position: absolute;
      inset: 0;
      border-radius: var(--radius-lg);
      backface-visibility: hidden;
      -webkit-backface-visibility: hidden;
      padding: 24px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      box-shadow: 0 20px 40px rgba(0,0,0,.25);
      background: linear-gradient(135deg, #0F172A 0%, #1E3A5F 50%, #0F172A 100%);
      color: #fff;
      font-family: 'Courier New', monospace;
      overflow: hidden;
    }
    .card-face::before {
      content: '';
      position: absolute;
      top: -40px; right: -40px;
      width: 200px; height: 200px;
      border-radius: 50%;
      background: rgba(245,158,11,.15);
    }
    .card-face::after {
      content: '';
      position: absolute;
      bottom: -60px; left: -40px;
      width: 220px; height: 220px;
      border-radius: 50%;
      background: rgba(245,158,11,.08);
    }
    .card-back { transform: rotateY(180deg); }

    .card-chip {
      width: 42px; height: 32px;
      border-radius: 6px;
      background: linear-gradient(135deg, #d4a017, #f0c040);
      display: grid;
      grid-template-columns: 1fr 1fr;
      grid-template-rows: 1fr 1fr;
      gap: 1px;
      padding: 2px;
    }
    .card-chip span {
      background: rgba(0,0,0,.15);
      border-radius: 2px;
    }

    .card-number-display {
      font-size: 1.3rem;
      letter-spacing: .15em;
      font-weight: 600;
      z-index: 1;
    }
    .card-bottom {
      display: flex;
      justify-content: space-between;
      align-items: flex-end;
      z-index: 1;
    }
    .card-label {
      font-size: .6rem;
      text-transform: uppercase;
      letter-spacing: .1em;
      opacity: .7;
      margin-bottom: 2px;
    }
    .card-value {
      font-size: .9rem;
      font-weight: 600;
      letter-spacing: .05em;
    }
    .card-brand {
      font-size: 1.2rem;
      font-weight: 700;
      font-style: italic;
      opacity: .9;
    }

    /* Back face */
    .card-stripe {
      background: rgba(0,0,0,.5);
      height: 48px;
      margin: 0 -24px;
      margin-top: 16px;
    }
    .card-cvv-row {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-top: 16px;
      padding: 0 8px;
    }
    .card-cvv-strip {
      flex: 1;
      height: 36px;
      background: #f0f0f0;
      border-radius: 4px;
      display: flex;
      align-items: center;
      justify-content: flex-end;
      padding-right: 12px;
      color: #0F172A;
      font-size: 1rem;
      letter-spacing: .3em;
    }
    .card-cvv-label {
      font-size: .65rem;
      opacity: .7;
      white-space: nowrap;
    }

    /* ── Form panel ── */
    .payment-form-panel {
      background: #fff;
      border-radius: var(--radius-lg);
      padding: var(--sp-4);
      box-shadow: var(--shadow-card);
      border: 1px solid var(--color-outline-variant);
    }
    .payment-form-panel h2 {
      font-size: var(--text-xl);
      font-weight: 700;
      color: var(--color-primary);
      margin-bottom: var(--sp-3);
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .form-row { margin-bottom: var(--sp-2); }
    .form-row label {
      display: block;
      font-size: var(--text-sm);
      font-weight: 600;
      color: var(--color-on-surface);
      margin-bottom: 6px;
    }
    .form-row input {
      width: 100%;
      padding: 11px 14px;
      border: 1.5px solid var(--color-outline);
      border-radius: var(--radius);
      font-size: var(--text-base);
      font-family: var(--font-base);
      background: var(--color-snow-white);
      transition: border-color .2s, box-shadow .2s;
      outline: none;
    }
    .form-row input:focus {
      border-color: var(--color-primary);
      box-shadow: 0 0 0 3px rgba(15,23,42,.08);
      background: #fff;
    }
    .form-half { display: grid; grid-template-columns: 1fr 1fr; gap: var(--sp-2); }
    .btn-pay {
      width: 100%;
      padding: 14px;
      margin-top: var(--sp-2);
      background: var(--color-secondary);
      color: #fff;
      font-size: var(--text-base);
      font-weight: 700;
      border: none;
      border-radius: var(--radius);
      cursor: pointer;
      letter-spacing: .03em;
      transition: background .2s, transform .1s;
    }
    .btn-pay:hover { background: var(--color-secondary-hover); }
    .btn-pay:active { transform: scale(.98); }

    /* ── Summary panel ── */
    .payment-summary {
      background: #fff;
      border-radius: var(--radius-lg);
      padding: var(--sp-3);
      box-shadow: var(--shadow-card);
      border: 1px solid var(--color-outline-variant);
    }
    .payment-summary h3 {
      font-size: var(--text-base);
      font-weight: 700;
      color: var(--color-primary);
      margin-bottom: var(--sp-2);
      padding-bottom: var(--sp-2);
      border-bottom: 1px solid var(--color-outline-variant);
    }
    .summary-row {
      display: flex;
      justify-content: space-between;
      font-size: var(--text-sm);
      margin-bottom: 10px;
      color: var(--color-on-surface-muted);
    }
    .summary-row.total {
      font-size: var(--text-base);
      font-weight: 700;
      color: var(--color-on-surface);
      padding-top: 10px;
      border-top: 1px solid var(--color-outline-variant);
      margin-top: 6px;
    }
    .summary-row.total span:last-child { color: var(--color-secondary); }

    .secure-note {
      display: flex;
      align-items: center;
      gap: 6px;
      font-size: var(--text-xs);
      color: var(--color-slate-gray);
      margin-top: var(--sp-2);
    }

    /* ── Error alert ── */
    .alert-error {
      background: var(--color-error-bg);
      color: var(--color-error);
      border: 1px solid #f5c6c6;
      border-radius: var(--radius);
      padding: 12px 16px;
      margin-bottom: var(--sp-2);
      font-size: var(--text-sm);
      font-weight: 500;
    }
  </style>
</head>
<body>

  <jsp:include page="_nav.jsp">
    <jsp:param name="activePage" value="home"/>
  </jsp:include>

  <main class="section">
    <div class="payment-wrapper">

      <%-- ── Left: form ── --%>
      <div>
        <%-- Animated card visual --%>
        <div class="card-visual">
          <div class="card-inner" id="cardInner">

            <%-- Front --%>
            <div class="card-face">
              <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                <div class="card-chip">
                  <span></span><span></span><span></span><span></span>
                </div>
                <div class="card-brand" id="cardBrand">VISA</div>
              </div>
              <div class="card-number-display" id="cardNumberDisplay">
                •••• &nbsp;•••• &nbsp;•••• &nbsp;••••
              </div>
              <div class="card-bottom">
                <div>
                  <div class="card-label">Card Holder</div>
                  <div class="card-value" id="cardHolderDisplay">FULL NAME</div>
                </div>
                <div>
                  <div class="card-label">Expires</div>
                  <div class="card-value" id="cardExpiryDisplay">MM/YY</div>
                </div>
              </div>
            </div>

            <%-- Back --%>
            <div class="card-face card-back">
              <div class="card-stripe"></div>
              <div class="card-cvv-row">
                <div class="card-cvv-strip" id="cardCvvDisplay">•••</div>
                <div class="card-cvv-label">CVV</div>
              </div>
            </div>

          </div>
        </div>

        <%-- Form panel --%>
        <div class="payment-form-panel">
          <h2>
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
            Card Details
          </h2>

          <c:if test="${not empty errorMsg}">
            <div class="alert-error">${fn:escapeXml(errorMsg)}</div>
          </c:if>

          <form action="${pageContext.request.contextPath}/payment/process" method="post" id="paymentForm">
            <input type="hidden" name="destId" value="${destination.id}"/>
            <input type="hidden" name="amount" value="${destination.price}"/>

            <div class="form-row">
              <label for="cardNumber">Card Number</label>
              <input type="text" id="cardNumber" name="cardNumber"
                     placeholder="1234  5678  9012  3456"
                     maxlength="22" autocomplete="cc-number" required/>
            </div>

            <div class="form-row">
              <label for="cardHolder">Cardholder Name</label>
              <input type="text" id="cardHolder" name="cardHolder"
                     placeholder="Name on card"
                     autocomplete="cc-name" required/>
            </div>

            <div class="form-half">
              <div class="form-row">
                <label for="expiry">Expiry Date</label>
                <input type="text" id="expiry" name="expiry"
                       placeholder="MM/YY" maxlength="5"
                       autocomplete="cc-exp" required/>
              </div>
              <div class="form-row">
                <label for="cvv">CVV</label>
                <input type="text" id="cvv" name="cvv"
                       placeholder="•••" maxlength="4"
                       autocomplete="cc-csc" required/>
              </div>
            </div>

            <button type="submit" class="btn-pay">
              Pay $<c:out value="${destination.price}"/>
            </button>
          </form>

          <div class="secure-note">
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
            256-bit SSL encryption. Your card data is never stored.
          </div>
        </div>
      </div>

      <%-- ── Right: order summary ── --%>
      <div class="payment-summary">
        <h3>Order Summary</h3>
        <c:if test="${not empty destination.imageUrl}">
          <img src="${fn:escapeXml(destination.imageUrl)}"
               alt="${fn:escapeXml(destination.name)}"
               style="width:100%; height:140px; object-fit:cover; border-radius:var(--radius); margin-bottom:var(--sp-2);"/>
        </c:if>
        <div class="summary-row">
          <span>Destination</span>
          <span><c:out value="${destination.name}"/></span>
        </div>
        <div class="summary-row">
          <span>Duration</span>
          <span><c:out value="${destination.durationDays}"/> days</span>
        </div>
        <div class="summary-row">
          <span>Difficulty</span>
          <span><c:out value="${destination.difficulty}"/></span>
        </div>
        <div class="summary-row">
          <span>Location</span>
          <span><c:out value="${destination.location}"/></span>
        </div>
        <div class="summary-row total">
          <span>Total</span>
          <span>$<c:out value="${destination.price}"/></span>
        </div>
        <a href="${pageContext.request.contextPath}/destination?id=${destination.id}"
           style="display:block; text-align:center; margin-top:12px; font-size:var(--text-sm); color:var(--color-slate-gray); text-decoration:underline;">
          ← Back to destination
        </a>
      </div>

    </div>
  </main>

  <footer>
    <div class="container">
      <p>&copy; 2026 Explore Nepal. Built with Java EE &amp; JSP.</p>
    </div>
  </footer>

  <script>
    // --- Live card preview ---
    const cardInner  = document.getElementById('cardInner');
    const numDisplay = document.getElementById('cardNumberDisplay');
    const holderDisp = document.getElementById('cardHolderDisplay');
    const expiryDisp = document.getElementById('cardExpiryDisplay');
    const cvvDisp    = document.getElementById('cardCvvDisplay');
    const brandDisp  = document.getElementById('cardBrand');

    // Card number: format with spaces, detect brand
    document.getElementById('cardNumber').addEventListener('input', function () {
    	let raw = this.value.replace(/\D/g, '').substring(0, 19);
      let formatted = raw.match(/.{1,4}/g)?.join('  ') || '';
      this.value = formatted;

      let display = (raw + '•'.repeat(Math.max(0, 16 - raw.length))).match(/.{1,4}/g).join(' '); 
      numDisplay.textContent = display;

      // Detect brand from first digit
      brandDisp.textContent =
        raw[0] === '4' ? 'Credit/Debit' :
        raw[0] === '5' ? 'Fonepay' :
        raw[0] === '3' ? 'Esewa' :
        raw[0] === '6' ? 'Mastercard' : 'VISA';
    });

    // Cardholder name
    document.getElementById('cardHolder').addEventListener('input', function () {
      holderDisp.textContent = this.value.toUpperCase() || 'FULL NAME';
    });

    // Expiry: auto-slash
    document.getElementById('expiry').addEventListener('input', function () {
      let raw = this.value.replace(/\D/g, '').substring(0, 4);
      if (raw.length >= 3) raw = raw.substring(0, 2) + '/' + raw.substring(2);
      this.value = raw;
      expiryDisp.textContent = raw || 'MM/YY';
    });

    // CVV: flip card on focus/blur
    const cvvInput = document.getElementById('cvv');
    cvvInput.addEventListener('focus',  () => cardInner.classList.add('flipped'));
    cvvInput.addEventListener('blur',   () => cardInner.classList.remove('flipped'));
    cvvInput.addEventListener('input',  function () {
      let raw = this.value.replace(/\D/g, '');
      this.value = raw;
      cvvDisp.textContent = '•'.repeat(raw.length) || '•••';
    });
  </script>

</body>
</html>