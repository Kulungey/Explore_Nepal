package com.explorenepal.service;

import com.explorenepal.dao.DestinationDAO;
import com.explorenepal.model.Destination;
import java.sql.SQLException;
import java.util.List;

/**
 * Service layer for destination business logic.
 * Sits between Controller and DAO, keeping servlets clean.
 */
public class DestinationService {

    private final DestinationDAO destinationDAO = new DestinationDAO();

    /** Returns all destinations, or empty list on error. */
    public List<Destination> getAllDestinations() throws SQLException {
        return destinationDAO.getAllDestinations();
    }

    /** Returns destinations matching keyword search. */
    public List<Destination> searchDestinations(String keyword) throws SQLException {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllDestinations();
        }
        return destinationDAO.searchDestinations(keyword.trim());
    }

    /** Returns a single destination by ID, or null if not found. */
    public Destination getDestinationById(int id) throws SQLException {
        return destinationDAO.getDestinationById(id);
    }

    /** Returns total count of destinations. */
    public int getTotalCount() throws SQLException {
        return destinationDAO.countDestinations();
    }
}