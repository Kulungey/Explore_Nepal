package com.explorenepal.util;

/**
 * Utility class for reusable validation methods across the application.
 */
public class ValidationUtil {

    /** Returns true if the string is null or blank. */
    public static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    /** Returns true if name contains only letters and spaces (no numbers). */
    public static boolean isValidName(String name) {
        if (isBlank(name)) return false;
        return name.trim().matches("[a-zA-Z\\s]+");
    }

    /** Returns true if email matches standard format. */
    public static boolean isValidEmail(String email) {
        if (isBlank(email)) return false;
        return email.matches("^[\\w._%+\\-]+@[\\w.\\-]+\\.[a-zA-Z]{2,}$");
    }

    /** Returns true if phone is exactly 10 digits. */
    public static boolean isValidPhone(String phone) {
        return phone != null && phone.matches("9\\d{9}");
    }

    /** Returns true if password meets minimum length of 6 characters. */
    public static boolean isValidPassword(String password) {
        if (isBlank(password)) return false;
        return password.length() >= 6;
    }

    /** Returns true if card number (stripped of spaces) is exactly 16 digits. */
    public static boolean isValidCardNumber(String cardNumber) {
        if (isBlank(cardNumber)) return false;
        return cardNumber.replaceAll("[\\s-]", "").matches("\\d{16}");
    }

    /** Returns true if expiry matches MM/YY format. */
    public static boolean isValidExpiry(String expiry) {
        if (isBlank(expiry)) return false;
        return expiry.matches("\\d{2}/\\d{2}");
    }
}