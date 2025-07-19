<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.finesi.webapp.model.Noticia" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Noticias - FINESI</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .card {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border: none;
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/includes/header.jsp">
	    <jsp:param name="title" value="Inicio" />
	    <jsp:param name="active" value="inicio" />
	</jsp:include>

    <div class="container my-5">
        <h1 class="mb-4"><i class="bi bi-newspaper me-2"></i>Noticias</h1>
        
        <%
            List<Noticia> noticias = (List<Noticia>) request.getAttribute("noticias");
            System.out.println("JSP: Noticias recibidas: " + (noticias != null ? noticias.size() : "null"));
            
            if (noticias != null && !noticias.isEmpty()) {
        %>
            <div class="row">
                <% 
                int count = 0;
                for (Noticia noticia : noticias) { 
                    count++;
                    System.out.println("JSP: Mostrando noticia " + count + ": " + noticia.getTitulo());
                %>
                    <div class="col-md-6 mb-4">
                        <div class="card h-100">
                            <% if (noticia.getImagenUrl() != null && !noticia.getImagenUrl().isEmpty()) { %>
                                <img src="<%= noticia.getImagenUrl() %>" 
                                     class="card-img-top" 
                                     alt="<%= noticia.getTitulo() %>" 
                                     style="height: 250px; object-fit: cover;">
                            <% } %>
                            <div class="card-body">
                                <h5 class="card-title"><%= noticia.getTitulo() %></h5>
                                <p class="card-text"><%= noticia.getResumen() %></p>
                                <% if (noticia.getContenido() != null && noticia.getContenido().length() > 100) { %>
                                    <details>
                                        <summary class="btn btn-outline-primary btn-sm">Leer más...</summary>
                                        <div class="mt-3">
                                            <%= noticia.getContenido() %>
                                        </div>
                                    </details>
                                <% } %>
                                <div class="mt-3">
                                    <small class="text-muted">
                                        <i class="bi bi-calendar me-1"></i>
                                        <%= noticia.getFechaPublicacion().toLocalDate() %>
                                        <span class="badge bg-success ms-2"><%= noticia.getEstado() %></span>
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
            
            <div class="text-center mt-4">
                <p class="text-muted">
                    <i class="bi bi-info-circle me-1"></i>
                    Mostrando <%= noticias.size() %> noticia<%= noticias.size() != 1 ? "s" : "" %>
                </p>
            </div>
            
        <% } else { %>
            <div class="row justify-content-center">
                <div class="col-md-6 text-center">
                    <div class="card">
                        <div class="card-body">
                            <i class="bi bi-newspaper display-1 text-muted"></i>
                            <h3 class="mt-3">No hay noticias disponibles</h3>
                            <p class="text-muted">Pronto publicaremos nuevas noticias.</p>
                            <a href="<%= request.getContextPath() %>/" class="btn btn-primary">
                                <i class="bi bi-house me-2"></i>Volver al inicio
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>