// Usuario.java
package com.finesi.webapp.model;

import java.time.LocalDateTime;

public class Usuario {
    private Integer id_usuario;
    private String nombre;
    private String apellido;
    private String email;
    private String username;
    private String password;
    private String rol;
    private LocalDateTime fechaCreacion;
    private LocalDateTime ultimoAcceso;
    
    // Constructores
    public Usuario() {}
    
    public Usuario(String nombre, String apellido, String email, String username, String password, String rol) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.username = username;
        this.password = password;
        this.rol = rol;
    }
    
    // Getters y Setters
    public Integer getIdUsuario() { return id_usuario; }
    public void setIdUsuario(Integer id_usuario) { this.id_usuario = id_usuario; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }
    
    public LocalDateTime getFechaCreacion() { return fechaCreacion; }
    public void setFechaCreacion(LocalDateTime fechaCreacion) { this.fechaCreacion = fechaCreacion; }
    
    public LocalDateTime getUltimoAcceso() { return ultimoAcceso; }
    public void setUltimoAcceso(LocalDateTime ultimoAcceso) { this.ultimoAcceso = ultimoAcceso; }
}
