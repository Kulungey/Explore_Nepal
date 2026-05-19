package com.explorenepal.dao;

import com.explorenepal.model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public boolean createBooking(Booking b) throws SQLException {
        String sql = "INSERT INTO bookings (user_id, destination_id, booking_ref, amount, status) VALUES (?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, b.getUserId());
            ps.setInt(2, b.getDestinationId());
            ps.setString(3, b.getBookingRef());
            ps.setBigDecimal(4, b.getAmount());
            ps.setString(5, "Pending");
            return ps.executeUpdate() == 1;
        }
    }

    public List<Booking> getAllBookings() throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name, u.email, d.name AS dest_name " +
                     "FROM bookings b " +
                     "JOIN users u ON b.user_id = u.id " +
                     "JOIN destinations d ON b.destination_id = d.id " +
                     "ORDER BY b.created_at DESC";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public boolean updateStatus(int bookingId, String status) throws SQLException {
        String sql = "UPDATE bookings SET status=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() == 1;
        }
    }

    private Booking mapRow(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setId(rs.getInt("id"));
        b.setUserId(rs.getInt("user_id"));
        b.setDestinationId(rs.getInt("destination_id"));
        b.setBookingRef(rs.getString("booking_ref"));
        b.setAmount(rs.getBigDecimal("amount"));
        b.setStatus(rs.getString("status"));
        b.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        b.setUserFullName(rs.getString("full_name"));
        b.setUserEmail(rs.getString("email"));
        b.setDestinationName(rs.getString("dest_name"));
        return b;
    }
}