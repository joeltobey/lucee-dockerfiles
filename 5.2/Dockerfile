FROM tomcat:9-jre8

MAINTAINER Joel Tobey <joeltobey@gmail.com>

ARG LUCEE_VERSION=5.2.9.31
ARG COMMANDBOX_VERSION=4.4.0

ENV HOME /root

### Directory Mappings ###
# BIN_DIR = Where the box binary goes
ENV BIN_DIR /usr/local/bin
WORKDIR $BIN_DIR

# BUILD_DIR = WHERE runtime scripts go
ENV BUILD_DIR $HOME/build
WORKDIR $BUILD_DIR

# APP_DIR = the directory where the application runs
ENV APP_DIR /var/www
WORKDIR $APP_DIR

ENV CATALINA_HOME /usr/local/tomcat

ENV LUCEE_JARS_URL http://release.lucee.org/rest/update/provider/loader/$LUCEE_VERSION
ENV LUCEE_JAVA_OPTS "-Djava.awt.headless=true -server -Xms256m -Xmx512m"

# Download core JAR, and delete it in one step to avoid committing the installer in a FS layer
RUN wget -nv $LUCEE_JARS_URL -O $HOME/lucee.jar && \
	mkdir -p $CATALINA_HOME/lucee && \
	cp /root/lucee.jar $CATALINA_HOME/lucee/lucee.jar && \
	rm -rf $HOME/lucee.jar

# Delete the default Tomcat webapps so they aren't deployed at startup
RUN rm -rf $CATALINA_HOME/webapps/*

# Set Tomcat config to load Lucee
COPY tomcat/catalina.properties tomcat/server.xml tomcat/web.xml $CATALINA_HOME/conf/
COPY tomcat/rewrite.config $CATALINA_HOME/conf/Catalina/localhost/

# Custom setenv.sh to load Lucee
COPY tomcat/setenv.sh $CATALINA_HOME/bin/
RUN chmod a+x $CATALINA_HOME/bin/setenv.sh

# Create Lucee configs
COPY lucee/lucee-server.xml /opt/lucee/server/lucee-server/context/lucee-server.xml
COPY lucee/lucee-web.xml.cfm /opt/lucee/web/lucee-web.xml.cfm

# Copy file system
COPY test/ $APP_DIR/
COPY build/ $BUILD_DIR/
RUN ls -la $BUILD_DIR
RUN chmod +x $BUILD_DIR/*.sh
ONBUILD RUN rm -rf $APP_DIR/*

# Commandbox Installation
RUN $BUILD_DIR/install-commandbox.sh

# CFConfig Installation
RUN $BUILD_DIR/install-cfconfig.sh

# lucee first time startup; explodes lucee and installs bundles/extensions (prewarms twice due to additional bundle downloads)
COPY tomcat/prewarm.sh $CATALINA_HOME/bin/
RUN chmod +x $CATALINA_HOME/bin/prewarm.sh
RUN $CATALINA_HOME/bin/prewarm.sh && $CATALINA_HOME/bin/prewarm.sh

# Replace the Trusted SSL Certificates packaged with Lucee with those from Debian
#   ca-certificates package from the OS is the most recent authority
RUN cp -f /etc/ssl/certs/java/cacerts /opt/lucee/server/lucee-server/context/security/cacerts

# Generate a random password to secure the admin
RUN $BUILD_DIR/password.sh

# Remove command modules
RUN $BUILD_DIR/uninstall-cfconfig.sh
