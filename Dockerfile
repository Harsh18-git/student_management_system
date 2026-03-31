FROM tomcat:10.1-jdk21

RUN rm -rf /usr/local/tomcat/webapps/*

COPY src/main/webapp /usr/local/tomcat/webapps/ROOT
COPY build/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes
COPY src/main/webapp/WEB-INF/lib /usr/local/tomcat/webapps/ROOT/WEB-INF/lib

EXPOSE 8080
CMD ["catalina.sh", "run"]