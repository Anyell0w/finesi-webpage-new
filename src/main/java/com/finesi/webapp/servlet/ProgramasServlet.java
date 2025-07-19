// ProgramasServlet.java
package com.finesi.webapp.servlet;

import com.finesi.webapp.dao.ProgramaEstudioDAO;
import com.finesi.webapp.model.ProgramaEstudio;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProgramasServlet", urlPatterns = {"/programas"})
public class ProgramasServlet extends HttpServlet {
    
    private ProgramaEstudioDAO programaDAO = new ProgramaEstudioDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<ProgramaEstudio> programas = programaDAO.obtenerActivos();
        request.setAttribute("programas", programas);
        request.getRequestDispatcher("/WEB-INF/views/programas.jsp").forward(request, response);
    }
}


