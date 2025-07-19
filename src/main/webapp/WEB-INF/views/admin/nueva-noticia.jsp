<!-- admin/nueva-noticia.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/includes/header.jsp">
    <jsp:param name="title" value="Nueva Noticia" />
</jsp:include>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1><i class="bi bi-newspaper me-2"></i>Nueva Noticia</h1>
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
                <input type="hidden" name="action" value="crear-noticia">
                
                <div class="mb-3">
                    <label class="form-label">Título *</label>
                    <input type="text" name="titulo" class="form-control" required maxlength="200">
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Resumen *</label>
                    <textarea name="resumen" class="form-control" rows="3" required maxlength="500" 
                              placeholder="Breve descripción de la noticia..."></textarea>
                    <div class="form-text">Máximo 500 caracteres</div>
                </div>
                
                
		<div class="mb-3">
		    <label class="form-label">Contenido *</label>
		    <div id="tinymce-editor" style="min-height: 300px;"></div>
		    <textarea id="contenido-texto-plano" name="contenido" style="display:none;" required></textarea>
		</div>

                <div class="mb-3">
                    <label class="form-label">URL de Imagen</label>
                    <input type="url" name="imagenUrl" class="form-control" maxlength="255"
                           placeholder="https://ejemplo.com/imagen.jpg">
                    <div class="form-text">URL de una imagen para acompañar la noticia (opcional)</div>
                </div>
                
                <div class="d-flex justify-content-end gap-2">
                    <a href="<%=request.getContextPath()%>/admin" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-save me-2"></i>Crear Noticia
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>


<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
<script src="https://cdn.tiny.cloud/1/rdwqrf9jhmwh2y2ekweeqlvlx6b783pru641mzsmig83sl5j/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    tinymce.init({
        selector: '#tinymce-editor',
        plugins: 'lists',
        toolbar: 'bold italic underline | bullist numlist',
        menubar: false,
        statusbar: false,
        height: 300,
        setup: function(editor) {
            editor.on('init', function() {
                // Inicializar con contenido existente si hay
                editor.setContent(document.getElementById('contenido-texto-plano').value);
            });
            editor.on('change keyup', function() {
                updatePlainTextContent();
            });
        }
    });
    
    function htmlToPlainText(html) {
        // Crear elemento temporal para extraer texto
        const temp = document.createElement('div');
        temp.innerHTML = html;
        
        // Convertir listas a texto con viñetas
        temp.querySelectorAll('li').forEach(li => {
            li.innerHTML = '• ' + li.innerHTML;
        });
        
        // Convertir elementos de lista a saltos de línea
        temp.querySelectorAll('ul, ol').forEach(list => {
            list.outerHTML = Array.from(list.children)
                .map(li => li.innerHTML + '\n')
                .join('');
        });
        
        // Reemplazar etiquetas de formato
        temp.innerHTML = temp.innerHTML
            .replace(/<strong>/g, '*').replace(/<\/strong>/g, '*')
            .replace(/<em>/g, '_').replace(/<\/em>/g, '_')
            .replace(/<u>/g, '').replace(/<\/u>/g, '')
            .replace(/<br>/g, '\n')
            .replace(/&nbsp;/g, ' ');
        
        // Obtener texto plano
        const plainText = temp.textContent || temp.innerText || '';
        
        // Limpiar espacios múltiples y saltos de línea
        return plainText.replace(/\n\s*\n/g, '\n\n').trim();
    }
    
    function updatePlainTextContent() {
        const htmlContent = tinymce.get('tinymce-editor').getContent();
        const plainText = htmlToPlainText(htmlContent);
        document.getElementById('contenido-texto-plano').value = plainText;
    }
    
    // Manejar el envío del formulario
    document.querySelector('form').addEventListener('submit', function(e) {
        updatePlainTextContent();
        
        // Validar que el contenido no esté vacío
        const contenido = document.getElementById('contenido-texto-plano').value.trim();
        if (!contenido) {
            e.preventDefault();
            alert('El contenido de la noticia no puede estar vacío');
            tinymce.get('tinymce-editor').focus();
        }
    });
});
</script>