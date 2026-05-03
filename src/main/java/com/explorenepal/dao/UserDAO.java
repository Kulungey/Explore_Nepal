package com.explorenepal.dao;

import com.explorenepal.model.User;
import com.explorenepal.util.DBUtil;
import com.explorenepal.util.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for User-related database operations.
 * All interactions with the 'users' table go through this class.
 */
public class UserDAO {

    /**
     * Inserts a new user into the database.
     * Password is hashed with BCrypt before insertion.
     *
     * @param user the User object to insert
     * @return true if insertion was successful
     */
    public boolean insertUser(User user) {
        String sql = "INSERT INTO users (full_name, email, password, phone, role, is_approved) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, PasswordUtil.hashPassword(user.getPassword())); // Hash before storing
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getRole() != null ? user.getRole() : "user");
            ps.setInt(6, 0); // New users require admin approval

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[UserDAO] insertUser error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Retrieves a user by their email address.
     * Used during login to find the account.
     *
     * @param email the email to look up
     * @return the User object, or null if not found
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }

        } catch (SQLException e) {
            System.err.println("[UserDAO] getUserByEmail error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Retrieves a user by their ID.
     *
     * @param userId the user's primary key
     * @return the User object, or null if not found
     */
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }

        } catch (SQLException e) {
            System.err.println("[UserDAO] getUserById error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Retrieves all users from the database.
     * Used by admin to manage user accounts.
     *
     * @return list of all users
     */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }

        } catch (SQLException e) {
            System.err.println("[UserDAO] getAllUsers error: " + e.getMessage());
        }
        return users;
    }

    /**
     * Updates a user's profile information (name, phone).
     * Does not update password or role.
     *
     * @param user the User object with updated fields
     * @return true if update was successful
     */
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET full_name = ?, phone = ? WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setInt(3, user.getUserId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[UserDAO] updateUser error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Deletes a user from the database by their ID.
     *
     * @param userId the ID of the user to delete
     * @return true if deletion was successful
     */
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[UserDAO] deleteUser error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Approves a pending user registration (sets is_approved = 1).
     *
     * @param userId the user ID to approve
     * @return true if successful
     */
    public boolean approveUser(int userId) {
        String sql = "UPDATE users SET is_approved = 1 WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[UserDAO] approveUser error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Checks whether an email address already exists in the database.
     * Used during registration to prevent duplicates.
     *
     * @param email the email to check
     * @return true if email already exists
     */
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;

        } catch (SQLException e) {
            System.err.println("[UserDAO] emailExists error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Maps a database ResultSet row to a User object.
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setPhone(rs.getString("phone"));
        user.setRole(rs.getString("role"));
        user.setIsApproved(rs.getInt("is_approved"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        return user;
    }
}
