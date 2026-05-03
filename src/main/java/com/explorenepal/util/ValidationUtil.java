package com.explorenepal.util;

/**
 * Utility class providing input validation methods used across the application.
 */
public class ValidationUtil {

    /**
     * Validates that a string is not null and not empty after trimming.
     */
    public static boolean isNotEmpty(String value) {
        return value != null && !value.trim().isEmpty();
    }

    /**
     * Validates email format using a simple regex.
     */
    public static boolean isValidEmail(String email) {
        if (email == null) return false;
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    }

    /**
     * Validates that the name contains only letters and spaces (no numbers/symbols).
     */
    public static boolean isValidName(String name) {
        if (name == null) return false;
        return name.trim().matches("^[A-Za-z\\s]{2,100}$");
    }

    /**
     * Validates Nepali phone number: must be 10 digits starting with 9.
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null) return false;
        return phone.matches("^9[0-9]{9}$");
    }

    /**
     * Validates that a number string is a positive integer.
     */
    public static boolean isPositiveInteger(String value) {
        try {
            return Integer.parseInt(value) > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * Sanitises a string for display by trimming and escaping basic HTML.
     */
    public static String sanitise(String input) {
        if (input == null) return "";
        return input.trim()
                    .replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;");
    }
}
