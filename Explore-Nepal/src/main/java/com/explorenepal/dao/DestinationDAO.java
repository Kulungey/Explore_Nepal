package com.explorenepal.dao;

import com.explorenepal.model.Destination;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DestinationDAO {

    public boolean create(Destination d) throws SQLException {
        return addDestination(d);
    }

    public boolean addDestination(Destination d) throws SQLException {
        String sql = "INSERT INTO destinations (name, description, location, region, category, difficulty, duration, price, image_url) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            setParams(ps, d);
            return ps.executeUpdate() == 1;
        }
    }

    public List<Destination> getAll() throws SQLException {
        return getAllDestinations();
    }

    public List<Destination> getAllDestinations() throws SQLException {
        List<Destination> list = new ArrayList<>();
        String sql = "SELECT * FROM destinations ORDER BY created_at DESC";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public List<Destination> searchDestinations(String keyword) throws SQLException {
        List<Destination> list = new ArrayList<>();
        String sql = "SELECT * FROM destinations WHERE name LIKE ? OR region LIKE ? OR category LIKE ? OR location LIKE ?";
        String pattern = "%" + keyword + "%";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ps.setString(3, pattern);
            ps.setString(4, pattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public Destination getById(int id) throws SQLException {
        return getDestinationById(id);
    }

    public Destination getDestinationById(int id) throws SQLException {
        String sql = "SELECT * FROM destinations WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    public int getTotalCount() throws SQLException {
        return countDestinations();
    }

    public int countDestinations() throws SQLException {
        String sql = "SELECT COUNT(*) FROM destinations";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public boolean update(Destination d) throws SQLException {
        return updateDestination(d);
    }

    public boolean updateDestination(Destination d) throws SQLException {
        String sql = "UPDATE destinations SET name=?, description=?, location=?, region=?, category=?, difficulty=?, duration=?, price=?, image_url=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            setParams(ps, d);
            ps.setInt(10, d.getId());
            return ps.executeUpdate() == 1;
        }
    }

    public boolean delete(int id) throws SQLException {
        return deleteDestination(id);
    }

    public boolean deleteDestination(int id) throws SQLException {
        String sql = "DELETE FROM destinations WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        }
    }

    private void setParams(PreparedStatement ps, Destination d) throws SQLException {
        ps.setString(1, d.getName());
        ps.setString(2, d.getDescription());
        ps.setString(3, d.getLocation());
        ps.setString(4, d.getRegion());
        ps.setString(5, d.getCategory());
        ps.setString(6, d.getDifficulty());
        ps.setString(7, d.getDuration());
        ps.setBigDecimal(8, d.getPrice() != null ? d.getPrice() : BigDecimal.ZERO);
        ps.setString(9, d.getImageUrl());
    }

    private Destination mapRow(ResultSet rs) throws SQLException {
        Destination d = new Destination();
        d.setId(rs.getInt("id"));
        d.setName(rs.getString("name"));
        d.setDescription(rs.getString("description"));
        d.setLocation(rs.getString("location"));
        d.setRegion(rs.getString("region"));
        d.setCategory(rs.getString("category"));
        d.setDifficulty(rs.getString("difficulty"));
        d.setDuration(rs.getString("duration"));
        d.setPrice(rs.getBigDecimal("price"));
        d.setImageUrl(rs.getString("image_url"));
        Timestamp ca = rs.getTimestamp("created_at");
        Timestamp ua = rs.getTimestamp("updated_at");
        if (ca != null) d.setCreatedAt(ca.toLocalDateTime());
        if (ua != null) d.setUpdatedAt(ua.toLocalDateTime());
        return d;
    }
}
