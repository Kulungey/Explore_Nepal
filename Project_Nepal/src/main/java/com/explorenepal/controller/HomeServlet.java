package com.explorenepal.controller;

import com.explorenepal.service.DestinationService;
import com.explorenepal.model.Destination;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class HomeServlet extends HttpServlet {

    private DestinationService destinationService;

    @Override
    public void init() throws ServletException {
        destinationService = new DestinationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("search");
        try {
            List<Destination> destinations = destinationService.searchDestinations(keyword);
            request.setAttribute("destinations", destinations);
            request.setAttribute("searchKeyword", keyword);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Unable to load destinations at this time.");
        }
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}