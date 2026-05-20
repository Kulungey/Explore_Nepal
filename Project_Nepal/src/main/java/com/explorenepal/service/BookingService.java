package com.explorenepal.service;

import com.explorenepal.dao.BookingDAO;
import com.explorenepal.model.Booking;
import java.sql.SQLException;
import java.util.List;

/**
 * Service layer for booking business logic.
 */
public class BookingService {

    private final BookingDAO bookingDAO = new BookingDAO();

    /** Creates a new booking record. */
    public boolean createBooking(Booking booking) throws SQLException {
        return bookingDAO.createBooking(booking);
    }

    /** Returns all bookings (admin view). */
    public List<Booking> getAllBookings() throws SQLException {
        return bookingDAO.getAllBookings();
    }

    /** Returns bookings for a specific user. */
    public List<Booking> getBookingsByUser(int userId) throws SQLException {
        return bookingDAO.getBookingsByUserId(userId);
    }

    /** Updates booking status. */
    public boolean updateStatus(int bookingId, String status) throws SQLException {
        return bookingDAO.updateStatus(bookingId, status);
    }

    /** Returns total booking count. */
    public int getTotalCount() throws SQLException {
        return bookingDAO.countBookings();
    }

    /** Returns total revenue from all confirmed/completed bookings. */
    public double getTotalRevenue() throws SQLException {
        return bookingDAO.getTotalRevenue();
    }
}