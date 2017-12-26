FROM joeltobey/lucee:5.2

MAINTAINER Daemonites <hello@daemon.com.au>

ENV COMMANDBOX_BIN_URL https://www.ortussolutions.com/parent/download/commandbox/type/bin
ENV BIN_DIR /usr/bin

# Install CommandBox
RUN wget -nv $COMMANDBOX_BIN_URL -O /root/box.zip && \
	unzip /root/box.zip -d ${BIN_DIR} && chmod +x ${BIN_DIR}/box && \
	rm -rf /root/box.zip && \
	echo "$(box version) successfully installed"
