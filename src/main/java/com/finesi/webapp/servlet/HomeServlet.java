// HomeServlet.java
package com.finesi.webapp.servlet;

import com.finesi.webapp.dao.NoticiaDAO;
import com.finesi.webapp.dao.ProgramaEstudioDAO;
import com.finesi.webapp.model.Noticia;
import com.finesi.webapp.model.ProgramaEstudio;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/", "/inicio"})
public class HomeServlet extends HttpServlet {
    
    private NoticiaDAO noticiaDAO = new NoticiaDAO();
    private ProgramaEstudioDAO programaDAO = new ProgramaEstudioDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("HomeServlet: Iniciando carga de página principal");
        
        try {
            // Obtener las últimas 3 noticias activas para mostrar en inicio
            List<Noticia> noticiasRecientes = noticiaDAO.obtenerPublicadasRecientes(3);
            System.out.println("HomeServlet: Total noticias obtenidas: " + noticiasRecientes.size());
            
            // Debug: Imprimir títulos de las noticias
            for (int i = 0; i < noticiasRecientes.size(); i++) {
                System.out.println("Noticia " + (i+1) + ": " + noticiasRecientes.get(i).getTitulo());
            }
            
            // Obtener programas activos (comentado temporalmente)
            // List<ProgramaEstudio> programas = programaDAO.obtenerActivos();
            
            // IMPORTANTE: Cambiar el nombre del atributo para que coincida con el JSP
            request.setAttribute("noticiasRecientes", noticiasRecientes);
            // request.setAttribute("programas", programas);
            
            System.out.println("HomeServlet: Redirigiendo a inicio.jsp");
            request.getRequestDispatcher("/WEB-INF/views/inicio.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error en HomeServlet: " + e.getMessage());
            e.printStackTrace();
            // En caso de error, continuar sin noticias
            request.setAttribute("noticiasRecientes", new ArrayList<Noticia>());
            request.getRequestDispatcher("/WEB-INF/views/inicio.jsp").forward(request, response);
        }
    }
}