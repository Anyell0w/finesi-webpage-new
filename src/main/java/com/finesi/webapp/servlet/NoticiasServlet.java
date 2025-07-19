// NoticiasServlet.java
package com.finesi.webapp.servlet;

import com.finesi.webapp.dao.NoticiaDAO;
import com.finesi.webapp.model.Noticia;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "NoticiasServlet", urlPatterns = {"/noticias"})
public class NoticiasServlet extends HttpServlet {
    
    private NoticiaDAO noticiaDAO = new NoticiaDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("NoticiasServlet: Iniciando carga de página de noticias");
        
        try {
            List<Noticia> noticias = noticiaDAO.obtenerActivas();
            System.out.println("NoticiasServlet: Total noticias obtenidas: " + noticias.size());
            
            // Debug: Imprimir títulos de las noticias
            for (int i = 0; i < noticias.size(); i++) {
                System.out.println("Noticia " + (i+1) + ": " + noticias.get(i).getTitulo());
            }
            
            request.setAttribute("noticias", noticias);
            System.out.println("NoticiasServlet: Redirigiendo a noticias.jsp");
            
            request.getRequestDispatcher("/WEB-INF/views/noticias.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error en NoticiasServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(500, "Error interno del servidor");
        }
    }
}