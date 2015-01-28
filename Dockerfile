FROM mminderbinder/tomcat7:0.9.15
MAINTAINER Milo Minderbinder <minderbinder.enterprises@gmail.com>

CMD ["/sbin/my_init"]

# Copy openam war archive, and modify CATALINA_HOME permissions to allow it to save its config 
RUN chown -R tomcat7:tomcat7 /usr/share/tomcat7
COPY openam/OpenAM-12.0.0.war /var/lib/tomcat7/webapps/openam.war

COPY tomcat-setenv.sh /usr/share/tomcat7/bin/setenv.sh
RUN chmod +x /usr/share/tomcat7/bin/*.sh

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
