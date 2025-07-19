// ValidationUtil.java
package com.finesi.webapp.util;

import java.util.regex.Pattern;

public class ValidationUtil {
    
    // Patrones de validación
    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
    
    private static final Pattern USERNAME_PATTERN = 
        Pattern.compile("^[a-zA-Z0-9_]{3,20}$");
    
    private static final Pattern STRONG_PASSWORD_PATTERN = 
        Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$");
    
    /**
     * Valida formato de email
     */
    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }
    
    /**
     * Valida formato de username
     */
    public static boolean isValidUsername(String username) {
        return username != null && USERNAME_PATTERN.matcher(username).matches();
    }
    
    /**
     * Valida que la contraseña sea segura
     * Al menos 8 caracteres, 1 mayúscula, 1 minúscula, 1 número, 1 símbolo
     */
    public static boolean isStrongPassword(String password) {
        return password != null && STRONG_PASSWORD_PATTERN.matcher(password).matches();
    }
    
    /**
     * Valida que la contraseña tenga al menos los requisitos mínimos
     */
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }
    
    /**
     * Valida que el nombre no esté vacío y tenga formato válido
     */
    public static boolean isValidName(String name) {
        return name != null && 
               name.trim().length() >= 2 && 
               name.trim().length() <= 50 &&
               name.matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$");
    }
    
    /**
     * Sanitiza input para prevenir XSS básico
     */
    public static String sanitizeInput(String input) {
        if (input == null) return null;
        
        return input.replaceAll("<", "&lt;")
                   .replaceAll(">", "&gt;")
                   .replaceAll("\"", "&quot;")
                   .replaceAll("'", "&#x27;")
                   .replaceAll("&", "&amp;")
                   .trim();
    }
    
    /**
     * Valida URL de imagen
     */
    public static boolean isValidImageUrl(String url) {
        if (url == null || url.trim().isEmpty()) return true; // URL opcional
        
        return url.matches("^https?://.*\\.(jpg|jpeg|png|gif|webp)$") &&
               url.length() <= 500;
    }
    
    /**
     * Genera un mensaje de error de validación personalizado
     */
    public static class ValidationResult {
        private boolean valid;
        private String message;
        
        public ValidationResult(boolean valid, String message) {
            this.valid = valid;
            this.message = message;
        }
        
        public boolean isValid() { return valid; }
        public String getMessage() { return message; }
    }
    
    /**
     * Valida datos completos de usuario
     */
    public static ValidationResult validateUser(String nombre, String apellido, 
                                              String email, String username, String password) {
        
        if (!isValidName(nombre)) {
            return new ValidationResult(false, "El nombre debe tener entre 2 y 50 caracteres y solo contener letras");
        }
        
        if (!isValidName(apellido)) {
            return new ValidationResult(false, "El apellido debe tener entre 2 y 50 caracteres y solo contener letras");
        }
        
        if (!isValidEmail(email)) {
            return new ValidationResult(false, "El formato del email no es válido");
        }
        
        if (!isValidUsername(username)) {
            return new ValidationResult(false, "El username debe tener entre 3 y 20 caracteres (solo letras, números y _)");
        }
        
        if (!isValidPassword(password)) {
            return new ValidationResult(false, "La contraseña debe tener al menos 6 caracteres");
        }
        
        return new ValidationResult(true, "Datos válidos");
    }
}
