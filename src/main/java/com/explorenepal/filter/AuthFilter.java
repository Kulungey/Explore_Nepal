package com.explorenepal.filter;

import com.explorenepal.model.User;
import com.explorenepal.util.SessionUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Authentication Filter for the Explore Nepal system.
 *
 * This filter intercepts ALL requests and enforces:
 * 1. Admin-only access to /admin/* URLs
 * 2. User-only access to /user/* URLs
 * 3. Redirect to login if session is invalid/expired
 *
 * Filter order: runs before any Servlet or JSP.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    // Paths that do NOT require login
    private static final String[] PUBLIC_PATHS = {
        "/login", "/register", "/index.jsp", "/index",
        "/destinations", "/about", "/contact",
        "/css/", "/images/", "/js/",
        "/error.jsp"
    };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getServletPath();
        String contextPath = req.getContextPath();

        // Allow public paths without authentication
        if (isPublicPath(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        User loggedInUser = SessionUtil.getUserFromSession(session);

        // No session or no user: redirect to login
        if (loggedInUser == null) {
            res.sendRedirect(contextPath + "/login?error=session");
            return;
        }

        // Admin-only area: block non-admins
        if (path.startsWith("/admin") && !"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            res.sendRedirect(contextPath + "/error.jsp?code=403");
            return;
        }

        // User area: block admins from user portal
        if (path.startsWith("/user") && "admin".equalsIgnoreCase(loggedInUser.getRole())) {
            res.sendRedirect(contextPath + "/admin/dashboard");
            return;
        }

        // Request is authorised: pass through
        chain.doFilter(request, response);
    }

    /**
     * Checks if the given path is publicly accessible (no login needed).
     */
    private boolean isPublicPath(String path) {
        for (String pub : PUBLIC_PATHS) {
            if (path.startsWith(pub) || path.equals(pub)) return true;
        }
        return false;
    }

    @Override
    public void init(FilterConfig config) throws ServletException {}

    @Override
    public void destroy() {}
}
