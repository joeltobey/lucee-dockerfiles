FROM joeltobey/lucee:5.2-nginx

# Create Lucee configs
COPY lucee-server.xml /opt/lucee/server/lucee-server/context/lucee-server.xml
COPY lucee-web.xml.cfm /opt/lucee/web/lucee-web.xml.cfm
COPY log4j.properties /opt/lucee/web/log4j.properties

# Copy default nginx config files
COPY default.conf /etc/nginx/conf.d/
