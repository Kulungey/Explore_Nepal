package com.explorenepal.controller.admin;

import com.explorenepal.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class UserManagementServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    /** GET — list all users */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("users", userDAO.getAllUsers());
        } catch (SQLException e) {
            request.setAttribute("users", java.util.Collections.emptyList());
            request.setAttribute("errorMessage", "Failed to load users.");
        }
        request.getRequestDispatcher("/WEB-INF/views/admin/user-list.jsp")
               .forward(request, response);
    }

    /** POST — change a user's role */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        String roleId    = request.getParameter("roleId");
        try {
            if (userIdStr != null && roleId != null) {
                userDAO.updateRole(Integer.parseInt(userIdStr), Integer.parseInt(roleId));
            }
        } catch (SQLException | NumberFormatException ignored) {}
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}