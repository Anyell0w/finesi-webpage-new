package com.finesi.webapp.servlet;

import com.finesi.webapp.dao.ContactoDAO;
import com.finesi.webapp.model.Contacto;
import com.finesi.webapp.model.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ContactosAdminServlet", urlPatterns = {"/admin/contactos"})
public class ContactosServlet extends HttpServlet {
    
    private ContactoDAO contactoDAO;
    
    @Override
    public void init() throws ServletException {
        contactoDAO = new ContactoDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Obtener todos los contactos
            List<Contacto> contactos = contactoDAO.obtenerTodos();
            
            // Calcular estadísticas
            int totalContactos = contactos.size();
            int pendientes = contactoDAO.contarPorEstado("pendiente");
            int respondidos = contactoDAO.contarPorEstado("respondido");
            
            // Establecer atributos para el JSP
            request.setAttribute("contactos", contactos);
            request.setAttribute("totalContactos", totalContactos);
            request.setAttribute("pendientes", pendientes);
            request.setAttribute("respondidos", respondidos);
            
            // Reenviar a la página JSP
            request.getRequestDispatcher("/WEB-INF/views/admin/contactos.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/contactos?error=Error al cargar los contactos");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String accion = request.getParameter("accion");
        String redirectUrl = request.getContextPath() + "/admin/contactos";
        
        try {
            if ("actualizar_estado".equals(accion)) {
                // Actualizar estado del contacto
                String idContactoStr = request.getParameter("id_contacto");
                String nuevoEstado = request.getParameter("nuevo_estado");
                
                if (idContactoStr != null && nuevoEstado != null) {
                    int idContacto = Integer.parseInt(idContactoStr);
                    
                    // Validar que el estado sea válido
                    if ("pendiente".equals(nuevoEstado) || "respondido".equals(nuevoEstado)) {
                        boolean actualizado = contactoDAO.actualizarEstado(idContacto, nuevoEstado);
                        
                        if (actualizado) {
                            redirectUrl += "?success=estado-actualizado";
                        } else {
                            redirectUrl += "?error=No se pudo actualizar el estado";
                        }
                    } else {
                        redirectUrl += "?error=Estado inválido";
                    }
                } else {
                    redirectUrl += "?error=Parámetros inválidos";
                }
                
            } else if ("eliminar".equals(accion)) {
                // Eliminar contacto
                String idContactoStr = request.getParameter("id_contacto");
                
                if (idContactoStr != null) {
                    int idContacto = Integer.parseInt(idContactoStr);
                    boolean eliminado = contactoDAO.eliminar(idContacto);
                    
                    if (eliminado) {
                        redirectUrl += "?success=contacto-eliminado";
                    } else {
                        redirectUrl += "?error=No se pudo eliminar el contacto";
                    }
                } else {
                    redirectUrl += "?error=ID de contacto inválido";
                }
                
            } else {
                redirectUrl += "?error=Acción no válida";
            }
            
        } catch (NumberFormatException e) {
            redirectUrl += "?error=ID de contacto inválido";
        } catch (Exception e) {
            e.printStackTrace();
            redirectUrl += "?error=Error interno del servidor";
        }
        
        response.sendRedirect(redirectUrl);
    }
}