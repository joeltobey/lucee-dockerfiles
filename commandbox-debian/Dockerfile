FROM debian:stretch

LABEL maintainer "Joel Tobey <joeltobey@gmail.com>"
LABEL repository "https://github.com/joeltobey/lucee-dockerfiles"

# app versions
ENV COMMANDBOX_VERSION 4.3.0
ENV CFENGINE lucee@5.2.8.50

# customize build
ENV BOX_INSTALL false
ENV HEADLESS true
ENV URL_REWRITES true
ENV REMOVE_SERVER_JSON false

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Since alpine runs as a single user, we need to create a "root" direcotry
ENV HOME /root

### Directory Mappings ###
# BIN_DIR = Where the box binary goes
ENV BIN_DIR /usr/local/bin
WORKDIR $BIN_DIR

# BUILD_DIR = WHERE runtime scripts go
ENV BUILD_DIR $HOME/build
WORKDIR $BUILD_DIR

# APP_DIR = the directory where the application runs
ENV APP_DIR /app
WORKDIR $APP_DIR

COPY ./builds/debian ${BUILD_DIR}/debian  

# Basic Dependencies
RUN ${BUILD_DIR}/debian/install-dependencies.sh
# Install JRE
# do some fancy footwork to create a JAVA_HOME that's cross-architecture-safe
RUN ln -svT "/usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)" /docker-java-home
ENV JAVA_HOME /docker-java-home/jre
ENV JAVA_VERSION 8u181
ENV JAVA_DEBIAN_VERSION 8u181-b13-1~deb9u1
# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20170531+nmu1

RUN ${BUILD_DIR}/debian/install-jre.sh

# Copy file system
COPY ./test/ ${APP_DIR}/
COPY ./build/ ${BUILD_DIR}/
RUN ls -la ${BUILD_DIR}
RUN chmod +x $BUILD_DIR/*.sh

# Commandbox Installation
RUN $BUILD_DIR/util/install-commandbox.sh

# CFConfig Installation
RUN $BUILD_DIR/util/install-cfconfig.sh

# Install Extras
RUN $BUILD_DIR/util/install-extras.sh

# Default Port Environment Variables
ENV PORT 8080
ENV SSL_PORT 8443

# Healthcheck environment variables
ENV HEALTHCHECK_URI "http://127.0.0.1:${PORT}/"

# Our healthcheck interval doesn't allow dynamic intervals - Default is 20s intervals with 15 retries
HEALTHCHECK --interval=20s --timeout=30s --retries=15 CMD curl --fail ${HEALTHCHECK_URI} || exit 1

EXPOSE ${PORT} ${SSL_PORT}

# Warm up our server
RUN ${BUILD_DIR}/util/warmup-server.sh

CMD $BUILD_DIR/start.sh