// ProgramaEstudio.java
package com.finesi.webapp.model;

public class ProgramaEstudio {
    private Integer idPrograma;
    private String nombre;
    private String descripcion;
    private Integer anio;
    private String estado;
    
    // Constructores
    public ProgramaEstudio() {}
    
    public ProgramaEstudio(String nombre, String descripcion, Integer anio) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.anio = anio;
        this.estado = "vigente";
    }
    
    // Getters y Setters
    public Integer getIdPrograma() { return idPrograma; }
    public void setIdPrograma(Integer idPrograma) { this.idPrograma = idPrograma; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    
    public Integer getAnio() { return anio; }
    public void setAnio(Integer anio) { this.anio = anio; }
    
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}