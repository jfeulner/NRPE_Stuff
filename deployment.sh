#!/bin/bash
# Edited for Bronycon usage by John Feulner

SERVER_IP="173.255.233.120"
TEMP_DIR=/tmp/nagios
NRPE_CONF_DIR=/etc/nagios
YUM_CMD=/usr/bin/apt-get
WGET_CMD=/usr/bin/wget
SERVICE_CMD=/usr/bin/service

PS3='Please enter your choice | 1 to update | 2 to deploy | 3 to quit |: '
options=("Update NRPE Config" "Deploy NRPE" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Update NRPE Config")
            echo "Updating the NRPE Config File to the latest Version"
			cd $NRPE_CONF_DIR
			rm config.cfg
			$WGET_CMD https://raw2.github.com/jfeulner/NRPE_Stuff/master/config.cfg
			rm nrpe.cfg
			$WGET_CMD 
			$SERVICE_CMD nagios-nrpe-server reload
			echo "Update has been completed. Service has restarted"
            ;;
        "Deploy NRPE")
            echo "Deploying NRPE to BronyCon"
			mkdir -p $TEMP_DIR
			cd $TEMP_DIR

			## INSTALLING REQUIRED FILES FOR NAGIOS
			$YUM_CMD install nagios-nrpe-server nagios-plugins-basic nagios-plugins nagios-plugins-extra -y

			##Pulling Config File for deployment
			cd $NRPE_CONF_DIR
			rm config.cfg
			$WGET_CMD https://raw2.github.com/jfeulner/NRPE_Stuff/master/config.cfg
			rm nrpe.cfg
			
			$SERVICE_CMD nagios-nrpe-server restart
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done





