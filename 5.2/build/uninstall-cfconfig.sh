#!/bin/bash

# Install the CFConfig Module
box uninstall commandbox-cfconfig --production
rm -rf $HOME/.CommandBox/cfml/modules/commandbox-cfconfig
