#!/bin/bash

set -e
cd $APP_DIR

box server start cfengine=${CFENGINE} serverHomeDirectory=${SERVER_HOME_DIRECTORY} host=0.0.0.0 openbrowser=false port=${PORT} sslPort=${SSL_PORT} saveSettings=false
