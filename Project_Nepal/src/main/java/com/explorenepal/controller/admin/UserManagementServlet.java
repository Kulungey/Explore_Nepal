package com.explorenepal.controller.admin;

import com.explorenepal.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

public class UserManagementServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("users", userService.getAllUsers());
        } catch (SQLException e) {
            request.setAttribute("users", java.util.Collections.emptyList());
            request.setAttribute("errorMessage", "Failed to load users.");
        }
        request.getRequestDispatcher("/WEB-INF/views/admin/user-list.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        String action    = request.getParameter("action");
        String roleId    = request.getParameter("roleId");

        try {
            if (userIdStr != null) {
                int userId = Integer.parseInt(userIdStr);
                if ("delete".equals(action)) {
                    userService.deleteUser(userId);
                } else if ("approve".equals(action)) {
                    userService.approveUser(userId);
                } else if ("reject".equals(action)) {
                    userService.rejectUser(userId);
                } else if (roleId != null) {
                    userService.updateRole(userId, Integer.parseInt(roleId));
                }
            }
        } catch (SQLException e) {
            request.getSession().setAttribute("errorMessage", "Database error: " + e.getMessage());
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid user ID provided.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}