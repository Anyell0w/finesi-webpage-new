<!-- programas.jsp -->
<%@ page import="java.util.List" %>
<%@ page import="com.finesi.webapp.model.ProgramaEstudio" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/includes/header.jsp">
    <jsp:param name="title" value="Programas de Estudio" />
    <jsp:param name="active" value="programas" />
</jsp:include>

<style>
    body {
        background: white;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    .programa-container {
        background: rgba(255, 255, 255, 0.98);
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
        overflow: hidden;
    }
    
    .programa-header {
        background: linear-gradient(135deg, #1e3a8a, #3b82f6);
        color: white;
        padding: 25px;
        text-align: center;
    }
    
    .programa-content {
        padding: 30px;
    }
    
    .btn-malla {
        background: linear-gradient(135deg, #1e3a8a, #3b82f6);
        color: white;
        border: none;
        padding: 10px 25px;
        border-radius: 5px;
        font-size: 14px;
        font-weight: 500;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .btn-malla:hover {
        background: linear-gradient(135deg, #1e40af, #2563eb);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(59, 130, 246, 0.3);
        color: white;
    }
    
    .malla-curricular {
        background: rgba(248, 250, 252, 0.95);
        border-top: 3px solid #1e3a8a;
        padding: 30px;
        margin-top: 20px;
        border-radius: 8px;
        display: none;
    }
    
    .malla-title {
        text-align: center;
        color: #1e3a8a;
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 30px;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    
    .semestres-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
        gap: 15px;
        margin-bottom: 30px;
    }
    
    .semestre-btn {
        background: white;
        border: 2px solid #e2e8f0;
        border-radius: 6px;
        padding: 15px 10px;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        font-weight: 500;
        color: #475569;
    }
    
    .semestre-btn:hover {
        border-color: #1e3a8a;
        background: #f8fafc;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(30, 58, 138, 0.15);
    }
    
    .semestre-btn.active {
        background: #1e3a8a;
        color: white;
        border-color: #1e3a8a;
    }
    
    .semestre-number {
        font-size: 18px;
        font-weight: 700;
        color: #1e3a8a;
    }
    
    .semestre-btn.active .semestre-number {
        color: white;
    }
    
    .semestre-label {
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-top: 5px;
    }
    
    .cursos-container {
        background: white;
        border-radius: 8px;
        border: 1px solid #e2e8f0;
        overflow: hidden;
        margin-top: 20px;
        display: none;
        min-height: 100px;
    }
    
    .cursos-header {
        background: linear-gradient(135deg, #1e3a8a, #3b82f6);
        color: white;
        padding: 15px 25px;
        text-align: center;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    
    .cursos-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 1px;
        background: #e2e8f0;
        padding: 1px;
    }
    
    .curso-item {
        background: white;
        padding: 15px 20px;
        border-left: 4px solid #e2e8f0;
        transition: all 0.3s ease;
        position: relative;
    }
    
    .curso-item:hover {
        border-left-color: #1e3a8a;
        background: #f8fafc;
    }
    
    .curso-nombre {
        font-size: 14px;
        font-weight: 600;
        color: #1e293b;
        margin-bottom: 5px;
        line-height: 1.3;
    }
    
    .curso-area {
        font-size: 12px;
        color: #64748b;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 500;
    }
    
    .close-malla {
        position: absolute;
        top: 15px;
        right: 15px;
        background: none;
        border: none;
        color: #64748b;
        font-size: 18px;
        cursor: pointer;
        padding: 5px;
        border-radius: 50%;
        transition: all 0.3s ease;
    }
    
    .close-malla:hover {
        background: rgba(239, 68, 68, 0.1);
        color: #ef4444;
    }
    
    .programa-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .programa-details {
        flex: 1;
    }
    
    .programa-badges {
        display: flex;
        gap: 10px;
        margin-top: 10px;
    }
    
    .badge-custom {
        background: #1e3a8a;
        color: white;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
    }
    
    .fade-in {
        animation: fadeIn 0.5s ease-in-out;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<div class="container my-5">
    <h1 class="text-center mb-5" style="color: #1e3a8a;">
        <i class="bi bi-mortarboard me-2"></i>
        Programas de Estudio
    </h1>
    
    <%
        List<ProgramaEstudio> programas = (List<ProgramaEstudio>) request.getAttribute("programas");
        if (programas != null && !programas.isEmpty()) {
    %>
        <% for (ProgramaEstudio programa : programas) { %>
            <div class="programa-container">
                <div class="programa-header">
                    <h2 class="mb-2">
                        <i class="bi bi-cpu me-2"></i>
                        <%=programa.getNombre()%>
                    </h2>
                    <p class="mb-0 opacity-90">Escuela Profesional de Ingeniería</p>
                </div>
                
                <div class="programa-content">
                    <div class="programa-info">
                        <div class="programa-details">
                            <p class="text-muted mb-2"><%=programa.getDescripcion()%></p>
                            <div class="programa-badges">
                                <span class="badge-custom">Año <%=programa.getAnio()%></span>
                                <span class="badge-custom">10 Semestres</span>

                            </div>
                        </div>
                        <div>
                            <button class="btn-malla" onclick="toggleMalla()">
                                <i class="bi bi-grid-3x3-gap me-2"></i>
                                Ver Malla Curricular
                            </button>
                        </div>
                    </div>
                    
                    <!-- Malla Curricular -->
                    <div id="malla-curricular" class="malla-curricular position-relative">
                        <button class="close-malla" onclick="closeMalla()" title="Cerrar malla curricular">
                            <i class="bi bi-x"></i>
                        </button>
                        
                        <h3 class="malla-title">
                            Plan de Estudios - Malla Curricular
                        </h3>
                        
                        <div class="semestres-grid">
                            <% for (int i = 1; i <= 10; i++) { 
                                String[] romanos = {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"};
                            %>
                                <div class="semestre-btn" onclick="showCursos(<%=i%>); return false;">
                                    <div class="semestre-number"><%=romanos[i]%></div>
                                    <div class="semestre-label">Semestre</div>
                                </div>
                            <% } %>
                        </div>
                        
                        <div id="cursos-container" class="cursos-container">
                            <!-- Los cursos se cargarán dinámicamente -->
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    <% } else { %>
        <div class="text-center py-5">
            <div class="programa-container">
                <div class="programa-content text-center">
                    <i class="bi bi-book display-1 text-muted mb-3"></i>
                    <h3 class="text-secondary">No hay programas disponibles</h3>
                    <p class="text-muted">Pronto añadiremos información sobre nuestros programas.</p>
                </div>
            </div>
        </div>
    <% } %>
</div>

<script>
    // Datos de cursos por semestre
    const cursosPorSemestre = {
        1: [
            { nombre: "Comprensión y Argumentación", area: "Competencias Generales" },
            { nombre: "Pensamiento Racional y Ética", area: "Competencias Generales" },
            { nombre: "Matemática Básica", area: "Ciencias Básicas" },
            { nombre: "Química General", area: "Ciencias Básicas" },
            { nombre: "Estrategias de Aprendizaje", area: "Competencias Generales" },
            { nombre: "Estadística Básica", area: "Específicas" }
            
        ],
        2: [
            { nombre: "Cálculo Diferencial", area: "Ciencias Básicas" },
            { nombre: "Física General", area: "Ciencias Básicas" },
            { nombre: "Taller de Innovación y Emprendimiento", area: "Competencias Generales" },
            { nombre: "Cálculo de Probabilidades", area: "Específicas" },
            { nombre: "Ecologia y Desarrollo Sostenible", area: "Ciencias Básicas" },
            { nombre: "Análisis y Diseño de Algoritmos", area: "Especialidad" }
        ],
        3: [
            { nombre: "Seguridad y Defensa Nacional", area: "Competencias Generales" },
            { nombre: "Cálculo Integral y Ecuaciones Diferenciales", area: "Específicas" },
            { nombre: "Distribuciones de Probabilidad", area: "Específicas" },
            { nombre: "Ingles", area: "Específicas" },
            
            { nombre: "Estructura de Datos", area: "Especialidad" },
            { nombre: "Lenguajes de Programación I", area: "Especialidad" },
            { nombre: "Muestreo", area: "Especialidad" }
        ],
        4: [
            { nombre: "Lenguajes de Programación II", area: "Especialidad" },
            { nombre: "Inferencia Estadística", area: "Especialidad" },
            { nombre: "Programación Numérica", area: "Específicas" },
            { nombre: "Analisis y Diseño de Sistemas de Informacion", area: "Especialidad" },
            { nombre: "Modelos Discretos", area: "Especialidad" },
            { nombre: "Sistemas de Gestión de Base de Datos I", area: "Especialidad" }
        ],
        5: [
            { nombre: "Lenguajes de Programación III", area: "Especialidad" },
            { nombre: "Estadística No Paramétrica", area: "Específicas" },
            { nombre: "Métodos de Optimización", area: "Especialidad" },
            { nombre: "Estadistica Computacional", area: "Especialidad" },
            { nombre: "Arquitectura de Computadoras", area: "Especialidad" },
            { nombre: "Sistemas de Gestión de Base de Datos II", area: "Especialidad" }
            
        ],
        6: [
            { nombre: "Regresión Lineal y No Lineal", area: "Específicas" },
            { nombre: "Modelos Lineales", area: "Específicas" },
            { nombre: "Aprendizaje No Supervisado", area: "Especialidad" },
            { nombre: "Series de Tiempo", area: "Especialidad" },
            { nombre: "Arquitectura de Redes y Protocolos", area: "Especialidad" },
            { nombre: "Gestion de Proyectos TICs", area: "Especialidad" }
        ],
        7: [
            { nombre: "Estadística Bayesiana", area: "Específicas" },
            { nombre: "Metodología de la Investigación", area: "Específicas" },
            { nombre: "Aprendizaje Supervisado", area: "Especialidad" },
            { nombre: "Ingeniería de Software I", area: "Especialidad" },
            { nombre: "Administración de Redes", area: "Especialidad" },
            { nombre: "Sistemas Distribuidos", area: "Especialidad" }
            
        ],
        8: [
            { nombre: "Marketing", area: "Específicas" },
            { nombre: "Control Estadístico de Procesos", area: "Específicas" },
            { nombre: "Ingeniería de Software II", area: "Especialidad" },
            { nombre: "Computacion Paralela", area: "Especialidad" },
            { nombre: "Diseños Experimentales I", area: "Especialidad" },
            { nombre: "Ciencia de Datos I", area: "Especialidad" },
            { nombre: "Taller de Desarrollo de Software", area: "Especialidad" }
        ],
        9: [
            { nombre: "Investigación de Mercados", area: "Específicas" },
            { nombre: "Internet de las Cosas y Computación en las Nubes", area: "Especialidad" },
            { nombre: "Inteligencia Artificial", area: "Especialidad" },
            { nombre: "Diseños Experimentales II", area: "Especialidad" },
            { nombre: "Seguridad y Auditoría Informática", area: "Especialidad" },
            { nombre: "Ciencia de Datos II", area: "Especialidad" },
            { nombre: "Taller de Estadistica", area: "Especialidad" }
        ],
        10: [
            { nombre: "Trabajo de Investigación", area: "Específicas" },
            { nombre: "Prácticas Preprofesionales", area: "Especialidad" },
            { nombre: "Tecnologías Emergentes", area: "Especialidad" },
            { nombre: "Estadística Espacial", area: "Especialidad" },
            { nombre: "Inteligencia de Negocios", area: "Especialidad" }
        ]
    };
    
    function toggleMalla() {
        const malla = document.getElementById('malla-curricular');
        const cursosContainer = document.getElementById('cursos-container');
        
        if (malla.style.display === 'none' || malla.style.display === '') {
            malla.style.display = 'block';
            cursosContainer.style.display = 'none';
            cursosContainer.innerHTML = '';
        } else {
            malla.style.display = 'none';
            cursosContainer.style.display = 'none';
            cursosContainer.innerHTML = '';
        }
    }
    
    function closeMalla() {
        const malla = document.getElementById('malla-curricular');
        const cursosContainer = document.getElementById('cursos-container');
        malla.style.display = 'none';
        cursosContainer.style.display = 'none';
        cursosContainer.innerHTML = '';
        
        // Remover clases activas
        const buttons = document.querySelectorAll('.semestre-btn');
        buttons.forEach(btn => btn.classList.remove('active'));
    }
    
    function showCursos(semestre) {
        // Obtener el contenedor
        const cursosContainer = document.getElementById('cursos-container');
        
        // Verificar que existe
        if (!cursosContainer) {
            alert('No se encontró el contenedor de cursos');
            return;
        }
        
        // Obtener cursos
        const cursos = cursosPorSemestre[semestre];
        if (!cursos) {
            alert('No hay cursos para este semestre');
            return;
        }
        
        // Actualizar botones activos
        const buttons = document.querySelectorAll('.semestre-btn');
        buttons.forEach(btn => btn.classList.remove('active'));
        
        // Encontrar y activar el botón correcto
        const romanos = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"];
        buttons.forEach(btn => {
            const numeroElement = btn.querySelector('.semestre-number');
            if (numeroElement && numeroElement.textContent.trim() === romanos[semestre]) {
                btn.classList.add('active');
            }
        });
        
        // Crear HTML
        let html = '<div class="cursos-header">';
        html += '<i class="bi bi-book me-2"></i>';
        html += 'Semestre ' + romanos[semestre] + ' - Asignaturas';
        html += '</div>';
        html += '<div class="cursos-grid">';
        
        for (let i = 0; i < cursos.length; i++) {
            const curso = cursos[i];
            html += '<div class="curso-item">';
            html += '<div class="curso-nombre">' + curso.nombre + '</div>';
            html += '<div class="curso-area">' + curso.area + '</div>';
            html += '</div>';
        }
        
        html += '</div>';
        
        // Mostrar contenido
        cursosContainer.innerHTML = html;
        cursosContainer.style.display = 'block';
        
        // Scroll
        setTimeout(function() {
            cursosContainer.scrollIntoView({ 
                behavior: 'smooth', 
                block: 'nearest' 
            });
        }, 100);
    }
</script>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />