<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>404 – Not Found | Explore Nepal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
  <style>
    .error-page {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      background: var(--color-snow-white);
      padding: var(--sp-4);
    }
    .error-card {
      text-align: center;
      max-width: 480px;
      width: 100%;
      background: var(--color-surface-card);
      border-radius: var(--radius-xl);
      padding: var(--sp-8) var(--sp-6);
      box-shadow: var(--shadow-card);
    }
    .error-code {
      font-size: 6rem;
      font-weight: 700;
      color: var(--color-outline);
      line-height: 1;
      margin-bottom: var(--sp-2);
      letter-spacing: -0.05em;
    }
    .error-icon { font-size: 3rem; margin-bottom: var(--sp-2); }
    .error-title {
      font-size: var(--text-xl);
      font-weight: 700;
      color: var(--color-primary);
      margin-bottom: var(--sp-1);
    }
    .error-desc {
      color: var(--color-on-surface-muted);
      font-size: var(--text-sm);
      margin-bottom: var(--sp-4);
      line-height: 1.6;
    }
    .error-actions {
      display: flex;
      gap: var(--sp-2);
      justify-content: center;
      flex-wrap: wrap;
    }
    .btn-primary {
      padding: 10px 24px;
      background: var(--color-primary);
      color: #fff;
      border-radius: var(--radius);
      font-size: var(--text-sm);
      font-weight: 600;
      text-decoration: none;
      transition: background 0.2s;
    }
    .btn-primary:hover { background: var(--color-primary-hover); }
    .btn-outline {
      padding: 10px 24px;
      border: 1.5px solid var(--color-outline);
      color: var(--color-on-surface);
      border-radius: var(--radius);
      font-size: var(--text-sm);
      font-weight: 600;
      text-decoration: none;
      transition: border-color 0.2s;
    }
    .btn-outline:hover { border-color: var(--color-primary); }
  </style>
</head>
<body>
  <div class="error-page">
    <div class="error-card">
      <div class="error-code">404</div>
      <div class="error-icon">🏔️</div>
      <h1 class="error-title">Page Not Found</h1>
      <p class="error-desc">Looks like this trail doesn't exist. The page you're looking for may have been moved, deleted, or never existed.</p>
      <div class="error-actions">
        <a href="${pageContext.request.contextPath}/home" class="btn-primary">Go Home</a>
        <a href="javascript:history.back()" class="btn-outline">Go Back</a>
      </div>
    </div>
  </div>
</body>
</html>
