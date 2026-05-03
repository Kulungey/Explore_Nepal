package com.explorenepal.dao;

import com.explorenepal.model.Destination;
import com.explorenepal.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Destination-related database operations.
 * Handles all CRUD operations for the 'destinations' table.
 */
public class DestinationDAO {

    /**
     * Inserts a new destination record into the database.
     *
     * @param destination the Destination object to insert
     * @return true if insertion was successful
     */
    public boolean insertDestination(Destination destination) {
        String sql = "INSERT INTO destinations (name, description, region, category, difficulty, duration_days, altitude, best_season, image_url, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, destination.getName());
            ps.setString(2, destination.getDescription());
            ps.setString(3, destination.getRegion());
            ps.setString(4, destination.getCategory());
            ps.setString(5, destination.getDifficulty());
            ps.setInt(6, destination.getDurationDays());
            ps.setDouble(7, destination.getAltitude());
            ps.setString(8, destination.getBestSeason());
            ps.setString(9, destination.getImageUrl());
            ps.setInt(10, 1);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[DestinationDAO] insertDestination error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Retrieves all active destinations.
     *
     * @return list of active destinations
     */
    public List<Destination> getAllDestinations() {
        List<Destination> list = new ArrayList<>();
        String sql = "SELECT * FROM destinations WHERE is_active = 1 ORDER BY name ASC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("[DestinationDAO] getAllDestinations error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Retrieves all destinations including inactive (for admin view).
     *
     * @return list of all destinations
     */
    public List<Destination> getAllDestinationsAdmin() {
        List<Destination> list = new ArrayList<>();
        String sql = "SELECT * FROM destinations ORDER BY destination_id DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("[DestinationDAO] getAllDestinationsAdmin error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Retrieves a destination by its ID.
     *
     * @param id the destination ID
     * @return the Destination object or null
     */
    public Destination getDestinationById(int id) {
        String sql = "SELECT * FROM destinations WHERE destination_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (SQLException e) {
            System.err.println("[DestinationDAO] getDestinationById error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Searches destinations by name, region, or category keyword.
     *
     * @param keyword the search keyword
     * @return list of matching destinations
     */
    public List<Destination> searchDestinations(String keyword) {
        List<Destination> list = new ArrayList<>();
        String sql = "SELECT * FROM destinations WHERE is_active = 1 AND (name LIKE ? OR region LIKE ? OR category LIKE ?)";
        String pattern = "%" + keyword + "%";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ps.setString(3, pattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("[DestinationDAO] searchDestinations error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Updates an existing destination record.
     *
     * @param destination the Destination with updated values
     * @return true if update was successful
     */
    public boolean updateDestination(Destination destination) {
        String sql = "UPDATE destinations SET name=?, description=?, region=?, category=?, difficulty=?, duration_days=?, altitude=?, best_season=?, image_url=?, is_active=? WHERE destination_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, destination.getName());
            ps.setString(2, destination.getDescription());
            ps.setString(3, destination.getRegion());
            ps.setString(4, destination.getCategory());
            ps.setString(5, destination.getDifficulty());
            ps.setInt(6, destination.getDurationDays());
            ps.setDouble(7, destination.getAltitude());
            ps.setString(8, destination.getBestSeason());
            ps.setString(9, destination.getImageUrl());
            ps.setInt(10, destination.getIsActive());
            ps.setInt(11, destination.getDestinationId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[DestinationDAO] updateDestination error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Deletes a destination by ID.
     *
     * @param id the destination ID to delete
     * @return true if deletion was successful
     */
    public boolean deleteDestination(int id) {
        String sql = "DELETE FROM destinations WHERE destination_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[DestinationDAO] deleteDestination error: " + e.getMessage());
            return false;
        }
    }

    private Destination mapRow(ResultSet rs) throws SQLException {
        Destination d = new Destination();
        d.setDestinationId(rs.getInt("destination_id"));
        d.setName(rs.getString("name"));
        d.setDescription(rs.getString("description"));
        d.setRegion(rs.getString("region"));
        d.setCategory(rs.getString("category"));
        d.setDifficulty(rs.getString("difficulty"));
        d.setDurationDays(rs.getInt("duration_days"));
        d.setAltitude(rs.getDouble("altitude"));
        d.setBestSeason(rs.getString("best_season"));
        d.setImageUrl(rs.getString("image_url"));
        d.setIsActive(rs.getInt("is_active"));
        return d;
    }
}
