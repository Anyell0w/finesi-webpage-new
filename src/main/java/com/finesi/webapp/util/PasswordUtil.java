
// PasswordUtil.java
package com.finesi.webapp.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    
    // Número de rondas para el hashing (más alto = más seguro pero más lento)
    private static final int ROUNDS = 12;
    
    /**
     * Hashea una contraseña usando BCrypt
     * @param plainPassword La contraseña en texto plano
     * @return La contraseña hasheada
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.trim().isEmpty()) {
            throw new IllegalArgumentException("La contraseña no puede estar vacía");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(ROUNDS));
    }
    
    /**
     * Verifica si una contraseña coincide con su hash
     * @param plainPassword La contraseña en texto plano
     * @param hashedPassword La contraseña hasheada almacenada en BD
     * @return true si coinciden, false si no
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            // Log del error en producción
            System.err.println("Error al verificar contraseña: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Verifica si una contraseña necesita ser re-hasheada
     * (útil si cambias el número de rondas)
     * @param hashedPassword La contraseña hasheada
     * @return true si necesita re-hash
     */
    public static boolean needsRehash(String hashedPassword) {
        if (hashedPassword == null) {
            return true;
        }
        
        try {
            return BCrypt.checkpw("test", hashedPassword) && 
                   !hashedPassword.startsWith("$2a$" + String.format("%02d", ROUNDS));
        } catch (Exception e) {
            return true;
        }
    }
    
    /**
     * Genera una contraseña temporal aleatoria
     * @param length Longitud de la contraseña
     * @return Contraseña temporal
     */
    public static String generateTemporaryPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%";
        StringBuilder password = new StringBuilder();
        
        for (int i = 0; i < length; i++) {
            int index = (int) (Math.random() * chars.length());
            password.append(chars.charAt(index));
        }
        
        return password.toString();
    }
}