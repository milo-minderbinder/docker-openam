FROM mminderbinder/tomcat7
MAINTAINER Milo Minderbinder <minderbinder.enterprises@gmail.com>


# Overwrite Tomcat start script with modified script
# which will prompt for container & app settings
COPY tomcat7-run.sh /etc/service/tomcat7/run
RUN chmod +x /etc/service/tomcat7/run

# Copy customized Tomcat configurations
COPY server.xml /var/lib/tomcat7/conf/server.xml
COPY tomcat-setenv.sh /usr/share/tomcat7/bin/setenv.sh
RUN chmod +x /usr/share/tomcat7/bin/*.sh

# Copy openam war archive, and modify CATALINA_HOME permissions to allow it to save its config 
RUN chown -R tomcat7:tomcat7 /usr/share/tomcat7
COPY openam/OpenAM-12.0.0.war /var/lib/tomcat7/webapps/openam.war

VOLUME /etc/openam

EXPOSE 8080
EXPOSE 8443

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/sbin/my_init"]
