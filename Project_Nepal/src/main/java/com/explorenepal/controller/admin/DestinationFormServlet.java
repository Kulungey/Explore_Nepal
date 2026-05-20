package com.explorenepal.controller.admin;

import com.explorenepal.dao.DestinationDAO;
import com.explorenepal.model.Destination;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class DestinationFormServlet extends HttpServlet {

    private static final List<String> REGION_OPTIONS = List.of(
        "Himalayan", "Hilly", "Terai"
    );
    private static final List<String> CATEGORY_OPTIONS = List.of(
        "Trekking", "Cultural", "Wildlife", "Adventure", "Scenic", "Religious"
    );
    private static final List<String> DIFFICULTY_OPTIONS = List.of(
        "Easy", "Moderate", "Hard"
    );

    private DestinationDAO destinationDAO;

    @Override
    public void init() throws ServletException {
        destinationDAO = new DestinationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam.trim());
                Destination destination = destinationDAO.getDestinationById(id);
                if (destination == null) {
                    response.sendRedirect(request.getContextPath()
                        + "/admin/destinations?error=Destination+not+found");
                    return;
                }
                request.setAttribute("destination", destination);
                request.setAttribute("formMode", "edit");
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath()
                    + "/admin/destinations?error=Invalid+destination+ID");
                return;
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Failed to load destination for editing.");
                request.setAttribute("formMode", "edit");
            }
        } else {
            request.setAttribute("formMode", "create");
        }
        forwardToForm(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam      = request.getParameter("id");
        String name         = request.getParameter("name");
        String description  = request.getParameter("description");
        String location     = request.getParameter("location");
        String region       = request.getParameter("region");
        String category     = request.getParameter("category");
        String difficulty   = request.getParameter("difficulty");
        String durationDays = request.getParameter("durationDays");
        String priceParam   = request.getParameter("price");
        String imageUrl     = request.getParameter("imageUrl");

        // ── Validation ────────────────────────────────────────────────────────
        if (isBlank(name) || isBlank(description) || isBlank(location) ||
            isBlank(region) || isBlank(category) || isBlank(difficulty) ||
            isBlank(durationDays) || isBlank(priceParam)) {
            request.setAttribute("errorMessage", "All fields except image URL are required.");
            repopulateAndForward(request, response, idParam, name, description,
                location, region, category, difficulty, durationDays, priceParam, imageUrl);
            return;
        }

        region = region.trim();
        category = category.trim();
        difficulty = difficulty.trim();
        String trimmedName = name.trim();
        String trimmedDescription = description.trim();
        String trimmedLocation = location.trim();
        String trimmedImageUrl = isBlank(imageUrl) ? null : imageUrl.trim();

        if (!REGION_OPTIONS.contains(region) ||
            !CATEGORY_OPTIONS.contains(category) ||
            !DIFFICULTY_OPTIONS.contains(difficulty)) {
            request.setAttribute("errorMessage", "Please choose valid region, category, and difficulty values.");
            repopulateAndForward(request, response, idParam, name, description,
                location, region, category, difficulty, durationDays, priceParam, imageUrl);
            return;
        }
        if (trimmedName.length() > 150 || trimmedLocation.length() > 150 ||
            (trimmedImageUrl != null && trimmedImageUrl.length() > 500)) {
            request.setAttribute("errorMessage", "Name, location, or image URL is longer than allowed.");
            repopulateAndForward(request, response, idParam, name, description,
                location, region, category, difficulty, durationDays, priceParam, imageUrl);
            return;
        }
        if (trimmedImageUrl != null && !trimmedImageUrl.matches("(?i)^https?://.+")) {
            request.setAttribute("errorMessage", "Image URL must start with http:// or https://.");
            repopulateAndForward(request, response, idParam, name, description,
                location, region, category, difficulty, durationDays, priceParam, imageUrl);
            return;
        }

        double price;
        int duration;
        try {
            price    = Double.parseDouble(priceParam.trim());
            duration = Integer.parseInt(durationDays.trim());
            if (price < 0 || duration <= 0 || duration > 365) throw new NumberFormatException();
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Price must be non-negative and duration must be between 1 and 365 days.");
            repopulateAndForward(request, response, idParam, name, description,
                location, region, category, difficulty, durationDays, priceParam, imageUrl);
            return;
        }

        // ── Build model ───────────────────────────────────────────────────────
        Destination destination = new Destination();
        destination.setName(trimmedName);
        destination.setDescription(trimmedDescription);
        destination.setLocation(trimmedLocation);
        destination.setRegion(region);
        destination.setCategory(category);
        destination.setDifficulty(difficulty);
        destination.setDurationDays(duration);
        destination.setPrice(price);
        destination.setImageUrl(trimmedImageUrl);

        Integer destinationId = null;
        if (!isBlank(idParam)) {
            try {
                destinationId = Integer.parseInt(idParam.trim());
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid destination ID.");
                repopulateAndForward(request, response, idParam, name, description,
                    location, region, category, difficulty, durationDays, priceParam, imageUrl);
                return;
            }
        }

        try {
            if (destinationId != null) {
                destination.setId(destinationId);
                destinationDAO.updateDestination(destination);
                response.sendRedirect(request.getContextPath()
                    + "/admin/destinations?success=Destination+updated+successfully");
            } else {
                destinationDAO.addDestination(destination);
                response.sendRedirect(request.getContextPath()
                    + "/admin/destinations?success=Destination+added+successfully");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "A system error occurred. Please try again.");
            repopulateAndForward(request, response, idParam, name, description,
                location, region, category, difficulty, durationDays, priceParam, imageUrl);
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private void repopulateAndForward(HttpServletRequest req, HttpServletResponse res,
                                      String id, String name, String description,
                                      String location, String region, String category,
                                      String difficulty, String durationDays,
                                      String price, String imageUrl)
            throws ServletException, IOException {
        Destination d = new Destination();
        d.setName(name);
        d.setDescription(description);
        d.setLocation(location);
        d.setRegion(region);
        d.setCategory(category);
        d.setDifficulty(difficulty);
        if (!isBlank(durationDays)) {
            try { d.setDurationDays(Integer.parseInt(durationDays.trim()));
            } catch (NumberFormatException ignored) {}
        }
        if (!isBlank(price)) {
            try { d.setPrice(Double.parseDouble(price.trim()));
            } catch (NumberFormatException ignored) {}
        }
        d.setImageUrl(imageUrl);

        if (!isBlank(id)) {
            try { d.setId(Integer.parseInt(id.trim()));
            } catch (NumberFormatException ignored) {}
            req.setAttribute("formMode", "edit");
        } else {
            req.setAttribute("formMode", "create");
        }
        req.setAttribute("destination", d);
        forwardToForm(req, res);
    }

    private void forwardToForm(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("regionOptions", REGION_OPTIONS);
        req.setAttribute("categoryOptions", CATEGORY_OPTIONS);
        req.setAttribute("difficultyOptions", DIFFICULTY_OPTIONS);
        req.getRequestDispatcher("/WEB-INF/views/admin/destination-form.jsp").forward(req, res);
    }
}
