FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY WebContent /usr/local/tomcat/webapps/ROOT
COPY build/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes
COPY WebContent/WEB-INF/lib /usr/local/tomcat/webapps/ROOT/WEB-INF/lib

EXPOSE 8080
CMD ["catalina.sh", "run"]