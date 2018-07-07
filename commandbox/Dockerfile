FROM openjdk:8

LABEL maintainer "Joel Tobey <joeltobey@gmail.com>"
LABEL repository "https://github.com/joeltobey/lucee-dockerfiles/commandbox"

ENV COMMANDBOX_VERSION 4.1.0

# Since alpine runs as a single user, we need to create a "root" direcotry
ENV HOME /root

# Basic Dependencies
RUN apt-get update && apt-get install --assume-yes jq curl apt-utils && apt-get clean

### Directory Mappings ###
# APP_DIR = the directory where the application runs
ENV APP_DIR /app
WORKDIR $APP_DIR

# BIN_DIR = Where the box binary goes
ENV BIN_DIR /usr/local/bin
WORKDIR $BIN_DIR

# BUILD_DIR = WHERE runtime scripts go
ENV BUILD_DIR $HOME/build
WORKDIR $BUILD_DIR

# Copy file system
COPY ./test/ $APP_DIR/
COPY ./build/ $BUILD_DIR/
RUN ls -la $BUILD_DIR
RUN chmod +x $BUILD_DIR/*.sh

# Commandbox Installation
RUN $BUILD_DIR/util/install-commandbox.sh

# CFConfig Installation
RUN $BUILD_DIR/util/install-cfconfig.sh

# Cleanup and Optimize our Installation
RUN ${BUILD_DIR}/util/optimize.sh

# Default Port Environment Variables
ENV PORT 8080
ENV SSL_PORT 8443

# Hard Code our engine environment
ENV CFENGINE lucee@5.2.7.63

# We want a headless server with the admin
ENV HEADLESS true

# Use URL rewrites
ENV URL_REWRITES true

# WARM UP THE SERVER
RUN $BUILD_DIR/util/warmup-server.sh

EXPOSE ${PORT} ${SSL_PORT}

CMD $BUILD_DIR/run.sh
