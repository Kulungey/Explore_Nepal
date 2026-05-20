package com.explorenepal.controller.admin;

import com.explorenepal.dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class BookingListServlet extends HttpServlet {

    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("bookings", bookingDAO.getAllBookings());
        } catch (SQLException e) {
            request.setAttribute("bookings", java.util.Collections.emptyList());
        }
        request.getRequestDispatcher("/WEB-INF/views/admin/booking-list.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingIdStr = request.getParameter("bookingId");
        String status       = request.getParameter("status");
        try {
            if (bookingIdStr != null && status != null) {
                bookingDAO.updateStatus(Integer.parseInt(bookingIdStr), status);
            }
        } catch (SQLException | NumberFormatException ignored) {}
        response.sendRedirect(request.getContextPath() + "/admin/bookings");
    }
}