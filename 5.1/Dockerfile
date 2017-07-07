FROM tomcat:8.5

MAINTAINER Daemonites <hello@daemon.com.au>

ENV LUCEE_JARS_URL http://cdn.lucee.org/rest/update/provider/loader/5.1.4.19
ENV LUCEE_JAVA_OPTS "-Xms256m -Xmx512m"
ENV TUCKEY_URL_REWRITE_FILTER_URL http://central.maven.org/maven2/org/tuckey/urlrewritefilter/4.0.4/urlrewritefilter-4.0.4.jar

# Download JARs, and delete it in one step to avoid committing the installer in a FS layer
RUN wget -nv $LUCEE_JARS_URL -O /root/lucee.jar && \
	mkdir -p /usr/local/tomcat/lucee && \
	cp /root/lucee.jar /usr/local/tomcat/lucee/lucee.jar && \
	rm -rf /root/lucee.jar && \
	wget -nv $TUCKEY_URL_REWRITE_FILTER_URL -O /root/urlrewritefilter.jar && \
	cp /root/urlrewritefilter.jar /usr/local/tomcat/lib/urlrewritefilter.jar && \
	rm -rf /root/urlrewritefilter.jar

# Delete the default Tomcat webapps so they aren't deployed at startup
RUN rm -rf /usr/local/tomcat/webapps/*

# Set Tomcat config to load Lucee
COPY tomcat/catalina.properties tomcat/server.xml tomcat/web.xml /usr/local/tomcat/conf/

# Custom setenv.sh to load Lucee
COPY tomcat/setenv.sh /usr/local/tomcat/bin/
RUN chmod a+x /usr/local/tomcat/bin/setenv.sh

# Create Lucee configs
COPY lucee/lucee-server.xml /opt/lucee/server/lucee-server/context/lucee-server.xml
COPY lucee/lucee-web.xml.cfm /opt/lucee/web/lucee-web.xml.cfm

# Provide test page
RUN mkdir -p /var/www/WEB-INF
COPY index.cfm /var/www/
COPY WEB-INF/urlrewrite.xml /var/www/WEB-INF/
COPY WEB-INF/.htaccess /var/www/WEB-INF/
ONBUILD RUN rm -rf /var/www/index.cfm

# lucee first time startup; explodes lucee and installs bundles/extensions
RUN /usr/local/tomcat/bin/catalina.sh start && \
    while [ ! -f "/opt/lucee/web/logs/application.log" ] ; do sleep 2; done && \
    /usr/local/tomcat/bin/catalina.sh stop

# Replace the Trusted SSL Certificates packaged with Lucee with those from Debian
#   ca-certificates package from the OS is the most recent authority
RUN cp -f /etc/ssl/certs/java/cacerts /opt/lucee/server/lucee-server/context/security/cacerts
