FROM openjdk:8-jre

LABEL maintainer="Joel Tobey <joeltobey@gmail.com>"
LABEL repository="https://github.com/joeltobey/lucee-dockerfiles/commandbox"

ENV COMMANDBOX_VERSION 4.7.0
ENV CFENGINE lucee@5.3.2.77

# We want a headless server with the admin
ENV HEADLESS true

# Use URL rewrites
ENV URL_REWRITES true

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

COPY ./build/debian ${BUILD_DIR}/debian

# Basic Dependencies
RUN ${BUILD_DIR}/debian/install-dependencies.sh

# Copy file system
COPY ./test/ ${APP_DIR}/
COPY ./build/ ${BUILD_DIR}/
RUN ls -la ${BUILD_DIR}
RUN chmod +x $BUILD_DIR/*.sh

# Commandbox Installation
RUN $BUILD_DIR/util/install-commandbox.sh

# CFConfig Installation
RUN $BUILD_DIR/util/install-cfconfig.sh

# CommandBox-DotEnv Installation
RUN $BUILD_DIR/util/install-dotenv.sh

# Default Port Environment Variables
ENV PORT 8888

EXPOSE ${PORT}

CMD $BUILD_DIR/run.sh
