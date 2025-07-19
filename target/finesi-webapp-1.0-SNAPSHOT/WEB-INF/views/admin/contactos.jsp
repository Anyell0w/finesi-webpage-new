<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.finesi.webapp.model.Contacto" %>
<%@ page import="com.finesi.webapp.model.Usuario" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
    <title>Gestión de Contactos - FINESI Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .message-preview {
            max-width: 300px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .status-badge {
            font-size: 0.75rem;
        }
        .table-responsive {
            border-radius: 0.375rem;
        }
        .card-stats {
            border-left: 4px solid;
        }
        .card-stats.pendiente {
            border-left-color: #dc3545;
        }
        .card-stats.respondido {
            border-left-color: #198754;
        }
        .card-stats.total {
            border-left-color: #0d6efd;
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
            
            <div class="navbar-nav">
                <a class="nav-link" href="<%= request.getContextPath() %>/admin">
                    <i class="bi bi-arrow-left me-1"></i>Volver al Dashboard
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h2">
                <i class="bi bi-envelope me-2"></i>Gestión de Contactos
            </h1>
        </div>

        <!-- Messages -->
        <%
            String successParam = request.getParameter("success");
            String errorParam = request.getParameter("error");
        %>
        <% if ("contacto-eliminado".equals(successParam)) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle me-2"></i>Contacto eliminado exitosamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <% if ("estado-actualizado".equals(successParam)) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle me-2"></i>Estado del contacto actualizado exitosamente.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <% if (errorParam != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i>Error al procesar la solicitud: <%= errorParam %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <%
                Integer totalContactos = (Integer) request.getAttribute("totalContactos");
                Integer pendientes = (Integer) request.getAttribute("pendientes");
                Integer respondidos = (Integer) request.getAttribute("respondidos");
                
                if (totalContactos == null) totalContactos = 0;
                if (pendientes == null) pendientes = 0;
                if (respondidos == null) respondidos = 0;
            %>
            <div class="col-md-4">
                <div class="card card-stats total">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="card-title text-primary">Total</h5>
                                <h3 class="mb-0"><%= totalContactos %></h3>
                            </div>
                            <i class="bi bi-envelope-fill text-primary" style="font-size: 2rem;"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card card-stats pendiente">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="card-title text-danger">Pendientes</h5>
                                <h3 class="mb-0"><%= pendientes %></h3>
                            </div>
                            <i class="bi bi-clock-fill text-danger" style="font-size: 2rem;"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card card-stats respondido">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="card-title text-success">Respondidos</h5>
                                <h3 class="mb-0"><%= respondidos %></h3>
                            </div>
                            <i class="bi bi-check-circle-fill text-success" style="font-size: 2rem;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contacts Table -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="bi bi-list-ul me-2"></i>Lista de Contactos
                </h5>
            </div>
            <div class="card-body">
                <%
                    List<Contacto> contactos = (List<Contacto>) request.getAttribute("contactos");
                    if (contactos != null && !contactos.isEmpty()) {
                %>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Nombre</th>
                                    <th>Email</th>
                                    <th>Asunto</th>
                                    <th>Mensaje</th>
                                    <th>Fecha</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                                    for (Contacto contacto : contactos) {
                                        String estado = contacto.getEstado();
                                        String estadoClass = "pendiente".equals(estado) ? "danger" : "success";
                                        String estadoIcon = "pendiente".equals(estado) ? "bi-clock" : "bi-check-circle";
                                        boolean esPendiente = "pendiente".equals(estado);
                                        
                                        // Escapar comillas para JavaScript
                                        String nombreEscapado = contacto.getNombre().replace("'", "\\'").replace("\"", "&quot;");
                                        String emailEscapado = contacto.getEmail().replace("'", "\\'").replace("\"", "&quot;");
                                        String asuntoEscapado = contacto.getAsunto().replace("'", "\\'").replace("\"", "&quot;");
                                        String mensajeEscapado = contacto.getMensaje().replace("'", "\\'").replace("\"", "&quot;").replace("\n", "\\n").replace("\r", "\\r");
                                %>
                                    <tr <%= esPendiente ? "class=\"table-warning\"" : "" %>>
                                        <td>
                                            <div class="fw-bold"><%= contacto.getNombre() %></div>
                                        </td>
                                        <td>
                                            <a href="mailto:<%= contacto.getEmail() %>" class="text-decoration-none">
                                                <%= contacto.getEmail() %>
                                            </a>
                                        </td>
                                        <td>
                                            <span class="fw-medium"><%= contacto.getAsunto() %></span>
                                        </td>
                                        <td>
                                            <div class="message-preview">
                                                <%= contacto.getMensaje() %>
                                            </div>
                                        </td>
                                        <td>
                                            <small><%= contacto.getFechaEnvio().format(formatter) %></small>
                                        </td>
                                        <td>
                                            <span class="badge bg-<%= estadoClass %> status-badge">
                                                <i class="bi <%= estadoIcon %> me-1"></i>
                                                <%= estado %>
                                            </span>
                                        </td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <button class="btn btn-outline-primary" 
                                                        onclick="verDetalleContacto('<%= nombreEscapado %>', '<%= emailEscapado %>', '<%= asuntoEscapado %>', '<%= mensajeEscapado %>', '<%= contacto.getFechaEnvio().format(formatter) %>')" 
                                                        title="Ver detalle">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                
                                                <!-- Botones de cambio de estado -->
                                                <% if (!"pendiente".equals(estado)) { %>
                                                    <button class="btn btn-outline-warning btn-sm" 
                                                            onclick="cambiarEstado(<%= contacto.getIdContacto() %>, 'pendiente')" 
                                                            title="Marcar como Pendiente">
                                                        <i class="bi bi-clock"></i>
                                                    </button>
                                                <% } %>
                                                
                                                <% if (!"respondido".equals(estado)) { %>
                                                    <button class="btn btn-outline-success btn-sm" 
                                                            onclick="cambiarEstado(<%= contacto.getIdContacto() %>, 'respondido')" 
                                                            title="Marcar como Respondido">
                                                        <i class="bi bi-check-circle"></i>
                                                    </button>
                                                <% } %>
                                                
                                                <button class="btn btn-outline-danger" 
                                                        onclick="confirmarEliminacion(<%= contacto.getIdContacto() %>, '<%= nombreEscapado %>', '<%= asuntoEscapado %>')" 
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
                <% } else { %>
                    <div class="text-center py-5">
                        <i class="bi bi-envelope display-1 text-muted"></i>
                        <h4 class="text-muted mt-3">No hay contactos</h4>
                        <p class="text-muted">Los mensajes de contacto aparecerán aquí cuando los usuarios envíen el formulario.</p>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Form oculto para cambio de estado -->
    <form id="estadoForm" method="post" style="display: none;">
        <input type="hidden" name="accion" value="actualizar_estado">
        <input type="hidden" name="id_contacto" id="estadoId">
        <input type="hidden" name="nuevo_estado" id="nuevoEstado">
    </form>

    <!-- Modal de Confirmación de Eliminación -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirmar Eliminación</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>¿Estás seguro de que deseas eliminar este contacto?</p>
                    <div class="border-start border-primary ps-3">
                        <p class="mb-1"><strong>Nombre:</strong> <span id="contactoNombre"></span></p>
                        <p class="mb-0"><strong>Asunto:</strong> <span id="contactoAsunto"></span></p>
                    </div>
                    <p class="text-danger small mt-3">Esta acción no se puede deshacer.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <form id="deleteForm" method="post" style="display: inline;">
                        <input type="hidden" name="accion" value="eliminar">
                        <input type="hidden" name="id_contacto" id="deleteId">
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
                        <i class="bi bi-reply me-1"></i>Responder por Email
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

        // Función para cambiar estado
        function cambiarEstado(idContacto, nuevoEstado) {
            document.getElementById('estadoId').value = idContacto;
            document.getElementById('nuevoEstado').value = nuevoEstado;
            document.getElementById('estadoForm').action = '<%= request.getContextPath() %>/admin/contactos';
            document.getElementById('estadoForm').submit();
        }

        // Función para confirmar eliminación
        function confirmarEliminacion(idContacto, nombre, asunto) {
            document.getElementById('contactoNombre').textContent = nombre;
            document.getElementById('contactoAsunto').textContent = asunto;
            document.getElementById('deleteId').value = idContacto;
            document.getElementById('deleteForm').action = '<%= request.getContextPath() %>/admin/contactos';
            
            var modal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
            modal.show();
        }

        // Función para ver detalle del contacto
        function verDetalleContacto(nombre, email, asunto, mensaje, fecha) {
            document.getElementById('detalleNombre').textContent = nombre;
            document.getElementById('detalleEmail').textContent = email;
            document.getElementById('detalleAsunto').textContent = asunto;
            document.getElementById('detalleFecha').textContent = fecha;
            document.getElementById('detalleMensaje').textContent = mensaje;
            
            // Configurar enlace de respuesta por email
            var emailLink = document.getElementById('detalleEmailLink');
            var subject = encodeURIComponent('Re: ' + asunto);
            var body = encodeURIComponent('Hola ' + nombre + ',\n\nGracias por contactarnos. En respuesta a tu mensaje:\n\n"' + mensaje + '"\n\n');
            emailLink.href = 'mailto:' + email + '?subject=' + subject + '&body=' + body;
            
            var modal = new bootstrap.Modal(document.getElementById('detalleContactoModal'));
            modal.show();
        }
    </script>
</body>
</html>