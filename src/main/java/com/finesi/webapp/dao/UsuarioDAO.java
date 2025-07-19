// UsuarioDAO.java - Versión simplificada sin BCrypt
package com.finesi.webapp.dao;

import com.finesi.webapp.config.DatabaseConfig;
import com.finesi.webapp.model.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    
    /**
     * Autenticación simple SIN BCrypt (para desarrollo/testing)
	 * @param username
     */
    public Usuario autenticar(String username, String password) {
        String sql = "SELECT * FROM finesi.usuarios WHERE username = ? AND password = ?";
        
        System.out.println("UsuarioDAO: Intentando autenticar usuario: " + username);
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            System.out.println("UsuarioDAO: Ejecutando consulta de autenticación");
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Usuario usuario = mapearUsuario(rs);
                    System.out.println("UsuarioDAO: Usuario encontrado - " + usuario.getUsername() + " - Rol: " + usuario.getRol());
                    
                    // Actualizar último acceso
                    actualizarUltimoAcceso(usuario.getIdUsuario());
                    
                    return usuario;
                } else {
                    System.out.println("UsuarioDAO: No se encontró usuario con esas credenciales");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en UsuarioDAO.autenticar(): " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Usuario> obtenerTodos() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM finesi.usuarios ORDER BY nombre";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                usuarios.add(mapearUsuario(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarios;
    }
    
    public boolean crear(Usuario usuario) {
        String sql = "INSERT INTO finesi.usuarios (nombre, apellido, email, username, password, rol, fecha_creacion) VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getApellido());
            stmt.setString(3, usuario.getEmail());
            stmt.setString(4, usuario.getUsername());
            stmt.setString(5, usuario.getPassword()); // Guardar contraseña tal como viene
            stmt.setString(6, usuario.getRol());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private void actualizarUltimoAcceso(Integer idUsuario) {
        String sql = "UPDATE finesi.usuarios SET ultimo_acceso = CURRENT_TIMESTAMP WHERE id_usuario = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, idUsuario);
            stmt.executeUpdate();
            System.out.println("UsuarioDAO: Último acceso actualizado para usuario ID: " + idUsuario);
        } catch (SQLException e) {
            System.err.println("Error al actualizar último acceso: " + e.getMessage());
        }
    }
    
    public Usuario obtenerPorUsername(String username) {
        String sql = "SELECT * FROM finesi.usuarios WHERE username = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearUsuario(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private Usuario mapearUsuario(ResultSet rs) throws SQLException {
        Usuario usuario = new Usuario();
        usuario.setIdUsuario(rs.getInt("id_usuario"));
        usuario.setNombre(rs.getString("nombre"));
        usuario.setApellido(rs.getString("apellido"));
        usuario.setEmail(rs.getString("email"));
        usuario.setUsername(rs.getString("username"));
        // NO mapear la contraseña por seguridad
        usuario.setRol(rs.getString("rol"));
        
        Timestamp fechaCreacion = rs.getTimestamp("fecha_creacion");
        if (fechaCreacion != null) {
            usuario.setFechaCreacion(fechaCreacion.toLocalDateTime());
        }
        
        Timestamp ultimoAcceso = rs.getTimestamp("ultimo_acceso");
        if (ultimoAcceso != null) {
            usuario.setUltimoAcceso(ultimoAcceso.toLocalDateTime());
        }
        
        return usuario;
    }
    
    /**
     * Método para verificar conexión BD
     */
    public boolean verificarConexion() {
        String sql = "SELECT COUNT(*) FROM finesi.usuarios";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("UsuarioDAO: Conexión OK - Total usuarios: " + count);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error de conexión BD: " + e.getMessage());
        }
        return false;
    }
}