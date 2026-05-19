package com.explorenepal.controller;

import com.explorenepal.dao.BookingDAO;
import com.explorenepal.dao.DestinationDAO;
import com.explorenepal.model.Booking;
import com.explorenepal.model.Destination;
import com.explorenepal.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

public class PaymentProcessServlet extends HttpServlet {

    private DestinationDAO destinationDAO;
    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        destinationDAO = new DestinationDAO();
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cardNumber = request.getParameter("cardNumber");
        String expiry     = request.getParameter("expiry");
        String cvv        = request.getParameter("cvv");
        String cardHolder = request.getParameter("cardHolder");
        String amount     = request.getParameter("amount");
        String destIdStr  = request.getParameter("destId");

        boolean valid   = true;
        String errorMsg = "Payment declined. Please check your card details.";

        if (cardNumber == null || cardNumber.replaceAll("[\\s-]", "").length() < 16) {
            valid = false; errorMsg = "Invalid card number.";
        } else if (expiry == null || !expiry.matches("\\d{2}/\\d{2}")) {
            valid = false; errorMsg = "Invalid expiry date (MM/YY).";
        } else if (cvv == null || !cvv.matches("\\d{3,4}")) {
            valid = false; errorMsg = "Invalid CVV.";
        } else if (cardHolder == null || cardHolder.trim().length() < 2) {
            valid = false; errorMsg = "Cardholder name is required.";
        }

        if (valid && cardNumber != null
                && cardNumber.replaceAll("[\\s-]", "").equals("0000000000000000")) {
            valid = false; errorMsg = "Card declined by issuing bank.";
        }

        if (valid) {
            String bookingRef = "ENP-" + UUID.randomUUID().toString()
                                             .substring(0, 8).toUpperCase();
            String destName = "your destination";
            try {
                HttpSession session = request.getSession(false);
                User loggedInUser = (session != null)
                        ? (User) session.getAttribute("loggedInUser") : null;

                if (destIdStr != null && loggedInUser != null) {
                    Destination d = destinationDAO.getDestinationById(Integer.parseInt(destIdStr));
                    if (d != null) {
                        destName = d.getName();
                        Booking booking = new Booking();
                        booking.setUserId(loggedInUser.getId());
                        booking.setDestinationId(d.getId());
                        booking.setBookingRef(bookingRef);
                        booking.setAmount(d.getPrice());
                        bookingDAO.createBooking(booking);
                    }
                }
            } catch (SQLException | NumberFormatException ignored) {}

            request.setAttribute("success",         true);
            request.setAttribute("bookingRef",      bookingRef);
            request.setAttribute("destinationName", destName);
            request.setAttribute("amount",          amount);
            request.setAttribute("cardHolder",      cardHolder);
        } else {
            request.setAttribute("success",  false);
            request.setAttribute("errorMsg", errorMsg);
            if (destIdStr != null) {
                try {
                    Destination d = destinationDAO.getDestinationById(Integer.parseInt(destIdStr));
                    request.setAttribute("destination", d);
                } catch (Exception ignored) {}
            }
        }

        String view = valid ? "/WEB-INF/views/payment-result.jsp"
                            : "/WEB-INF/views/payment.jsp";
        request.getRequestDispatcher(view).forward(request, response);
    }
}