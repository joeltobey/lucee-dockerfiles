FROM joeltobey/lucee:5.2

MAINTAINER Daemonites <hello@daemon.com.au>

ENV COMMANDBOX_DEBIAN_URL https://www.ortussolutions.com/parent/download/commandbox/type/deb

# Install CommandBox
RUN wget -nv $COMMANDBOX_DEBIAN_URL -O /root/commandbox-debian.deb && \
	dpkg -i /root/commandbox-debian.deb && \
	rm -rf /root/commandbox-debian.deb && \
	echo "$(box version) successfully installed"
