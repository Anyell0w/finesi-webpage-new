<!-- admin/nuevo-programa.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/includes/header.jsp">
    <jsp:param name="title" value="Nuevo Programa" />
</jsp:include>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1><i class="bi bi-book me-2"></i>Nuevo Programa de Estudio</h1>
        <a href="<%=request.getContextPath()%>/admin" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-2"></i>Volver al Panel
        </a>
    </div>
    
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i><%=request.getAttribute("error")%>
        </div>
    <% } %>
    
    <div class="card">
        <div class="card-body">
            <form method="post" action="<%=request.getContextPath()%>/admin">
                <input type="hidden" name="action" value="crear-programa">
                
                <div class="mb-3">
                    <label class="form-label">Nombre del Programa *</label>
                    <input type="text" name="nombre" class="form-control" required maxlength="200"
                           placeholder="Ej: Ingeniería Estadística e Informática">
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Descripción *</label>
                    <textarea name="descripcion" class="form-control" rows="6" required maxlength="255"
                              placeholder="Descripción detallada del programa de estudios..."></textarea>
                    <div class="form-text">Máximo 255 caracteres</div>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Año *</label>
                    <input type="number" name="anio" class="form-control" required min="1990" max="2030" 
                           value="2025" placeholder="2025">
                    <div class="form-text">Año de creación o última actualización del programa</div>
                </div>
                
                <div class="d-flex justify-content-end gap-2">
                    <a href="<%=request.getContextPath()%>/admin" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-save me-2"></i>Crear Programa
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />