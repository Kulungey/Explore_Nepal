package com.explorenepal.filter;

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

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialisation required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  httpReq  = (HttpServletRequest)  request;
        HttpServletResponse httpRes  = (HttpServletResponse) response;

        HttpSession session = httpReq.getSession(false);
        boolean isLoggedIn  = (session != null && session.getAttribute("loggedInUser") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            // Store the originally requested URL so login can redirect back
            String requestedUrl = httpReq.getRequestURI();
            httpReq.getSession(true).setAttribute("redirectAfterLogin", requestedUrl);
            httpRes.sendRedirect(httpReq.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // Nothing to clean up
    }
}