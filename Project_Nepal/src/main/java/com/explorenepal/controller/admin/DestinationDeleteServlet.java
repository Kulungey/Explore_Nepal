package com.explorenepal.controller.admin;

import com.explorenepal.dao.DestinationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DestinationDeleteServlet extends HttpServlet {

    private DestinationDAO destinationDAO;

    @Override
    public void init() throws ServletException {
        destinationDAO = new DestinationDAO();
    }

    /** POST /admin/destination-delete — delete by id and redirect.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath()
                + "/admin/destinations?error=No+destination+ID+specified");
            return;
        }

        try {
            int id = Integer.parseInt(idParam.trim());
            destinationDAO.deleteDestination(id);
            response.sendRedirect(request.getContextPath()
                + "/admin/destinations?success=Destination+deleted+successfully");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath()
                + "/admin/destinations?error=Invalid+destination+ID");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath()
                + "/admin/destinations?error=Failed+to+delete+destination");
        }
    }
}