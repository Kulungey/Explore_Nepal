package com.explorenepal.util;

import com.explorenepal.model.User;
import jakarta.servlet.http.HttpSession;

/**
 * Utility class for managing HttpSession operations.
 * Centralises all session-related logic to avoid duplication.
 */
public class SessionUtil {

    private static final String USER_KEY = "loggedInUser";

    /**
     * Stores the authenticated User object in the session.
     *
     * @param session the current HTTP session
     * @param user    the authenticated user to store
     */
    public static void setUserSession(HttpSession session, User user) {
        session.setAttribute(USER_KEY, user);
        session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout
    }

    /**
     * Retrieves the currently logged-in User from the session.
     *
     * @param session the current HTTP session
     * @return the User object, or null if not logged in
     */
    public static User getUserFromSession(HttpSession session) {
        if (session == null) return null;
        return (User) session.getAttribute(USER_KEY);
    }

    /**
     * Checks whether there is a valid logged-in user in the session.
     *
     * @param session the current HTTP session
     * @return true if a user is logged in
     */
    public static boolean isLoggedIn(HttpSession session) {
        return getUserFromSession(session) != null;
    }

    /**
     * Checks whether the current session user has admin role.
     *
     * @param session the current HTTP session
     * @return true if user is admin
     */
    public static boolean isAdmin(HttpSession session) {
        User user = getUserFromSession(session);
        return user != null && "admin".equalsIgnoreCase(user.getRole());
    }

    /**
     * Destroys the session, logging the user out.
     *
     * @param session the current HTTP session
     */
    public static void invalidateSession(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
    }
}
