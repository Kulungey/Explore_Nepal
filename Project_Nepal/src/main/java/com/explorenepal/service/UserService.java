package com.explorenepal.service;

import com.explorenepal.dao.UserDAO;
import com.explorenepal.model.User;
import java.sql.SQLException;
import java.util.List;

/**
 * Service layer for user business logic.
 * Encapsulates approval, rejection, and user retrieval operations.
 */
public class UserService {

    private final UserDAO userDAO = new UserDAO();

    public boolean approveUser(int userId) throws SQLException {
        return userDAO.updateStatus(userId, "Approved");
    }

    public boolean rejectUser(int userId) throws SQLException {
        return userDAO.updateStatus(userId, "Rejected");
    }

    public List<User> getAllUsers() throws SQLException {
        return userDAO.getAllUsers();
    }

    public int countPendingUsers() throws SQLException {
        return userDAO.countPendingUsers();
    }

    public boolean deleteUser(int userId) throws SQLException {
        return userDAO.deleteUser(userId);
    }

    public boolean updateRole(int userId, int roleId) throws SQLException {
        return userDAO.updateRole(userId, roleId);
    }
}