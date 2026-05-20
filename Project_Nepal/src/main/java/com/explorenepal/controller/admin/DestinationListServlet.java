package com.explorenepal.controller.admin;

import com.explorenepal.dao.DestinationDAO;
import com.explorenepal.model.Destination;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class DestinationListServlet extends HttpServlet {

    private DestinationDAO destinationDAO;

    @Override
    public void init() throws ServletException {
        destinationDAO = new DestinationDAO();
    }

    /** GET /admin/destinations — load and display all destinations.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("q");
        try {
            List<Destination> destinations;
            if (query != null && !query.trim().isEmpty()) {
                destinations = destinationDAO.searchDestinations(query.trim());
                request.setAttribute("searchQuery", query.trim());
            } else {
                destinations = destinationDAO.getAllDestinations();
            }
            request.setAttribute("destinations", destinations);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Failed to retrieve destinations.");
        }
        request.getRequestDispatcher("/WEB-INF/views/admin/destination-list.jsp").forward(request, response);
    }
}