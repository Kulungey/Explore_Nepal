package com.explorenepal.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name    = request.getParameter("name");
        String email   = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (isBlank(name) || isBlank(email) || isBlank(subject) || isBlank(message)) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.setAttribute("nameValue",    name);
            request.setAttribute("emailValue",   email);
            request.setAttribute("subjectValue", subject);
            request.setAttribute("messageValue", message);
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
            return;
        }

        if (!email.trim().matches("^[\\w.+\\-]+@[a-zA-Z0-9.\\-]+\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("errorMessage", "Please enter a valid email address.");
            request.setAttribute("nameValue",    name);
            request.setAttribute("emailValue",   email);
            request.setAttribute("subjectValue", subject);
            request.setAttribute("messageValue", message);
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
            return;
        }

        request.setAttribute("successMessage",
            "Thank you for reaching out! We will get back to you within 24 hours.");
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}