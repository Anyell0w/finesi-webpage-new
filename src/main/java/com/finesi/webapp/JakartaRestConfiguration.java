package com.finesi.webapp;

import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;

/**
 * Configures Jakarta RESTful Web Services for the application.
 * @author FINESI Team
 */
@ApplicationPath("api")
public class JakartaRestConfiguration extends Application {
    
    // Esta clase está vacía intencionalmente
    // JAX-RS automáticamente descubrirá todos los recursos con @Path
    
}