package com.explorenepal.controller;

import com.explorenepal.dao.UserDAO;
import com.explorenepal.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName  = request.getParameter("fullName");
        String email     = request.getParameter("email");
        String phone     = request.getParameter("phone");
        String password  = request.getParameter("password");
        String confirmPw = request.getParameter("confirmPassword");

        if (isBlank(fullName) || isBlank(email) || isBlank(phone) ||
            isBlank(password) || isBlank(confirmPw)) {
            forwardWithError(request, response, "All fields are required.", fullName, email, phone);
            return;
        }

        if (!fullName.trim().matches("[a-zA-Z\\s.'-]+")) {
            forwardWithError(request, response,
                "Full name must contain only letters.", fullName, email, phone);
            return;
        }

        if (!email.trim().matches("^[\\w.+\\-]+@[a-zA-Z0-9.\\-]+\\.[a-zA-Z]{2,}$")) {
            forwardWithError(request, response,
                "Please enter a valid email address.", fullName, email, phone);
            return;
        }

        if (!phone.trim().matches("9\\d{9}")) {
            forwardWithError(request, response,
                "Phone must be 10 digits and start with 9.", fullName, email, phone);
            return;
        }

        if (password.length() < 8) {
            forwardWithError(request, response,
                "Password must be at least 8 characters long.", fullName, email, phone);
            return;
        }

        if (!password.matches(".*[A-Z].*")) {
            forwardWithError(request, response,
                "Password must contain at least 1 uppercase letter.", fullName, email, phone);
            return;
        }

        if (!password.matches(".*[0-9].*")) {
            forwardWithError(request, response,
                "Password must contain at least 1 number.", fullName, email, phone);
            return;
        }

        if (!password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?].*")) {
            forwardWithError(request, response,
                "Password must contain at least 1 special character.", fullName, email, phone);
            return;
        }

        if (!password.equals(confirmPw)) {
            forwardWithError(request, response,
                "Passwords do not match.", fullName, email, phone);
            return;
        }

        try {
            if (userDAO.emailExists(email.trim())) {
                forwardWithError(request, response,
                    "An account with this email already exists.", fullName, email, phone);
                return;
            }

            if (userDAO.phoneExists(phone.trim())) {
                forwardWithError(request, response,
                    "An account with this phone number already exists.", fullName, email, phone);
                return;
            }

            User newUser = new User();
            newUser.setFullName(fullName.trim());
            newUser.setEmail(email.trim().toLowerCase());
            newUser.setPhone(phone.trim());
            newUser.setPassword(password);
            newUser.setRole("USER");
            userDAO.registerUser(newUser);

            request.setAttribute("successMessage", "Registration successful! You can now log in.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);

        } catch (Exception e) {
            forwardWithError(request, response,
                "A system error occurred. Please try again later.", fullName, email, phone);
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private void forwardWithError(HttpServletRequest req, HttpServletResponse res,
                                  String message, String fullName, String email, String phone)
            throws ServletException, IOException {
        req.setAttribute("errorMessage", message);
        req.setAttribute("fullNameValue", fullName);
        req.setAttribute("emailValue",    email);
        req.setAttribute("phoneValue",    phone);
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, res);
    }
}