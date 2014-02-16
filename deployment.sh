#!/bin/bash

# Edited for Bronycon usage by John Feulner

SERVER_IP="173.255.233.120"

TEMP_DIR=/tmp/nagios
NRPE_CONF_DIR=/etc/nrpe.d/

YUM_CMD=/usr/bin/apt-get
WGET_CMD=/usr/bin/wget
SERVICE_CMD=/sbin/service

mkdir -p $TEMP_DIR
cd $TEMP_DIR

## INSTALLING REQUIRED FILES FOR NAGIOS
$YUM_CMD install nagios-nrpe-server nagios-plugins-basic nagios-plugins nagios-plugins-extra -y

##Pulling Config File for deployment
cd $NRPE_CONF_DIR
$WGET_CMD https://raw.github.com/jfeulner/Mason-nrpe/master/config.cfg mason.cfg

$SERVICE_CMD nrpe restart
