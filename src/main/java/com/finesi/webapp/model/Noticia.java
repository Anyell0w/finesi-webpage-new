// Noticia.java
package com.finesi.webapp.model;

import java.time.LocalDateTime;

public class Noticia {
    private Integer id_noticia;
    private String titulo;
    private String contenido;
    private String resumen;
    private String imagenUrl;
    private LocalDateTime fechaPublicacion;
    private String estado;
    private Integer id_usuario;
    private String slug;
    
    // Constructores
    public Noticia() {}
    
    public Noticia(String titulo, String contenido, String resumen, Integer id_usuario) {
        this.titulo = titulo;
        this.contenido = contenido;
        this.resumen = resumen;
        this.id_usuario = id_usuario;
        this.estado = "activo";
    }
    
    // Getters y Setters
    public Integer getIdNoticia() { return id_noticia; }
    public void setIdNoticia(Integer id_noticia) { this.id_noticia = id_noticia; }
    
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    
    public String getContenido() { return contenido; }
    public void setContenido(String contenido) { this.contenido = contenido; }
    
    public String getResumen() { return resumen; }
    public void setResumen(String resumen) { this.resumen = resumen; }
    
    public String getImagenUrl() { return imagenUrl; }
    public void setImagenUrl(String imagenUrl) { this.imagenUrl = imagenUrl; }
    
    public LocalDateTime getFechaPublicacion() { return fechaPublicacion; }
    public void setFechaPublicacion(LocalDateTime fechaPublicacion) { this.fechaPublicacion = fechaPublicacion; }
    
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    
    public Integer getIdUsuario() { return id_usuario; }
    public void setIdUsuario(Integer id_usuario) { this.id_usuario = id_usuario; }
    
    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }
}
