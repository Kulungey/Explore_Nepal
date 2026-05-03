package com.explorenepal.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Utility class for handling HTTP Cookies.
 * Used primarily for the "Remember Me" functionality.
 */
public class CookieUtil {

    /**
     * Creates and sets a cookie on the response.
     *
     * @param response  the HTTP response object
     * @param name      the cookie name
     * @param value     the cookie value
     * @param maxAgeSeconds how long the cookie should last (seconds); use -1 for session cookie
     */
    public static void setCookie(HttpServletResponse response, String name, String value, int maxAgeSeconds) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAgeSeconds);
        cookie.setPath("/");           // Available across the entire application
        cookie.setHttpOnly(true);      // Prevents JavaScript access (security)
        response.addCookie(cookie);
    }

    /**
     * Retrieves the value of a named cookie from the request.
     *
     * @param request the HTTP request object
     * @param name    the cookie name to look for
     * @return the cookie value, or null if not found
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        if (request.getCookies() == null) return null;
        for (Cookie cookie : request.getCookies()) {
            if (name.equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return null;
    }

    /**
     * Deletes a cookie by setting its max age to 0.
     *
     * @param response the HTTP response object
     * @param name     the cookie name to delete
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}
