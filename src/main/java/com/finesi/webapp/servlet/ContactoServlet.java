// ContactoServlet.java
package com.finesi.webapp.servlet;

import com.finesi.webapp.dao.ContactoDAO;
import com.finesi.webapp.model.Contacto;
import com.finesi.webapp.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ContactoServlet", urlPatterns = {"/contacto"})
public class ContactoServlet extends HttpServlet {
    
    private ContactoDAO contactoDAO = new ContactoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Mostrar página de contacto
        request.getRequestDispatcher("/WEB-INF/views/contacto.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtener datos del formulario
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String asunto = request.getParameter("asunto");
        String mensaje = request.getParameter("mensaje");
        
        // Sanitizar inputs
        nombre = ValidationUtil.sanitizeInput(nombre);
        email = ValidationUtil.sanitizeInput(email);
        asunto = ValidationUtil.sanitizeInput(asunto);
        mensaje = ValidationUtil.sanitizeInput(mensaje);
        
        // Validar datos
        if (!ValidationUtil.isValidName(nombre)) {
            request.setAttribute("error", "El nombre debe tener entre 2 y 50 caracteres y solo contener letras");
            request.getRequestDispatcher("/WEB-INF/views/contacto.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "El formato del email no es válido");
            request.getRequestDispatcher("/WEB-INF/views/contacto.jsp").forward(request, response);
            return;
        }
        
        if (asunto == null || asunto.trim().length() < 5 || asunto.trim().length() > 100) {
            request.setAttribute("error", "El asunto debe tener entre 5 y 100 caracteres");
            request.getRequestDispatcher("/WEB-INF/views/contacto.jsp").forward(request, response);
            return;
        }
        
        if (mensaje == null || mensaje.trim().length() < 10 || mensaje.trim().length() > 1000) {
            request.setAttribute("error", "El mensaje debe tener entre 10 y 1000 caracteres");
            request.getRequestDispatcher("/WEB-INF/views/contacto.jsp").forward(request, response);
            return;
        }
        
        // Crear objeto Contacto
        Contacto contacto = new Contacto();
        contacto.setNombre(nombre.trim());
        contacto.setEmail(email.trim());
        contacto.setAsunto(asunto.trim());
        contacto.setMensaje(mensaje.trim());
        
        // Guardar en base de datos
        try {
            if (contactoDAO.crear(contacto)) {
                request.setAttribute("success", "Tu mensaje ha sido enviado correctamente. Te responderemos pronto.");
                // Limpiar formulario después del éxito
                request.setAttribute("clearForm", true);
            } else {
                request.setAttribute("error", "Error al enviar el mensaje. Por favor, inténtalo de nuevo.");
                request.setAttribute("clearForm", true);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error interno del servidor. Por favor, inténtalo más tarde.");
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("/WEB-INF/views/contacto.jsp").forward(request, response);
    }
}