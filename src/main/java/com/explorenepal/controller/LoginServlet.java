package com.explorenepal.controller;

import com.explorenepal.dao.UserDAO;
import com.explorenepal.model.User;
import com.explorenepal.util.CookieUtil;
import com.explorenepal.util.PasswordUtil;
import com.explorenepal.util.SessionUtil;
import com.explorenepal.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller for user login and logout.
 * Maps to /login and /logout URLs.
 *
 * GET  /login   → show login form
 * POST /login   → authenticate user, set session/cookie, redirect by role
 * GET  /logout  → destroy session, clear cookies, redirect to login
 */
@WebServlet({"/login", "/logout"})
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    /**
     * GET /login: Displays the login form.
     * GET /logout: Destroys session and logs out.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/logout".equals(path)) {
            // Destroy session
            HttpSession session = req.getSession(false);
            SessionUtil.invalidateSession(session);
            // Clear remember-me cookie
            CookieUtil.deleteCookie(res, "rememberEmail");
            res.sendRedirect(req.getContextPath() + "/login?logout=true");
            return;
        }

        // Check if already logged in - redirect to dashboard
        HttpSession session = req.getSession(false);
        if (SessionUtil.isLoggedIn(session)) {
            User user = SessionUtil.getUserFromSession(session);
            redirectByRole(req, res, user.getRole());
            return;
        }

        // Pre-fill email from remember-me cookie
        String rememberedEmail = CookieUtil.getCookieValue(req, "rememberEmail");
        if (rememberedEmail != null) {
            req.setAttribute("rememberedEmail", rememberedEmail);
        }

        req.getRequestDispatcher("/jsp/login.jsp").forward(req, res);
    }

    /**
     * POST /login: Authenticates the user.
     * - Validates input fields
     * - Fetches user from DB
     * - Verifies BCrypt password
     * - Checks account approval status
     * - Sets session and optionally a remember-me cookie
     * - Redirects to the appropriate dashboard based on role
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email      = req.getParameter("email");
        String password   = req.getParameter("password");
        String rememberMe = req.getParameter("rememberMe"); // checkbox value

        // Basic input validation
        if (!ValidationUtil.isValidEmail(email)) {
            setErrorAndForward(req, res, "Please enter a valid email address.");
            return;
        }
        if (!ValidationUtil.isNotEmpty(password)) {
            setErrorAndForward(req, res, "Password cannot be empty.");
            return;
        }

        // Look up user
        User user = userDAO.getUserByEmail(email.trim());

        if (user == null) {
            setErrorAndForward(req, res, "No account found with this email address.");
            return;
        }

        // Verify password
        if (!PasswordUtil.verifyPassword(password, user.getPassword())) {
            setErrorAndForward(req, res, "Incorrect password. Please try again.");
            return;
        }

        // Check admin approval (only for regular users)
        if ("user".equalsIgnoreCase(user.getRole()) && user.getIsApproved() == 0) {
            setErrorAndForward(req, res, "Your account is pending admin approval. Please check back later.");
            return;
        }

        // Authentication successful — set session
        HttpSession session = req.getSession(true);
        SessionUtil.setUserSession(session, user);

        // Remember Me: store email in cookie for 7 days
        if ("on".equals(rememberMe)) {
            CookieUtil.setCookie(res, "rememberEmail", user.getEmail(), 7 * 24 * 60 * 60);
        } else {
            CookieUtil.deleteCookie(res, "rememberEmail");
        }

        // Redirect based on role
        redirectByRole(req, res, user.getRole());
    }

    /**
     * Redirects user to the appropriate page based on their role.
     */
    private void redirectByRole(HttpServletRequest req, HttpServletResponse res, String role)
            throws IOException {
        if ("admin".equalsIgnoreCase(role)) {
            res.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            res.sendRedirect(req.getContextPath() + "/user/home");
        }
    }

    /**
     * Sets an error message and forwards back to the login form.
     */
    private void setErrorAndForward(HttpServletRequest req, HttpServletResponse res, String message)
            throws ServletException, IOException {
        req.setAttribute("errorMessage", message);
        req.setAttribute("enteredEmail", req.getParameter("email"));
        req.getRequestDispatcher("/jsp/login.jsp").forward(req, res);
    }
}
