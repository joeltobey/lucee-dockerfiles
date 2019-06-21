#!/bin/bash

# We need to do this all on one line because escaped line breaks 
# aren't picked up correctly by CommandBox on this base image ( JIRA:COMMANDBOX-598 )
if [[ $DEBUG ]]; then
    if [[ $CFENGINE ]]; then
        box server start cfengine=${CFENGINE} serverHomeDirectory=${SERVER_HOME_DIRECTORY} host=0.0.0.0 openbrowser=false port=${PORT} saveSettings=false  --debug
    else
        box server start serverHomeDirectory=${SERVER_HOME_DIRECTORY} host=0.0.0.0 openbrowser=false port=${PORT} saveSettings=false  --debug
    fi
else
    if [[ $CFENGINE ]]; then
        box server start cfengine=${CFENGINE} serverHomeDirectory=${SERVER_HOME_DIRECTORY} host=0.0.0.0 openbrowser=false port=${PORT} saveSettings=false
    else
        box server start serverHomeDirectory=${SERVER_HOME_DIRECTORY} host=0.0.0.0 openbrowser=false port=${PORT} saveSettings=false
    fi
fi
