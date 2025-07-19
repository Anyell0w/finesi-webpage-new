// SecurityUtil.java
package com.finesi.webapp.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import com.finesi.webapp.model.Usuario;

public class SecurityUtil {
    
    /**
     * Verifica si el usuario está autenticado
     */
    public static boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("usuario") != null;
    }
    
    /**
     * Obtiene el usuario de la sesión
     */
    public static Usuario getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (Usuario) session.getAttribute("usuario");
        }
        return null;
    }
    
    /**
     * Verifica si el usuario tiene un rol específico
     */
    public static boolean hasRole(HttpServletRequest request, String role) {
        Usuario usuario = getCurrentUser(request);
        return usuario != null && role.equals(usuario.getRol());
    }
    
    /**
     * Verifica si el usuario es administrador
     */
    public static boolean isAdmin(HttpServletRequest request) {
        return hasRole(request, "admin");
    }
    
    /**
     * Invalida la sesión del usuario
     */
    public static void logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
    
    /**
     * Genera un token CSRF simple
     */
    public static String generateCSRFToken(HttpSession session) {
        String token = java.util.UUID.randomUUID().toString();
        session.setAttribute("csrf_token", token);
        return token;
    }
    
    /**
     * Valida token CSRF
     */
    public static boolean validateCSRFToken(HttpSession session, String token) {
        String sessionToken = (String) session.getAttribute("csrf_token");
        return sessionToken != null && sessionToken.equals(token);
    }
    
    /**
     * Limpia el token CSRF después de usarlo
     */
    public static void clearCSRFToken(HttpSession session) {
        session.removeAttribute("csrf_token");
    }
}