package com.explorenepal.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Provides JDBC connections to the MySQL database.
 * Update DB_URL / USER / PASS to match your local MySQL or XAMPP setup.
 */
public class DBConnection {
	private static final String DB_NAME = "explore_nepal";
    private static final String DB_URL  = "jdbc:mysql://localhost:3306/" +DB_NAME;
    private static final String DB_USER = "root";
    private static final String DB_PASS = ""; // default XAMPP root has no password

    private DBConnection() {}

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL driver not found", e);
        }
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }
}
