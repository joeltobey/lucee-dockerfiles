FROM joeltobey/lucee:5.2-commandbox

# Create Lucee configs
COPY lucee-server.xml /opt/lucee/server/lucee-server/context/lucee-server.xml
COPY lucee-web.xml.cfm /opt/lucee/web/lucee-web.xml.cfm
COPY log4j.properties /opt/lucee/web/log4j.properties

RUN cd /var/www && \
    box coldbox create app myapp && \
    cd modules_app/ && \
    mkdir mymodule/
