#!/bin/bash

export APP_NAME=$1

### let us replace the variables to set in docker-compose files
for env in development production
do
	cp $env/docker-compose.tpl.yml $env/docker-compose.yml
	OS=$(uname)
	echo "OS is " $OS
	if [[ $OS != "Linux" ]]
	then
		sed -i ' ' "s/APP_NAME/$APP_NAME/g" $env/docker-compose.yml
		sed -i ' ' "s/mysql_db/${APP_NAME}_${env}/g" $env/docker-compose.yml
	else
		sed -i "s/APP_NAME/$APP_NAME/g" $env/docker-compose.yml
		sed -i "s/mysql_db/${APP_NAME}_${env}/g" $env/docker-compose.yml
	fi

done