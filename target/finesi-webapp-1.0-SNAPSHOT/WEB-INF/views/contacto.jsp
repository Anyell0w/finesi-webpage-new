<!-- contacto.jsp -->
<jsp:include page="/WEB-INF/views/includes/header.jsp">
    <jsp:param name="title" value="Contacto" />
    <jsp:param name="active" value="contacto" />
</jsp:include>

<div class="container my-5">
    <h1 class="mb-4">Contacto</h1>
    
    <!-- Mostrar mensajes de éxito o error SOLO cuando existen -->
    <c:if test="${not empty success and success.trim() != ''}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty error and error.trim() != ''}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Información de Contacto</h4>
                    
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <h5><i class="bi bi-geo-alt text-primary me-2"></i>Dirección</h5>
                            <p>Ciudad Universitaria<br>
                               Av. Floral 1153<br>
                               Puno - Perú</p>
                        </div>
                        <div class="col-md-6">
                            <h5><i class="bi bi-telephone text-primary me-2"></i>Teléfono</h5>
                            <p>(051) 36-9881<br>
                               (051) 36-3441</p>
                        </div>
                    </div>
                    
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <h5><i class="bi bi-envelope text-primary me-2"></i>Correo Electrónico</h5>
                            <p>finesi@unap.edu.pe<br>
                               informes@finesi.unap.edu.pe</p>
                        </div>
                        <div class="col-md-6">
                            <h5><i class="bi bi-clock text-primary me-2"></i>Horario de Atención</h5>
                            <p>Lunes a Viernes<br>
                               8:00 AM - 4:00 PM</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card mt-4">
                <div class="card-body">
                    <h4 class="card-title">Envíanos un Mensaje</h4>
                    <!-- FORMULARIO CORREGIDO -->
                    <form action="${pageContext.request.contextPath}/contacto" method="post">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Nombre</label>
                                <input type="text" name="nombre" class="form-control" 
                                       value="${not empty clearForm ? '' : param.nombre}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Correo Electrónico</label>
                                <input type="email" name="email" class="form-control" 
                                       value="${not empty clearForm ? '' : param.email}" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Asunto</label>
                            <input type="text" name="asunto" class="form-control" 
                                   value="${not empty clearForm ? '' : param.asunto}" required>
                        </div>
			<div class="mb-3">
			    <label class="form-label">Mensaje</label>
			    <textarea id="editor" name="mensaje" class="form-control" rows="5" style="display:none;" required>${not empty clearForm ? '' : param.mensaje}</textarea>
			    <div id="tinymce-editor" style="height: 200px; border: 1px solid #ced4da; border-radius: 0.25rem; padding: 0.375rem 0.75rem;">${not empty clearForm ? '' : param.mensaje}</div>
			    <input type="hidden" id="plain-text-content" name="plainTextContent">
			</div>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-send me-2"></i>Enviar Mensaje
                        </button>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Ubicación</h5>
                    <div class="ratio ratio-16x9">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d454.02789336503747!2d-70.01749459456677!3d-15.823610900325175!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x915d693cb33d1a89%3A0x333a534d425ba4bd!2sFacultad%20de%20Ingenier%C3%ADa%20Estadistica%20e%20Informatica%20(Pab.%20Nuevo)!5e1!3m2!1ses-419!2spe!4v1750626475141!5m2!1ses-419!2spe" 
                                width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </div>
            </div>
	    <div class="card mt-4">
			<div class="card-body text-center">
			    <h5 class="card-title">Nuestras Instalaciones</h5>
			    <img src="https://i.ibb.co/7JWWPp9Q/fotofacu.jpg" 
				 alt="Edificio FINESI" 
				 class="img-fluid rounded"
				 style="max-height: 250px;">
			    <p class="mt-2 text-muted">Facultad de Ingeniería Estadística e Informática</p>
			</div>
	    </div>

        </div>
    </div>
</div>

<script src="https://cdn.tiny.cloud/1/rdwqrf9jhmwh2y2ekweeqlvlx6b783pru641mzsmig83sl5j/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

<script>
	document.addEventListener('DOMContentLoaded', function() {
	    // Ocultar alertas vacías
	    const alerts = document.querySelectorAll('.alert');
	    alerts.forEach(function(alert) {
		const alertText = alert.textContent || alert.innerText;
		const cleanText = alertText.replace(/×/g, '').trim(); // Remover el botón X y espacios
		if (cleanText === '' || cleanText.length === 0) {
		    alert.style.display = 'none';
		}
	    });
	    
	    tinymce.init({
		selector: '#tinymce-editor',
		plugins: 'lists',
		toolbar: 'bold italic underline | bullist numlist',
		menubar: false,
		statusbar: false,
		height: 200,
		setup: function(editor) {
		    editor.on('change', function() {
			updatePlainTextContent();
		    });
		}
	    });
	    
	    function htmlToPlainText(html) {
		// Crear elemento temporal para extraer texto
		const temp = document.createElement('div');
		temp.innerHTML = html;
		
		// Convertir listas a texto
		temp.querySelectorAll('ul, ol').forEach(list => {
		    list.innerHTML = list.innerHTML.replace(/<li>/g, '\n? ').replace(/<\/li>/g, '');
		});
		
		// Reemplazar etiquetas de formato
		temp.innerHTML = temp.innerHTML
		    .replace(/<strong>/g, '*').replace(/<\/strong>/g, '*')
		    .replace(/<em>/g, '_').replace(/<\/em>/g, '_')
		    .replace(/<u>/g, '').replace(/<\/u>/g, '');
		
		// Obtener texto plano
		return temp.textContent || temp.innerText || '';
	    }
	    
	    function updatePlainTextContent() {
		const htmlContent = tinymce.get('tinymce-editor').getContent();
		const plainText = htmlToPlainText(htmlContent);
		
		// Actualizar ambos campos
		document.getElementById('editor').value = plainText;
		document.getElementById('plain-text-content').value = plainText;
	    }
	    
	    // Manejar el envío del formulario
	    document.querySelector('form').addEventListener('submit', function(e) {
		updatePlainTextContent();
		return true;
	    });
	});
</script>
<jsp:include page="/WEB-INF/views/includes/footer.jsp" />