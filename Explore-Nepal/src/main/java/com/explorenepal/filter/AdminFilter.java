package com.explorenepal.filter;

import com.explorenepal.model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialisation required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  httpReq = (HttpServletRequest)  request;
        HttpServletResponse httpRes = (HttpServletResponse) response;

        HttpSession session = httpReq.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("loggedInUser");
            if (user != null && "ADMIN".equalsIgnoreCase(user.getRole())) {
                chain.doFilter(request, response);
                return;
            }
        }

        // Authenticated but not an admin — show 403
        httpRes.sendError(HttpServletResponse.SC_FORBIDDEN,
            "You do not have permission to access this area.");
    }

    @Override
    public void destroy() {
        // Nothing to clean up
    }
}