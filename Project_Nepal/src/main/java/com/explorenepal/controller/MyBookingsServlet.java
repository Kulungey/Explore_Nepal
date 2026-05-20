package com.explorenepal.controller;

import com.explorenepal.model.User;
import com.explorenepal.service.BookingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

public class MyBookingsServlet extends HttpServlet {

    private BookingService bookingService;

    @Override
    public void init() throws ServletException {
        bookingService = new BookingService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        try {
            request.setAttribute("bookings", bookingService.getBookingsByUser(user.getId()));
        } catch (SQLException e) {
            request.setAttribute("bookings", java.util.Collections.emptyList());
        }
        request.getRequestDispatcher("/WEB-INF/views/my-bookings.jsp").forward(request, response);
    }
}