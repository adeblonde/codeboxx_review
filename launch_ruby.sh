#!/bin/bash

### prepare list of students and projects
export STUDENTS="Amuriana+Rocket_Elevators_Foundation BenLand24+Rocket_Elevator_Foundation jorgechavarriaga+Rocket-Elevator-Foundation maguilar93+Rocket-Elevator-Foundation sebxroy+Rocket-Elevators-Foundation virtualutopia+Rocket-Elevator-Foundation"

### for debug purposes
export ZENDESK_URL=https://test.com

### student's specific settings
for student in $STUDENTS
do
	student_name="$(cut -d'+' -f1 <<<${student})"
	ROOT_APP_NAME="$(cut -d'+' -f2 <<<${student})"
	APP_NAME=${ROOT_APP_NAME//-/_}

	echo "Setting student " $student_name " with project " $ROOT_APP_NAME " and app name " $APP_NAME

	### set your databases parameters - won't be critical for next parts, you can keep default values
	export POSTGRESQL_PASSWORD=postgres_password
	export POSTGRESQL_USER=$APP_NAME
	export POSTGRESQL_DB=postgres_password

	export MYSQL_ROOT_PASSWORD=password
	export MYSQL_DATABASE=${APP_NAME}_db
	export MYSQL_USER=$APP_NAME
	export MYSQL_PASSWORD=password

	for env in development test production
	do
		### setting databases
		echo "Setting database for student " $student_name " with project " $APP_NAME
		mysql_query="CREATE USER IF NOT EXISTS ${MYSQL_USER} IDENTIFIED BY '${MYSQL_PASSWORD}' ;"
		mysql -u root -h 127.0.0.1 -e "$mysql_query" --password=$MYSQL_ROOT_PASSWORD
		mysql_query="DROP DATABASE IF EXISTS ${APP_NAME}_${env};"
		mysql -u root -h 127.0.0.1 -e "$mysql_query" --password=$MYSQL_ROOT_PASSWORD
		mysql_query="CREATE DATABASE IF NOT EXISTS ${APP_NAME}_${env};"
		mysql -u root -h 127.0.0.1 -e "$mysql_query" --password=$MYSQL_ROOT_PASSWORD
		mysql_query="GRANT ALL PRIVILEGES ON ${APP_NAME}_${env}.* TO ${MYSQL_USER};"
		echo $mysql_query
		mysql -u root -h 127.0.0.1 -e "$mysql_query" --password=$MYSQL_ROOT_PASSWORD
	done

	### set environment variable for allowing Ruby to access MySQL
	export RUBY_DEMO_APP_DATABASE_PASSWORD=$MYSQL_PASSWORD

	cd students/$student_name/$ROOT_APP_NAME

		### setup of database in Ruby app
		rake db:create
		rake db:seed
		rake db:migrate

		### install webpacker
		# rails webpacker:install

		### start rails server
		rails server

	cd ../../..

done