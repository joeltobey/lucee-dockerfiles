#!/bin/bash

# Installs the latest CommandBox Binary
mkdir -p /tmp
curl -k  -o /tmp/box.zip -location "https://downloads.ortussolutions.com/ortussolutions/commandbox/${COMMANDBOX_VERSION}/commandbox-bin-${COMMANDBOX_VERSION}.zip"
unzip /tmp/box.zip -d ${BIN_DIR} && chmod +x ${BIN_DIR}/box
echo "$(box version) successfully installed"

# Cleanup CommandBox modules which would not be necessary in a Container environment
SYSTEM_EXCLUDES=( "contentbox" "cachebox" "forgebox" "logbox" "games" "wirebox" )

for mod in "${SYSTEM_EXCLUDES[@]}"
do
	rm -rf $HOME/.CommandBox/cfml/system/modules_app/${mod}-commands
done

$BUILD_DIR/optimize.sh
