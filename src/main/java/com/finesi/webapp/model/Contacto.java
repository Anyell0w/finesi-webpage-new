// Contacto.java
package com.finesi.webapp.model;

import java.time.LocalDateTime;

public class Contacto {
    private Integer idContacto;
    private String nombre;
    private String email;
    private String asunto;
    private String mensaje;
    private LocalDateTime fechaEnvio;
    private String estado;
    
    // Constructores
    public Contacto() {}
    
    public Contacto(String nombre, String email, String asunto, String mensaje) {
        this.nombre = nombre;
        this.email = email;
        this.asunto = asunto;
        this.mensaje = mensaje;
	this.estado = "pendiente";
    }
    
    // Getters y Setters
    public Integer getIdContacto() { return idContacto; }
    public void setIdContacto(Integer idContacto) { this.idContacto = idContacto; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getAsunto() { return asunto; }
    public void setAsunto(String asunto) { this.asunto = asunto; }
    
    public String getMensaje() { return mensaje; }
    public void setMensaje(String mensaje) { this.mensaje = mensaje; }
    
    public LocalDateTime getFechaEnvio() { return fechaEnvio; }
    public void setFechaEnvio(LocalDateTime fechaEnvio) { this.fechaEnvio = fechaEnvio; }

    public String getEstado() { return estado; } 
    public void setEstado(String estado) { this.estado = estado; }

}