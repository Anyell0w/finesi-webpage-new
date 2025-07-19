// NoticiaDAO.java - Versión corregida
package com.finesi.webapp.dao;

import com.finesi.webapp.config.DatabaseConfig;
import com.finesi.webapp.model.Noticia;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NoticiaDAO {
    
    public List<Noticia> obtenerActivas() {
        List<Noticia> noticias = new ArrayList<>();
        // CAMBIADO: Buscar 'publicado' en lugar de 'activo'
        String sql = "SELECT * FROM finesi.noticias WHERE estado IN ('publicado', 'activo') ORDER BY fecha_publicacion DESC";;
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                noticias.add(mapearNoticia(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return noticias;
    }
    
    public List<Noticia> obtenerTodas() {
        List<Noticia> noticias = new ArrayList<>();
        String sql = "SELECT * FROM finesi.noticias ORDER BY fecha_publicacion DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                noticias.add(mapearNoticia(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return noticias;
    }
    
    public Noticia obtenerPorId(Integer id) {
        String sql = "SELECT * FROM finesi.noticias WHERE id_noticia = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearNoticia(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean crear(Noticia noticia) {
        String sql = "INSERT INTO finesi.noticias (titulo, contenido, resumen, imagen_url, fecha_publicacion, estado, id_usuario, slug) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, noticia.getTitulo());
            stmt.setString(2, noticia.getContenido());
            stmt.setString(3, noticia.getResumen());
            stmt.setString(4, noticia.getImagenUrl());
            stmt.setString(5, "activo"); // CAMBIADO: Usar 'publicado' por defecto
            stmt.setInt(6, noticia.getIdUsuario());
            stmt.setString(7, generarSlug(noticia.getTitulo()));
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean actualizar(Noticia noticia) {
        String sql = "UPDATE finesi.noticias SET titulo = ?, contenido = ?, resumen = ?, imagen_url = ?, estado = ? WHERE id_noticia = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, noticia.getTitulo());
            stmt.setString(2, noticia.getContenido());
            stmt.setString(3, noticia.getResumen());
            stmt.setString(4, noticia.getImagenUrl());
            stmt.setString(5, noticia.getEstado());
            stmt.setInt(6, noticia.getIdNoticia());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean eliminar(Integer id) {
        // CAMBIADO: Marcar como 'oculto' en lugar de 'inactivo'
        String sql = "UPDATE finesi.noticias SET estado = 'inactivo' WHERE id_noticia = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private Noticia mapearNoticia(ResultSet rs) throws SQLException {
        Noticia noticia = new Noticia();
        noticia.setIdNoticia(rs.getInt("id_noticia"));
        noticia.setTitulo(rs.getString("titulo"));
        noticia.setContenido(rs.getString("contenido"));
        noticia.setResumen(rs.getString("resumen"));
        noticia.setImagenUrl(rs.getString("imagen_url"));
        noticia.setEstado(rs.getString("estado"));
        noticia.setIdUsuario(rs.getInt("id_usuario"));
        noticia.setSlug(rs.getString("slug"));
        
        Timestamp fechaPublicacion = rs.getTimestamp("fecha_publicacion");
        if (fechaPublicacion != null) {
            noticia.setFechaPublicacion(fechaPublicacion.toLocalDateTime());
        }
        
        return noticia;
    }
    
    private String generarSlug(String titulo) {
        return titulo.toLowerCase()
                .replaceAll("[^a-z0-9\\s]", "")
                .replaceAll("\\s+", "-")
                .trim();
    }

    public List<Noticia> obtenerRecientes(int limite) {
	    List<Noticia> noticias = new ArrayList<>();
	    String sql = "SELECT * FROM finesi.noticias ORDER BY fecha_publicacion DESC LIMIT ?";
	    
	    try (Connection conn = DatabaseConfig.getConnection();
		 PreparedStatement stmt = conn.prepareStatement(sql)) {
		
		stmt.setInt(1, limite);
		
		try (ResultSet rs = stmt.executeQuery()) {
		    while (rs.next()) {
			noticias.add(mapearNoticia(rs));
		    }
		}
	    } catch (SQLException e) {
		e.printStackTrace();
	    }
	    return noticias;
	}

    public List<Noticia> obtenerPublicadasRecientes(int limite) {
	    List<Noticia> noticias = new ArrayList<>();
	    String sql = "SELECT * FROM finesi.noticias WHERE estado IN ('publicado', 'activo') ORDER BY fecha_publicacion DESC LIMIT ?";
	    
	    try (Connection conn = DatabaseConfig.getConnection();
		 PreparedStatement stmt = conn.prepareStatement(sql)) {
		
		stmt.setInt(1, limite);
		
		try (ResultSet rs = stmt.executeQuery()) {
		    while (rs.next()) {
			noticias.add(mapearNoticia(rs));
		    }
		}
	    } catch (SQLException e) {
		e.printStackTrace();
	    }
	    return noticias;
	}

    public boolean eliminarCompletamente(Integer id) {
	    String sql = "DELETE FROM finesi.noticias WHERE id_noticia = ?";
	    
	    try (Connection conn = DatabaseConfig.getConnection();
		 PreparedStatement stmt = conn.prepareStatement(sql)) {
		
		stmt.setInt(1, id);
		return stmt.executeUpdate() > 0;
	    } catch (SQLException e) {
		e.printStackTrace();
		return false;
	    }
	}
}