package com.explorenepal.controller.admin;

import com.explorenepal.dao.DestinationDAO;
import com.explorenepal.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public class AdminDashboardServlet extends HttpServlet {

    private static final DateTimeFormatter SERVER_TIME_FORMAT =
        DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss z");

    private DestinationDAO destinationDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        destinationDAO = new DestinationDAO();
        userDAO        = new UserDAO();
    }

    /** GET /admin/dashboard — populate summary stats and forward.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int totalDestinations = destinationDAO.countDestinations();
            int totalUsers        = userDAO.countUsers();

            request.setAttribute("totalDestinations", totalDestinations);
            request.setAttribute("totalUsers",        totalUsers);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Failed to load dashboard data.");
        }
        request.setAttribute("serverTime", ZonedDateTime.now().format(SERVER_TIME_FORMAT));
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
