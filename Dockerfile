FROM mminderbinder/tomcat7:0.9.15
MAINTAINER Milo Minderbinder <minderbinder.enterprises@gmail.com>

CMD ["/sbin/my_init"]

RUN chown -R tomcat7:tomcat7 /usr/share/tomcat7
COPY openam/OpenAM-12.0.0.war /var/lib/tomcat7/webapps/openam.war


# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
