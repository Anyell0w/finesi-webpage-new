// ContactoDAO.java
package com.finesi.webapp.dao;

import com.finesi.webapp.config.DatabaseConfig;
import com.finesi.webapp.model.Contacto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactoDAO {
    
    public List<Contacto> obtenerTodos() {
        List<Contacto> contactos = new ArrayList<>();
        String sql = "SELECT * FROM finesi.contactos ORDER BY fecha_envio DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                contactos.add(mapearContacto(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contactos;
    }
    
    public Contacto obtenerPorId(Integer id) {
        String sql = "SELECT * FROM finesi.contactos WHERE id_contacto= ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearContacto(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean crear(Contacto contacto) {
        String sql = "INSERT INTO finesi.contactos (nombre, email, asunto, mensaje, fecha_envio, estado) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP, 'pendiente')";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, contacto.getNombre());
            stmt.setString(2, contacto.getEmail());
            stmt.setString(3, contacto.getAsunto());
            stmt.setString(4, contacto.getMensaje());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean eliminar(Integer id) {
        String sql = "DELETE FROM finesi.contactos WHERE id_contacto = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Contacto> obtenerRecientes(int limite) {
        List<Contacto> contactos = new ArrayList<>();
        String sql = "SELECT * FROM finesi.contactos ORDER BY fecha_envio DESC LIMIT ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limite);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    contactos.add(mapearContacto(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contactos;
    }
    
    private Contacto mapearContacto(ResultSet rs) throws SQLException {
        Contacto contacto = new Contacto();
        contacto.setIdContacto(rs.getInt("id_contacto"));
        contacto.setNombre(rs.getString("nombre"));
        contacto.setEmail(rs.getString("email"));
        contacto.setAsunto(rs.getString("asunto"));
        contacto.setMensaje(rs.getString("mensaje"));
	contacto.setEstado(rs.getString("estado"));
        
        Timestamp fechaEnvio = rs.getTimestamp("fecha_envio");
        if (fechaEnvio != null) {
            contacto.setFechaEnvio(fechaEnvio.toLocalDateTime());
        }
        
        return contacto;
    }

    public boolean actualizarEstado(Integer id, String estado) {
	    String sql = "UPDATE finesi.contactos SET estado = ? WHERE id_contacto = ?";
	    
	    try (Connection conn = DatabaseConfig.getConnection();
		 PreparedStatement stmt = conn.prepareStatement(sql)) {
		
		stmt.setString(1, estado);
		stmt.setInt(2, id);
		
		return stmt.executeUpdate() > 0;
	    } catch (SQLException e) {
		e.printStackTrace();
		return false;
	    }
	}

    public List<Contacto> obtenerPorEstado(String estado) {
	    List<Contacto> contactos = new ArrayList<>();
	    String sql = "SELECT * FROM finesi.contactos WHERE estado = ? ORDER BY fecha_envio DESC";
	    
	    try (Connection conn = DatabaseConfig.getConnection();
		 PreparedStatement stmt = conn.prepareStatement(sql)) {
		
		stmt.setString(1, estado);
		
		try (ResultSet rs = stmt.executeQuery()) {
		    while (rs.next()) {
			contactos.add(mapearContacto(rs));
		    }
		}
	    } catch (SQLException e) {
		e.printStackTrace();
	    }
	    return contactos;
	}


    public int contarPorEstado(String estado) {
	    String sql = "SELECT COUNT(*) FROM finesi.contactos WHERE estado = ?";
	    
	    try (Connection conn = DatabaseConfig.getConnection();
		 PreparedStatement stmt = conn.prepareStatement(sql)) {
		
		stmt.setString(1, estado);
		
		try (ResultSet rs = stmt.executeQuery()) {
		    if (rs.next()) {
			return rs.getInt(1);
		    }
		}
	    } catch (SQLException e) {
		e.printStackTrace();
	    }
	    return 0;
	}

}