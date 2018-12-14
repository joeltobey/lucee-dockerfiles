#!/bin/sh

#Generate a random password
openssl rand -base64 64 | tr -d '\n\/\+=' > ${HOME}/.enginePwd
box cfconfig set adminPassword=`cat ${HOME}/.enginePwd` to=/opt/lucee/server/lucee-server toFormat=luceeServer@5.3
box cfconfig set adminPassword=`cat ${HOME}/.enginePwd` to=/opt/lucee/web toFormat=luceeWeb@5.3
