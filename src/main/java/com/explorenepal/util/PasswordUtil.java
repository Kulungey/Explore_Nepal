package com.explorenepal.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for password hashing and verification using BCrypt.
 * BCrypt automatically salts passwords, preventing rainbow table attacks.
 */
public class PasswordUtil {

    // Cost factor: higher = slower = more secure (10-12 recommended)
    private static final int BCRYPT_ROUNDS = 12;

    /**
     * Hashes a plain-text password using BCrypt.
     *
     * @param plainPassword the raw password entered by the user
     * @return the BCrypt-hashed password string (60 chars, includes salt)
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty.");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_ROUNDS));
    }

    /**
     * Verifies a plain-text password against a stored BCrypt hash.
     *
     * @param plainPassword   the raw password entered at login
     * @param hashedPassword  the stored BCrypt hash from the database
     * @return true if passwords match, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) return false;
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Validates password strength:
     * - Minimum 8 characters
     * - At least one uppercase letter
     * - At least one digit
     * - At least one special character
     *
     * @param password the password to validate
     * @return true if strong, false otherwise
     */
    public static boolean isStrongPassword(String password) {
        if (password == null || password.length() < 8) return false;
        boolean hasUpper   = password.chars().anyMatch(Character::isUpperCase);
        boolean hasDigit   = password.chars().anyMatch(Character::isDigit);
        boolean hasSpecial = password.chars().anyMatch(c -> "!@#$%^&*()_+-=[]|,.?/".indexOf(c) >= 0);
        return hasUpper && hasDigit && hasSpecial;
    }
}
