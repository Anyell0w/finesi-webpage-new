<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String title = request.getParameter("title");
    String active = request.getParameter("active");
    Object usuario = session.getAttribute("usuario");
    if (title == null) title = "FINESI";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= title %> - FINESI</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .navbar-brand {
            font-weight: bold;
            color: #0d47a1 !important;
        }
        .hero-section {
            background: linear-gradient(135deg, #000000, #0d47a1);
            color: white;
            padding: 4rem 0;
        }
        .card {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border: none;
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-2px);
        }
        footer {
            background: linear-gradient(135deg, #000000, #0d47a1);
            background-color: #0d47a1;
            color: white;
        }
        .btn-primary {
            background-color: #1976d2;
            border-color: #1976d2;
        }
        .btn-primary:hover {
            background-color: #0d47a1;
            border-color: #0d47a1;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
        <div class="container">
		<a class="navbar-brand" href="<%= request.getContextPath() %>/inicio">
		    <img style="height: 40px;"src="https://i.ibb.co/mCY0tkxp/logo.png">
		</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link <%= "inicio".equals(active) ? "active" : "" %>" 
                           href="<%= request.getContextPath() %>/inicio">Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= "noticias".equals(active) ? "active" : "" %>" 
                           href="<%= request.getContextPath() %>/noticias">Noticias</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= "programas".equals(active) ? "active" : "" %>" 
                           href="<%= request.getContextPath() %>/programas">Programas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= "contacto".equals(active) ? "active" : "" %>" 
                           href="<%= request.getContextPath() %>/contacto">Contacto</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <% if (usuario != null) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/admin">
                                <i class="bi bi-gear"></i> Admin
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/logout">
                                <i class="bi bi-box-arrow-right"></i> Salir
                            </a>
                        </li>
                    <% } else { %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/login">
                                <i class="bi bi-person"></i> Acceder
                            </a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>