package com.explorenepal.controller;

import com.explorenepal.dao.DestinationDAO;
import com.explorenepal.model.Destination;
import com.explorenepal.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller (Servlet) for admin destination management.
 * Handles all CRUD operations on destinations via MVC architecture.
 *
 * URL: /admin/destinations
 *
 * GET  ?action=list     → show all destinations (admin view)
 * GET  ?action=add      → show add form
 * GET  ?action=edit&id= → show edit form pre-filled
 * GET  ?action=delete&id= → delete destination and redirect
 * POST ?action=insert   → process add form
 * POST ?action=update   → process edit form
 */
@WebServlet("/admin/destinations")
public class DestinationServlet extends HttpServlet {

    private final DestinationDAO destinationDAO = new DestinationDAO();

    /**
     * doGet: Handles read and delete operations.
     * Routes based on the 'action' parameter.
     *
     * @param req  HttpServletRequest containing action and optional id parameters
     * @param res  HttpServletResponse for forwarding/redirecting
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listDestinations(req, res);
                break;

            case "add":
                // Forward to the add form with no pre-filled data
                req.getRequestDispatcher("/jsp/admin/destinationForm.jsp").forward(req, res);
                break;

            case "edit":
                showEditForm(req, res);
                break;

            case "delete":
                deleteDestination(req, res);
                break;

            default:
                listDestinations(req, res);
        }
    }

    /**
     * doPost: Handles create and update form submissions.
     * Routes based on the 'action' parameter.
     *
     * @param req  HttpServletRequest containing form data
     * @param res  HttpServletResponse for redirecting after operation
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "insert":
                insertDestination(req, res);
                break;

            case "update":
                updateDestination(req, res);
                break;

            default:
                res.sendRedirect(req.getContextPath() + "/admin/destinations?action=list");
        }
    }

    // ====================== HANDLER METHODS ======================

    /**
     * Fetches all destinations and forwards to the list view.
     */
    private void listDestinations(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        List<Destination> destinations = destinationDAO.getAllDestinationsAdmin();
        req.setAttribute("destinations", destinations);
        req.getRequestDispatcher("/jsp/admin/destinationList.jsp").forward(req, res);
    }

    /**
     * Loads a destination by ID and forwards to the edit form.
     */
    private void showEditForm(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Destination destination = destinationDAO.getDestinationById(id);
            if (destination == null) {
                req.setAttribute("errorMessage", "Destination not found.");
                listDestinations(req, res);
                return;
            }
            req.setAttribute("destination", destination);
            req.getRequestDispatcher("/jsp/admin/destinationForm.jsp").forward(req, res);
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/admin/destinations?action=list&error=invalid");
        }
    }

    /**
     * Validates and inserts a new destination from POST form data.
     */
    private void insertDestination(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        Destination d = buildDestinationFromRequest(req);
        String validationError = validateDestination(d);

        if (validationError != null) {
            req.setAttribute("errorMessage", validationError);
            req.setAttribute("destination", d);
            req.getRequestDispatcher("/jsp/admin/destinationForm.jsp").forward(req, res);
            return;
        }

        boolean success = destinationDAO.insertDestination(d);
        if (success) {
            res.sendRedirect(req.getContextPath() + "/admin/destinations?action=list&success=added");
        } else {
            req.setAttribute("errorMessage", "Failed to add destination. Please try again.");
            req.setAttribute("destination", d);
            req.getRequestDispatcher("/jsp/admin/destinationForm.jsp").forward(req, res);
        }
    }

    /**
     * Validates and updates an existing destination from POST form data.
     */
    private void updateDestination(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        Destination d = buildDestinationFromRequest(req);
        try {
            d.setDestinationId(Integer.parseInt(req.getParameter("destinationId")));
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/admin/destinations?action=list&error=invalid");
            return;
        }

        String validationError = validateDestination(d);
        if (validationError != null) {
            req.setAttribute("errorMessage", validationError);
            req.setAttribute("destination", d);
            req.getRequestDispatcher("/jsp/admin/destinationForm.jsp").forward(req, res);
            return;
        }

        boolean success = destinationDAO.updateDestination(d);
        if (success) {
            res.sendRedirect(req.getContextPath() + "/admin/destinations?action=list&success=updated");
        } else {
            req.setAttribute("errorMessage", "Failed to update destination. Please try again.");
            req.setAttribute("destination", d);
            req.getRequestDispatcher("/jsp/admin/destinationForm.jsp").forward(req, res);
        }
    }

    /**
     * Deletes a destination by ID and redirects to the list.
     */
    private void deleteDestination(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            boolean success = destinationDAO.deleteDestination(id);
            String param = success ? "success=deleted" : "error=deleteFailed";
            res.sendRedirect(req.getContextPath() + "/admin/destinations?action=list&" + param);
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/admin/destinations?action=list&error=invalid");
        }
    }

    // ====================== HELPER METHODS ======================

    /**
     * Reads form parameters and builds a Destination object.
     */
    private Destination buildDestinationFromRequest(HttpServletRequest req) {
        Destination d = new Destination();
        d.setName(req.getParameter("name"));
        d.setDescription(req.getParameter("description"));
        d.setRegion(req.getParameter("region"));
        d.setCategory(req.getParameter("category"));
        d.setDifficulty(req.getParameter("difficulty"));
        d.setBestSeason(req.getParameter("bestSeason"));
        d.setImageUrl(req.getParameter("imageUrl"));
        try { d.setDurationDays(Integer.parseInt(req.getParameter("durationDays"))); }
        catch (NumberFormatException ignored) { d.setDurationDays(0); }
        try { d.setAltitude(Double.parseDouble(req.getParameter("altitude"))); }
        catch (NumberFormatException ignored) { d.setAltitude(0); }
        d.setIsActive(1);
        return d;
    }

    /**
     * Validates a Destination object and returns an error message or null if valid.
     */
    private String validateDestination(Destination d) {
        if (!ValidationUtil.isNotEmpty(d.getName()))        return "Destination name is required.";
        if (!ValidationUtil.isNotEmpty(d.getRegion()))      return "Region is required.";
        if (!ValidationUtil.isNotEmpty(d.getCategory()))    return "Category is required.";
        if (!ValidationUtil.isNotEmpty(d.getDifficulty()))  return "Difficulty level is required.";
        if (!ValidationUtil.isNotEmpty(d.getBestSeason()))  return "Best season is required.";
        if (d.getDurationDays() <= 0)                       return "Duration must be a positive number of days.";
        return null;
    }
}
