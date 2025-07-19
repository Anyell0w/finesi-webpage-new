// ProgramaEstudioDAO.java
package com.finesi.webapp.dao;

import com.finesi.webapp.config.DatabaseConfig;
import com.finesi.webapp.model.ProgramaEstudio;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProgramaEstudioDAO {
    
    public List<ProgramaEstudio> obtenerActivos() {
        List<ProgramaEstudio> programas = new ArrayList<>();
        String sql = "SELECT * FROM finesi.programa_estudios WHERE estado = 'vigente' ORDER BY nombre";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                programas.add(mapearPrograma(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return programas;
    }
    
    public List<ProgramaEstudio> obtenerTodos() {
        List<ProgramaEstudio> programas = new ArrayList<>();
        String sql = "SELECT * FROM finesi.programa_estudios ORDER BY nombre";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                programas.add(mapearPrograma(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return programas;
    }
    
    public boolean crear(ProgramaEstudio programa) {
        String sql = "INSERT INTO finesi.programa_estudios (nombre, descripcion, anio, estado) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, programa.getNombre());
            stmt.setString(2, programa.getDescripcion());
            stmt.setInt(3, programa.getAnio());
            stmt.setString(4, programa.getEstado());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private ProgramaEstudio mapearPrograma(ResultSet rs) throws SQLException {
        ProgramaEstudio programa = new ProgramaEstudio();
        programa.setIdPrograma(rs.getInt("id_programa"));
        programa.setNombre(rs.getString("nombre"));
        programa.setDescripcion(rs.getString("descripcion"));
        programa.setAnio(rs.getInt("anio"));
        programa.setEstado(rs.getString("estado"));
        return programa;
    }
}