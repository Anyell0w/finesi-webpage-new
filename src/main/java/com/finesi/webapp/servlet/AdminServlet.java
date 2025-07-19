// AdminServlet.java
package com.finesi.webapp.servlet;

import com.finesi.webapp.dao.NoticiaDAO;
import com.finesi.webapp.dao.ContactoDAO;
import com.finesi.webapp.model.Noticia;
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

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin", "/admin/*"})
public class AdminServlet extends HttpServlet {
    
    private final NoticiaDAO noticiaDAO = new NoticiaDAO();
    private final ContactoDAO contactoDAO = new ContactoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("AdminServlet: Acceso a panel de administración");
        
        HttpSession session = request.getSession(false);
        Usuario usuario = null;
        
        if (session != null) {
            usuario = (Usuario) session.getAttribute("usuario");
        }
        
        if (usuario == null) {
            System.out.println("AdminServlet: Usuario no autenticado, redirigiendo a login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        System.out.println("AdminServlet: Usuario autenticado: " + usuario.getUsername() + " - Rol: " + usuario.getRol());
        
        String pathInfo = request.getPathInfo();
        System.out.println("AdminServlet: PathInfo: " + pathInfo);
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Dashboard principal
            try {
                List<Noticia> noticias = noticiaDAO.obtenerTodas();
                List<Contacto> contactos = contactoDAO.obtenerTodos();
                
                System.out.println("AdminServlet: Cargando dashboard con " + noticias.size() + " noticias y " + contactos.size() + " contactos");
                
                request.setAttribute("noticias", noticias);
                request.setAttribute("contactos", contactos);
                request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
                
            } catch (Exception e) {
                System.err.println("Error en AdminServlet dashboard: " + e.getMessage());
                e.printStackTrace();
                response.sendError(500, "Error al cargar el dashboard");
            }
            
        } else if (pathInfo.equals("/nueva-noticia")) {
            System.out.println("AdminServlet: Mostrando formulario nueva noticia");
            request.getRequestDispatcher("/WEB-INF/views/admin/nueva-noticia.jsp").forward(request, response);
            
        } else if (pathInfo.startsWith("/contacto/")) {
            // Ver detalle de contacto
            verDetalleContacto(request, response, pathInfo);
        } else if (pathInfo.startsWith("/contactos")) {
            // Ver detalle de contacto
            mostrarContactos(request, response);
            
        } else {
            System.out.println("AdminServlet: Ruta no encontrada: " + pathInfo);
            response.sendError(404, "Página no encontrada");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Usuario usuario = null;
        
        if (session != null) {
            usuario = (Usuario) session.getAttribute("usuario");
        }
        
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        System.out.println("AdminServlet POST: Action = " + action);
        
        if ("crear-noticia".equals(action)) {
            crearNoticia(request, response, usuario);
        } else if ("eliminar-noticia".equals(action)) {
            eliminarNoticia(request, response);
        } else if ("eliminar-contacto".equals(action)) {
            eliminarContacto(request, response);
        } else if ("marcar-contacto".equals(action)) {
            marcarContacto(request, response);
        } else {
            response.sendError(400, "Acción no válida");
        }
    }
    
    private void crearNoticia(HttpServletRequest request, HttpServletResponse response, Usuario usuario)
            throws ServletException, IOException {
        
        String titulo = request.getParameter("titulo");
        String contenido = request.getParameter("contenido");
        String resumen = request.getParameter("resumen");
        String imagenUrl = request.getParameter("imagenUrl");
        
        System.out.println("AdminServlet: Creando noticia - Título: " + titulo);
        
        if (titulo == null || titulo.trim().isEmpty()) {
            request.setAttribute("error", "El título es requerido");
            request.getRequestDispatcher("/WEB-INF/views/admin/nueva-noticia.jsp").forward(request, response);
            return;
        }
        
        if (contenido == null || contenido.trim().isEmpty()) {
            request.setAttribute("error", "El contenido es requerido");
            request.getRequestDispatcher("/WEB-INF/views/admin/nueva-noticia.jsp").forward(request, response);
            return;
        }
        
        if (resumen == null || resumen.trim().isEmpty()) {
            request.setAttribute("error", "El resumen es requerido");
            request.getRequestDispatcher("/WEB-INF/views/admin/nueva-noticia.jsp").forward(request, response);
            return;
        }
        
        try {
            Noticia noticia = new Noticia(titulo.trim(), contenido.trim(), resumen.trim(), usuario.getIdUsuario());
            if (imagenUrl != null && !imagenUrl.trim().isEmpty()) {
                noticia.setImagenUrl(imagenUrl.trim());
            }
            
            boolean creada = noticiaDAO.crear(noticia);
            
            if (creada) {
                System.out.println("AdminServlet: Noticia creada exitosamente");
                response.sendRedirect(request.getContextPath() + "/admin?success=noticia-creada");
            } else {
                System.out.println("AdminServlet: Error al crear noticia en BD");
                request.setAttribute("error", "Error al crear la noticia");
                request.getRequestDispatcher("/WEB-INF/views/admin/nueva-noticia.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("Error al crear noticia: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error interno del servidor");
            request.getRequestDispatcher("/WEB-INF/views/admin/nueva-noticia.jsp").forward(request, response);
        }
    }
    
    private void eliminarNoticia(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        System.out.println("AdminServlet: Eliminando noticia ID: " + idStr);
        
        try {
            Integer id = Integer.parseInt(idStr);
            boolean eliminada = noticiaDAO.eliminar(id);
            
            if (eliminada) {
                System.out.println("AdminServlet: Noticia eliminada exitosamente");
                response.sendRedirect(request.getContextPath() + "/admin?success=noticia-eliminada");
            } else {
                System.out.println("AdminServlet: Error al eliminar noticia");
                response.sendRedirect(request.getContextPath() + "/admin?error=error-eliminar");
            }
            
        } catch (NumberFormatException e) {
            System.err.println("ID de noticia inválido: " + idStr);
            response.sendRedirect(request.getContextPath() + "/admin?error=id-invalido");
        } catch (Exception e) {
            System.err.println("Error al eliminar noticia: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin?error=error-servidor");
        }
    }
    private void mostrarContactos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            List<Contacto> contactos = contactoDAO.obtenerTodos();
            request.setAttribute("contactos", contactos);
            
            // Calcular estadísticas
            int totalContactos = contactos.size();
            int pendientes = 0, respondidos = 0;
            
            for (Contacto contacto : contactos) {
                if ("pendiente".equals(contacto.getEstado())) {
                    pendientes++;
                } else if ("respondido".equals(contacto.getEstado())) {
                    respondidos++;
                }
            }
            
            request.setAttribute("totalContactos", totalContactos);
            request.setAttribute("pendientes", pendientes);
            request.setAttribute("respondidos", respondidos);
            
            System.out.println("AdminServlet: Mostrando página de contactos - Total: " + totalContactos);
            request.getRequestDispatcher("/WEB-INF/views/admin/contactos.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error al mostrar contactos: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar los contactos");
            request.getRequestDispatcher("/WEB-INF/views/admin/contactos.jsp").forward(request, response);
        }
    }
    
    private void eliminarContacto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        System.out.println("AdminServlet: Eliminando contacto ID: " + idStr);
        
        try {
            Integer id = Integer.parseInt(idStr);
            boolean eliminado = contactoDAO.eliminar(id);
            
            if (eliminado) {
                System.out.println("AdminServlet: Contacto eliminado exitosamente");
                response.sendRedirect(request.getContextPath() + "/admin?success=contacto-eliminado");
            } else {
                System.out.println("AdminServlet: Error al eliminar contacto");
                response.sendRedirect(request.getContextPath() + "/admin?error=error-eliminar");
            }
            
        } catch (NumberFormatException e) {
            System.err.println("ID de contacto inválido: " + idStr);
            response.sendRedirect(request.getContextPath() + "/admin?error=id-invalido");
        } catch (Exception e) {
            System.err.println("Error al eliminar contacto: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin?error=error-servidor");
        }
    }
    
    private void marcarContacto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        String estado = request.getParameter("estado");
        System.out.println("AdminServlet: Marcando contacto ID: " + idStr + " como: " + estado);
        
        try {
            Integer id = Integer.parseInt(idStr);
            boolean actualizado = contactoDAO.actualizarEstado(id, estado);
            
            if (actualizado) {
                System.out.println("AdminServlet: Estado del contacto actualizado exitosamente");
                response.sendRedirect(request.getContextPath() + "/admin?success=contacto-actualizado");
            } else {
                System.out.println("AdminServlet: Error al actualizar estado del contacto");
                response.sendRedirect(request.getContextPath() + "/admin?error=error-actualizar");
            }
            
        } catch (NumberFormatException e) {
            System.err.println("ID de contacto inválido: " + idStr);
            response.sendRedirect(request.getContextPath() + "/admin?error=id-invalido");
        } catch (Exception e) {
            System.err.println("Error al actualizar contacto: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin?error=error-servidor");
        }
    }
    
    private void verDetalleContacto(HttpServletRequest request, HttpServletResponse response, String pathInfo)
            throws ServletException, IOException {
        
        try {
            String idStr = pathInfo.substring("/contacto/".length());
            Integer id = Integer.parseInt(idStr);
            
            Contacto contacto = contactoDAO.obtenerPorId(id);
            
            if (contacto == null) {
                response.sendError(404, "Contacto no encontrado");
                return;
            }
            
            request.setAttribute("contacto", contacto);
            request.getRequestDispatcher("/WEB-INF/views/admin/detalle-contacto.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(400, "ID de contacto inválido");
        } catch (Exception e) {
            System.err.println("Error al obtener detalle del contacto: " + e.getMessage());
            e.printStackTrace();
            response.sendError(500, "Error interno del servidor");
        }
    }
}