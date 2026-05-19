package com.explorenepal.controller;

import com.explorenepal.dao.DestinationDAO;
import com.explorenepal.model.Destination;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class DestinationServlet extends HttpServlet {

    private DestinationDAO destinationDAO;

    @Override
    public void init() throws ServletException {
        destinationDAO = new DestinationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        try {
            int id = Integer.parseInt(idParam);
            Destination dest = destinationDAO.getDestinationById(id);
            if (dest == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            request.setAttribute("destination", dest);
            request.getRequestDispatcher("/WEB-INF/views/destination.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Could not load destination.");
            request.getRequestDispatcher("/WEB-INF/views/destination.jsp").forward(request, response);
        }
    }
}