FROM ortussolutions/commandbox

LABEL maintainer "Joel Tobey <joeltobey@gmail.com>"
LABEL repository "https://github.com/joeltobey/lucee-dockerfiles/commandbox"

ENV COMMANDBOX_VERSION 4.1.0

ENV CFENGINE lucee@5.2.7.63

# We want a headless server with the admin
ENV HEADLESS true

# Use URL rewrites
ENV URL_REWRITES true

# WARM UP THE SERVER
RUN $BUILD_DIR/util/warmup-server.sh
