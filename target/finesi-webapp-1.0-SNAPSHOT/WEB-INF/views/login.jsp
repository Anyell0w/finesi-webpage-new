<!-- login.jsp -->
<jsp:include page="/WEB-INF/views/includes/header.jsp">
    <jsp:param name="title" value="Iniciar Sesión" />
</jsp:include>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title text-center mb-4">
                        <i class="bi bi-person-circle display-4 text-primary"></i><br>
                        Iniciar Sesión
                    </h4>
                    
                    <!-- Mostrar mensaje de error SOLO cuando existe -->
                    <c:if test="${not empty error and error.trim() != ''}">
                        <div class="alert alert-danger" role="alert">
                            <i class="bi bi-exclamation-triangle me-2"></i>${error}
                        </div>
                    </c:if>
                    
                    <!-- Mostrar mensaje de éxito si existe (por ejemplo, registro exitoso) -->
                    <c:if test="${not empty success and success.trim() != ''}">
                        <div class="alert alert-success" role="alert">
                            <i class="bi bi-check-circle me-2"></i>${success}
                        </div>
                    </c:if>
                    
                    <form method="post">
                        <div class="mb-3">
                            <label class="form-label">Usuario</label>
                            <input type="text" name="username" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contraseña</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="bi bi-box-arrow-in-right me-2"></i>Ingresar
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

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
});
</script>
