<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.finesi.webapp.model.Noticia" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<jsp:include page="/WEB-INF/views/includes/header.jsp">
    <jsp:param name="title" value="Inicio" />
    <jsp:param name="active" value="inicio" />
</jsp:include>

<div class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="display-4 fw-bold mb-4">Facultad de Ingeniería Estadística e Informática</h1>
                <p class="lead mb-4">Formamos profesionales de excelencia en estadística e informática, 
                   comprometidos con el desarrollo tecnológico y científico de nuestra región.</p>
                <a href="<%= request.getContextPath() %>/programas" class="btn btn-light btn-lg">
                    Conoce nuestros programas
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container my-5">
    <section class="mb-5">
        <h2 class="mb-4">Bienvenidos a FINESI</h2>
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-graph-up display-4 text-primary mb-3"></i>
                        <h5 class="card-title">Estadística</h5>
                        <p class="card-text">Análisis de datos, investigación cuantitativa y modelado estadístico.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-laptop display-4 text-primary mb-3"></i>
                        <h5 class="card-title">Informática</h5>
                        <p class="card-text">Desarrollo de software, sistemas de información y tecnologías emergentes.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-people display-4 text-primary mb-3"></i>
                        <h5 class="card-title">Investigación</h5>
                        <p class="card-text">Proyectos de investigación aplicada y desarrollo tecnológico.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Sección de Noticias -->
    <section class="mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">
                <i class="bi bi-newspaper text-primary me-2"></i>
                Noticias Recientes
            </h2>
            <a href="<%= request.getContextPath() %>/noticias" class="btn btn-outline-primary">
                <i class="bi bi-arrow-right me-1"></i>Ver todas las noticias
            </a>
        </div>
        
        <%
            List<Noticia> noticiasRecientes = (List<Noticia>) request.getAttribute("noticiasRecientes");
            if (noticiasRecientes != null && !noticiasRecientes.isEmpty()) {
        %>
            <div class="row">
                <%
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    int maxNoticias = Math.min(noticiasRecientes.size(), 3);
                    for (int i = 0; i < maxNoticias; i++) {
                        Noticia noticia = noticiasRecientes.get(i);
                        String titulo = noticia.getTitulo();
                        String resumen = noticia.getResumen();
                        String imagenUrl = noticia.getImagenUrl();
                %>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm">
                            <% if (imagenUrl != null && !imagenUrl.trim().isEmpty()) { %>
                                <img src="<%= imagenUrl %>" class="card-img-top" alt="<%= titulo %>" style="height: 200px; object-fit: cover;">
                            <% } else { %>
                                <div class="card-img-top bg-light d-flex align-items-center justify-content-center" style="height: 200px;">
                                    <i class="bi bi-newspaper text-muted" style="font-size: 3rem;"></i>
                                </div>
                            <% } %>
                            <div class="card-body d-flex flex-column">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <small class="text-muted">
                                        <i class="bi bi-calendar me-1"></i>
                                        <%= noticia.getFechaPublicacion().format(formatter) %>
                                    </small>
                                </div>
                                <h5 class="card-title">
                                    <%= (titulo.length() > 50) ? titulo.substring(0, 50) + "..." : titulo %>
                                </h5>
                                <p class="card-text flex-grow-1">
                                    <%= (resumen.length() > 100) ? resumen.substring(0, 100) + "..." : resumen %>
                                </p>
                                <div class="mt-auto">
                                    <a href="<%= request.getContextPath() %>/noticias" class="btn btn-primary btn-sm">
                                        <i class="bi bi-book me-1"></i>Leer más
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
            
            <% if (noticiasRecientes.size() > 3) { %>
                <div class="text-center mt-3">
                    <p class="text-muted mb-3">
                        <i class="bi bi-info-circle me-1"></i>
                        Mostrando 3 de <%= noticiasRecientes.size() %> noticias recientes
                    </p>
                    <a href="<%= request.getContextPath() %>/noticias" class="btn btn-primary">
                        <i class="bi bi-newspaper me-2"></i>Ver todas las noticias
                    </a>
                </div>
            <% } %>
            
        <% } else { %>
            <div class="card">
                <div class="card-body text-center py-5">
                    <i class="bi bi-newspaper display-4 text-muted mb-3"></i>
                    <h5 class="text-muted">No hay noticias disponibles</h5>
                    <p class="text-muted mb-0">Las noticias aparecerán aquí cuando se publiquen.</p>
                </div>
            </div>
        <% } %>
    </section>
    
    <section>
        <h2 class="mb-4">Información Destacada</h2>
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-mortarboard text-primary me-2"></i>
                            Excelencia Académica
                        </h5>
                        <p class="card-text">Programas académicos de alta calidad con docentes especializados y infraestructura moderna.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">
                            <i class="bi bi-building text-primary me-2"></i>
                            Laboratorios Modernos
                        </h5>
                        <p class="card-text">Espacios equipados con tecnología de vanguardia para el aprendizaje práctico.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />