// LoginServlet.java
package com.finesi.webapp.servlet;

import com.finesi.webapp.dao.UsuarioDAO;
import com.finesi.webapp.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    
    private final UsuarioDAO usuarioDAO = new UsuarioDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("LoginServlet: Mostrando página de login");
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        System.out.println("LoginServlet: Intento de login - Usuario: " + username);
        
        if (username == null || username.trim().isEmpty()) {
            System.out.println("LoginServlet: Username vacío");
            request.setAttribute("error", "El nombre de usuario es requerido");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            System.out.println("LoginServlet: Password vacío");
            request.setAttribute("error", "La contraseña es requerida");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        try {
            Usuario usuario = usuarioDAO.autenticar(username, password);
            
            if (usuario != null) {
                System.out.println("LoginServlet: Autenticación exitosa para " + username + " - Rol: " + usuario.getRol());
                
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                
                System.out.println("LoginServlet: Redirigiendo a /admin");
                response.sendRedirect(request.getContextPath() + "/admin/");
            } else {
                System.out.println("LoginServlet: Autenticación fallida para " + username);
                request.setAttribute("error", "Usuario o contraseña incorrectos");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error en LoginServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error interno del servidor");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}