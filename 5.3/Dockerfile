FROM tomcat:9.0.50-jdk11-openjdk-buster

MAINTAINER Joel Tobey <joeltobey@gmail.com>

ARG LUCEE_VERSION=5.3.8.189
ARG COMMANDBOX_VERSION=5.3.1

ENV HOME /root
WORKDIR $HOME

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

# Replace the Trusted SSL Certificates packaged with Lucee with those from
# Java. Different OpenJDK versions have different paths for cacerts
RUN mkdir -p /opt/lucee/server/lucee-server/context/security && \
	if   [ -e "$JAVA_HOME/jre/lib/security/cacerts" ]; then ln -s "$JAVA_HOME/jre/lib/security/cacerts" -t /opt/lucee/server/lucee-server/context/security/; \
	elif [ -e "$JAVA_HOME/lib/security/cacerts" ]; then ln -s "$JAVA_HOME/lib/security/cacerts" -t /opt/lucee/server/lucee-server/context/security/; \
	else echo "Unable to find/symlink cacerts."; exit 1; fi

# Delete the default Tomcat webapps so they aren't deployed at startup
RUN rm -rf $CATALINA_HOME/webapps/*

# Custom setenv.sh to load Lucee
# Tomcat memory settings
# -Xms<size> set initial Java heap size
# -Xmx<size> set maximum Java heap size
ENV LUCEE_JAVA_OPTS "-Djava.awt.headless=true -server -Xms64m -Xmx512m"

# Download Lucee JAR
ENV LUCEE_JAR_URL http://release.lucee.org/rest/update/provider/loader/$LUCEE_VERSION
RUN mkdir -p $CATALINA_HOME/lucee
ADD $LUCEE_JAR_URL $CATALINA_HOME/lucee/lucee.jar

# Set Tomcat config to load Lucee
COPY tomcat/catalina.properties \
	tomcat/server.xml \
	tomcat/web.xml \
	$CATALINA_HOME/conf/
COPY tomcat/rewrite.config $CATALINA_HOME/conf/Catalina/localhost/

# Custom setenv.sh to load Lucee
COPY supporting/setenv.sh /usr/local/tomcat/bin/
RUN chmod a+x /usr/local/tomcat/bin/setenv.sh

# Create Lucee configs
COPY lucee/lucee-server.xml /opt/lucee/server/lucee-server/context/lucee-server.xml
COPY lucee/lucee-web.xml.cfm \
     lucee/log4j.properties \
     /opt/lucee/web/

# Provide test page
COPY www/ $APP_DIR/
COPY build/ $BUILD_DIR/
RUN ls -la $BUILD_DIR
RUN chmod +x $BUILD_DIR/*.sh
ONBUILD RUN rm -rf $APP_DIR/*

# Commandbox Installation
RUN apt-get update -y; \
    apt-get install -y unzip
#ENV COMMANDBOX_URL https://downloads.ortussolutions.com/ortussolutions/commandbox/${COMMANDBOX_VERSION}/commandbox-bin-${COMMANDBOX_VERSION}.zip
#ADD $COMMANDBOX_URL $BIN_DIR
#RUN chmod +x $BIN_DIR/box
RUN $BUILD_DIR/install-commandbox.sh

# CFConfig Installation
RUN $BUILD_DIR/install-cfconfig.sh

# lucee first time startup; explodes lucee and installs bundles/extensions (prewarms twice due to additional bundle downloads)
COPY supporting/prewarm.sh $CATALINA_HOME/bin/
RUN chmod +x $CATALINA_HOME/bin/prewarm.sh
RUN $CATALINA_HOME/bin/prewarm.sh && $CATALINA_HOME/bin/prewarm.sh

# Generate a random password to secure the admin
RUN $BUILD_DIR/password.sh
