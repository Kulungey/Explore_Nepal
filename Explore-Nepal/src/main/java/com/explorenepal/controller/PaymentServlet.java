package com.explorenepal.controller;

import com.explorenepal.dao.DestinationDAO;
import com.explorenepal.model.Destination;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class PaymentServlet extends HttpServlet {

    private DestinationDAO destinationDAO;

    @Override
    public void init() throws ServletException {
        destinationDAO = new DestinationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String destIdStr = request.getParameter("destId");
        if (destIdStr == null || destIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            int destId = Integer.parseInt(destIdStr);
            Destination dest = destinationDAO.getDestinationById(destId);
            if (dest == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            request.setAttribute("destination", dest);
            request.getRequestDispatcher("/WEB-INF/views/payment.jsp")
                   .forward(request, response);
        } catch (NumberFormatException | SQLException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}