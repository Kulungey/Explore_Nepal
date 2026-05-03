package com.explorenepal.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class for managing database connections.
 * Uses JDBC to connect to the MySQL database via XAMPP.
 */
public class DBUtil {

    private static final String URL      = "jdbc:mysql://localhost:3306/explore_nepal";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";  // XAMPP default has no password

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found. Add mysql-connector-java to lib.", e);
        }
    }

    /**
     * Returns a new database connection.
     * Always close the connection in a finally block or try-with-resources.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    /**
     * Safely closes a connection without throwing.
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException ignored) {}
        }
    }
}
