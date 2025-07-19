<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.finesi.webapp.model.Noticia" %>
<%@ page import="com.finesi.webapp.model.Usuario" %>
<%@ page import="com.finesi.webapp.model.Contacto" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - FINESI Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .admin-sidebar {
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .stat-card {
            transition: transform 0.2s;
        }
        .stat-card:hover {
            transform: translateY(-2px);
        }
        .message-preview {
            max-width: 200px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .badge-nuevo {
            background-color: #dc3545;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/admin">
                <i class="bi bi-speedometer2 me-2"></i>FINESI Admin
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="<%= request.getContextPath() %>/admin">
                            <i class="bi bi-house me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/admin/nueva-noticia">
                            <i class="bi bi-plus-circle me-1"></i>Nueva Noticia
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/admin/contactos">
                            <i class="bi bi-envelope me-1"></i>Mensajes
                            <%
                                List<Contacto> contactos = (List<Contacto>) request.getAttribute("contactos");
                                int mensajesNuevos = 0;
                                if (contactos != null) {
                                    for (Contacto c : contactos) {
                                        if ("pendiente".equals(c.getEstado())) {
                                            mensajesNuevos++;
                                        }
                                    }
                                }
                                if (mensajesNuevos > 0) {
                            %>
                                <span class="badge badge-nuevo ms-1"><%= mensajesNuevos %></span>
                            <% } %>
                        </a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle me-1"></i><%= usuario.getNombre() %>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/inicio" target="_blank">
                                <i class="bi bi-globe me-2"></i>Ver sitio web
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="<%= request.getContextPath() %>/logout">
                                <i class="bi bi-box-arrow-right me-2"></i>Cerrar sesión
                            </a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Main Content -->
            <main class="col-12 px-4">
                <!-- Page Header -->
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="bi bi-speedometer2 me-2"></i>Panel de Control
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <a href="<%= request.getContextPath() %>/admin/nueva-noticia" class="btn btn-sm btn-primary">
                                <i class="bi bi-plus-circle me-1"></i>Nueva Noticia
                            </a>
                            <a href="<%= request.getContextPath() %>/admin/contactos" class="btn btn-sm btn-outline-primary">
                                <i class="bi bi-envelope me-1"></i>Mensajes
                                <% if (mensajesNuevos > 0) { %>
                                    <span class="badge bg-danger ms-1"><%= mensajesNuevos %></span>
                                <% } %>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Messages -->
                <% if ("noticia-creada".equals(request.getParameter("success"))) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i>¡Noticia creada exitosamente!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <% if ("noticia-eliminada".equals(request.getParameter("success"))) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i>¡Noticia eliminada exitosamente!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <% if ("contacto-eliminado".equals(request.getParameter("success"))) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i>¡Contacto eliminado exitosamente!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <% if ("contacto-actualizado".equals(request.getParameter("success"))) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i>¡Estado del contacto actualizado exitosamente!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <% if (request.getParameter("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>Error al procesar la solicitud.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <%
                        List<Noticia> noticias = (List<Noticia>) request.getAttribute("noticias");
                        int totalNoticias = noticias != null ? noticias.size() : 0;
                        int totalContactos = contactos != null ? contactos.size() : 0;
                        
                        // Contar noticias por estado
                        int noticiasPublicadas = 0;
                        int noticiasBorrador = 0;
                        
                        if (noticias != null) {
                            for (Noticia noticia : noticias) {
                                String estado = noticia.getEstado();
                                if ("publicado".equals(estado) || "activo".equals(estado)) {
                                    noticiasPublicadas++;
                                } else if ("borrador".equals(estado)) {
                                    noticiasBorrador++;
                                }
                            }
                        }
                    %>
                    
                    <!-- Total Noticias -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card text-white bg-primary">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="me-3">
                                        <i class="bi bi-newspaper display-4"></i>
                                    </div>
                                    <div>
                                        <div class="text-white-75 small">Total Noticias</div>
                                        <div class="display-5 fw-bold"><%= totalNoticias %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Noticias Publicadas -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card text-white bg-success">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="me-3">
                                        <i class="bi bi-check-circle display-4"></i>
                                    </div>
                                    <div>
                                        <div class="text-white-75 small">Publicadas</div>
                                        <div class="display-5 fw-bold"><%= noticiasPublicadas %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Noticias Borrador -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card text-white bg-warning">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="me-3">
                                        <i class="bi bi-pencil-square display-4"></i>
                                    </div>
                                    <div>
                                        <div class="text-white-75 small">Borradores</div>
                                        <div class="display-5 fw-bold"><%= noticiasBorrador %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Mensajes de Contacto -->
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card text-white bg-info">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="me-3">
                                        <i class="bi bi-envelope display-4"></i>
                                    </div>
                                    <div>
                                        <div class="text-white-75 small">Mensajes</div>
                                        <div class="display-5 fw-bold"><%= totalContactos %></div>
                                        <% if (mensajesNuevos > 0) { %>
                                            <small class="text-white-75">(<%= mensajesNuevos %> nuevos)</small>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Content Grid -->
                <div class="row">
                    <!-- Noticias Recientes -->
                    <div class="col-lg-6 mb-4">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">
                                    <i class="bi bi-newspaper me-2"></i>Noticias Recientes
                                </h5>
                                <a href="<%= request.getContextPath() %>/admin/nueva-noticia" class="btn btn-sm btn-primary">
                                    <i class="bi bi-plus"></i> Nueva
                                </a>
                            </div>
                            <div class="card-body">
                                <%
                                if (noticias != null && !noticias.isEmpty()) {
                                    int maxMostrar = Math.min(noticias.size(), 5);
                                %>
                                    <div class="table-responsive">
                                        <table class="table table-hover table-sm">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Título</th>
                                                    <th>Fecha</th>
                                                    <th>Estado</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                for (int i = 0; i < maxMostrar; i++) {
                                                    Noticia noticia = noticias.get(i);
                                                    String estadoClass = "";
                                                    if ("publicado".equals(noticia.getEstado()) || "activo".equals(noticia.getEstado())) {
                                                        estadoClass = "success";
                                                    } else if ("borrador".equals(noticia.getEstado())) {
                                                        estadoClass = "warning";
                                                    } else {
                                                        estadoClass = "secondary";
                                                    }
                                                %>
                                                    <tr>
                                                        <td>
                                                            <div class="fw-bold" style="font-size: 0.9rem;">
                                                                <%= noticia.getTitulo().length() > 40 ? noticia.getTitulo().substring(0, 40) + "..." : noticia.getTitulo() %>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <small><%= noticia.getFechaPublicacion().toLocalDate() %></small>
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-<%= estadoClass %>">
                                                                <%= noticia.getEstado() %>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <div class="btn-group btn-group-sm">
                                                                <button class="btn btn-outline-danger btn-sm" 
                                                                        onclick="confirmarEliminacionNoticia(<%= noticia.getIdNoticia() %>, '<%= noticia.getTitulo().replace("'", "\\'") %>')">
                                                                    <i class="bi bi-trash"></i>
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                    
                                    <% if (noticias.size() > 5) { %>
                                        <div class="text-center mt-3">
                                            <small class="text-muted">
                                                Mostrando 5 de <%= noticias.size() %> noticias
                                            </small>
                                        </div>
                                    <% } %>
                                    
                                <% } else { %>
                                    <div class="text-center py-4">
                                        <i class="bi bi-newspaper display-4 text-muted"></i>
                                        <h6 class="text-muted mt-2">No hay noticias</h6>
                                        <a href="<%= request.getContextPath() %>/admin/nueva-noticia" class="btn btn-primary btn-sm">
                                            <i class="bi bi-plus-circle me-1"></i>Crear Primera Noticia
                                        </a>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>

                    <!-- Contactos Recientes -->
                    <div class="col-lg-6 mb-4">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">
                                    <i class="bi bi-envelope me-2"></i>Mensajes de Contacto
                                    <% if (mensajesNuevos > 0) { %>
                                        <span class="badge bg-danger ms-2"><%= mensajesNuevos %></span>
                                    <% } %>
                                </h5>
                            </div>
                            <div class="card-body">
                                <%
                                if (contactos != null && !contactos.isEmpty()) {
                                    int maxContactos = Math.min(contactos.size(), 5);
                                %>
                                    <div class="table-responsive">
                                        <table class="table table-hover table-sm">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Nombre</th>
                                                    <th>Asunto</th>
                                                    <th>Fecha</th>
                                                    <th>Estado</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                                                for (int i = 0; i < maxContactos; i++) {
                                                    Contacto contacto = contactos.get(i);
                                                    boolean esNuevo = "pendiente".equals(contacto.getEstado());
                                                    String estadoClass = esNuevo ? "danger" : "success";
                                                %>
                                                    <tr <%= esNuevo ? "class=\"table-warning\"" : "" %>>
                                                        <td>
                                                            <div class="fw-bold" style="font-size: 0.9rem;">
                                                                <%= contacto.getNombre().length() > 20 ? contacto.getNombre().substring(0, 20) + "..." : contacto.getNombre() %>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <span style="font-size: 0.85rem;">
                                                                <%= contacto.getAsunto().length() > 25 ? contacto.getAsunto().substring(0, 25) + "..." : contacto.getAsunto() %>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <small><%= contacto.getFechaEnvio().format(formatter) %></small>
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-<%= estadoClass %>">
                                                                <%= contacto.getEstado() %>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <div class="btn-group btn-group-sm">
                                                                <button class="btn btn-outline-danger btn-sm" 
                                                                        onclick="confirmarEliminacionContacto(<%= contacto.getIdContacto() %>, '<%= contacto.getNombre().replace("'", "\\'") %>')" 
                                                                        title="Eliminar">
                                                                    <i class="bi bi-trash"></i>
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                    
                                    <% if (contactos.size() > 5) { %>
                                        <div class="text-center mt-3">
                                            <small class="text-muted">
                                                Mostrando 5 de <%= contactos.size() %> contactos
                                            </small>
                                        </div>
                                    <% } %>
                                    
                                <% } else { %>
                                    <div class="text-center py-4">
                                        <i class="bi bi-envelope display-4 text-muted"></i>
                                        <h6 class="text-muted mt-2">No hay mensajes</h6>
                                        <p class="text-muted small">Los mensajes de contacto aparecerán aquí</p>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Acciones Rápidas -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="bi bi-lightning-charge me-2"></i>Acciones Rápidas
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 mb-2">
                                        <a href="<%= request.getContextPath() %>/admin/nueva-noticia" class="btn btn-primary w-100">
                                            <i class="bi bi-plus-circle me-2"></i>Nueva Noticia
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="<%= request.getContextPath() %>/noticias" class="btn btn-outline-info w-100" target="_blank">
                                            <i class="bi bi-eye me-2"></i>Ver Noticias Públicas
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="<%= request.getContextPath() %>/contacto" class="btn btn-outline-success w-100" target="_blank">
                                            <i class="bi bi-envelope me-2"></i>Ver Página de Contacto
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-2">
                                        <a href="<%= request.getContextPath() %>/inicio" class="btn btn-outline-secondary w-100" target="_blank">
                                            <i class="bi bi-globe me-2"></i>Ver Sitio Web
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Modal de Confirmación de Eliminación de Noticias -->
    <div class="modal fade" id="confirmDeleteNoticiaModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirmar Eliminación de Noticia</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>¿Estás seguro de que deseas eliminar la noticia?</p>
                    <p class="fw-bold" id="noticiaTitle"></p>
                    <p class="text-danger small">Esta acción no se puede deshacer.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <form id="deleteNoticiaForm" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="eliminar-noticia">
                        <input type="hidden" name="id" id="noticiaId">
                        <button type="submit" class="btn btn-danger">Eliminar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de Confirmación de Eliminación de Contactos -->
    <div class="modal fade" id="confirmDeleteContactoModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirmar Eliminación de Contacto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>¿Estás seguro de que deseas eliminar este contacto?</p>
                    <p class="fw-bold" id="contactoNombre"></p>
                    <p class="text-danger small">Esta acción no se puede deshacer.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <form id="deleteContactoForm" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="eliminar-contacto">
                        <input type="hidden" name="id" id="contactoId">
                        <button type="submit" class="btn btn-danger">Eliminar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de Detalle de Contacto -->
    <div class="modal fade" id="detalleContactoModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Detalle del Contacto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h6>Nombre:</h6>
                            <p id="detalleNombre"></p>
                        </div>
                        <div class="col-md-6">
                            <h6>Email:</h6>
                            <p id="detalleEmail"></p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <h6>Asunto:</h6>
                            <p id="detalleAsunto"></p>
                        </div>
                        <div class="col-md-6">
                            <h6>Fecha:</h6>
                            <p id="detalleFecha"></p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <h6>Mensaje:</h6>
                            <p id="detalleMensaje" class="border p-3 bg-light"></p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <a id="detalleEmailLink" href="#" class="btn btn-primary">
                        <i class="bi bi-envelope me-1"></i>Responder por Email
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);

        // Funciones para confirmar eliminación de noticias
        function confirmarEliminacionNoticia(idNoticia, titulo) {
            document.getElementById('noticiaTitle').textContent = titulo;
            document.getElementById('noticiaId').value = idNoticia;
            
            var modal = new bootstrap.Modal(document.getElementById('confirmDeleteNoticiaModal'));
            modal.show();
        }

        // Funciones para confirmar eliminación de contactos
        function confirmarEliminacionContacto(idContacto, nombre) {
            document.getElementById('contactoNombre').textContent = nombre;
            document.getElementById('contactoId').value = idContacto;
            
            var modal = new bootstrap.Modal(document.getElementById('confirmDeleteContactoModal'));
            modal.show();
        }

        // Función para marcar contacto
        function marcarContacto(idContacto, estado) {
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '<%= request.getContextPath() %>/admin';
            
            var actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'marcar-contacto';
            form.appendChild(actionInput);
            
            var idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = idContacto;
            form.appendChild(idInput);
            
            var estadoInput = document.createElement('input');
            estadoInput.type = 'hidden';
            estadoInput.name = 'estado';
            estadoInput.value = estado;
            form.appendChild(estadoInput);
            
            document.body.appendChild(form);
            form.submit();
        }

        // Función para ver detalle de contacto
        function verDetalleContacto(idContacto) {
            // Buscar el contacto en la tabla para mostrar sus datos
            var fila = document.querySelector(`button[onclick="verDetalleContacto(${idContacto})"]`).closest('tr');
            var celdas = fila.querySelectorAll('td');
            
            // Extraer datos básicos de la tabla
            var nombre = celdas[0].textContent.trim();
            var asunto = celdas[1].textContent.trim();
            var fecha = celdas[2].textContent.trim();
            
            // Mostrar los datos en el modal
            document.getElementById('detalleNombre').textContent = nombre;
            document.getElementById('detalleAsunto').textContent = asunto;
            document.getElementById('detalleFecha').textContent = fecha;
            document.getElementById('detalleEmail').textContent = 'Cargando...';
            document.getElementById('detalleMensaje').textContent = 'Cargando...';
            
            // Configurar enlace de email
            document.getElementById('detalleEmailLink').href = '#';
            
            var modal = new bootstrap.Modal(document.getElementById('detalleContactoModal'));
            modal.show();
            
            // Aquí podrías hacer una llamada AJAX para obtener el detalle completo
            // Por ahora, mostramos la información básica
            document.getElementById('detalleEmail').textContent = 'Ver detalles completos próximamente';
            document.getElementById('detalleMensaje').textContent = 'Para ver el mensaje completo, implementa la funcionalidad de detalle.';
        }
    </script>
</body>
</html>