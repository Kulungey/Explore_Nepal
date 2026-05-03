package com.explorenepal.controller;

import com.explorenepal.dao.UserDAO;
import com.explorenepal.model.User;
import com.explorenepal.util.PasswordUtil;
import com.explorenepal.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Controller for user registration.
 * Maps to /register URL.
 *
 * GET  → show registration form (register.jsp)
 * POST → validate input, create account, redirect to login
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    /**
     * GET: Displays the registration form.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
    }

    /**
     * POST: Processes the registration form submission.
     * Validates all fields, checks for duplicate email, hashes password, saves user.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Collect form inputs
        String fullName    = req.getParameter("fullName");
        String email       = req.getParameter("email");
        String password    = req.getParameter("password");
        String confirmPass = req.getParameter("confirmPassword");
        String phone       = req.getParameter("phone");

        // --- Validation ---

        // Full name: letters only
        if (!ValidationUtil.isValidName(fullName)) {
            setErrorAndForward(req, res, "Full name must contain only letters and spaces (2–100 characters).");
            return;
        }

        // Email format
        if (!ValidationUtil.isValidEmail(email)) {
            setErrorAndForward(req, res, "Please enter a valid email address.");
            return;
        }

        // Email uniqueness
        if (userDAO.emailExists(email)) {
            setErrorAndForward(req, res, "An account with this email already exists. Please log in.");
            return;
        }

        // Password strength
        if (!PasswordUtil.isStrongPassword(password)) {
            setErrorAndForward(req, res, "Password must be at least 8 characters and include an uppercase letter, a number, and a special character.");
            return;
        }

        // Password confirmation
        if (!password.equals(confirmPass)) {
            setErrorAndForward(req, res, "Passwords do not match.");
            return;
        }

        // Phone number
        if (!ValidationUtil.isValidPhone(phone)) {
            setErrorAndForward(req, res, "Please enter a valid 10-digit Nepali phone number starting with 9.");
            return;
        }

        // --- Create User ---
        User newUser = new User(fullName.trim(), email.trim(), password, phone.trim(), "user");
        boolean success = userDAO.insertUser(newUser);

        if (success) {
            // Redirect to login with success message
            res.sendRedirect(req.getContextPath() + "/login?registered=true");
        } else {
            setErrorAndForward(req, res, "Registration failed due to a server error. Please try again.");
        }
    }

    /**
     * Sets an error message attribute and forwards back to the registration form.
     */
    private void setErrorAndForward(HttpServletRequest req, HttpServletResponse res, String message)
            throws ServletException, IOException {
        req.setAttribute("errorMessage", message);
        // Preserve entered values so user doesn't have to retype
        req.setAttribute("enteredName",  req.getParameter("fullName"));
        req.setAttribute("enteredEmail", req.getParameter("email"));
        req.setAttribute("enteredPhone", req.getParameter("phone"));
        req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
    }
}
