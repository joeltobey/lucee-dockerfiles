FROM joeltobey/lucee:5.1-nginx

# Create Lucee configs
COPY lucee-server.xml /opt/lucee/server/lucee-server/context/lucee-server.xml
COPY lucee-web.xml.cfm /opt/lucee/web/lucee-web.xml.cfm

# Copy default nginx config files
COPY default.conf /etc/nginx/conf.d/
