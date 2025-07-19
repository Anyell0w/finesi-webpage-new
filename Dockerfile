FROM tomcat:10.1-jdk21-temurin

# Copia el WAR generado al directorio webapps de Tomcat
COPY target/finesi-webapp-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Exponer el puerto donde Tomcat corre
EXPOSE 8080

