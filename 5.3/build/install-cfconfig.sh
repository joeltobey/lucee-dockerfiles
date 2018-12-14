#!/bin/bash

# Install the CFConfig Module
box install commandbox-cfconfig --production
$BUILD_DIR/optimize.sh
