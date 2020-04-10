#!/bin/bash

### prepare list of students and projects
export STUDENTS="Amuriana+Rocket_Elevators_Foundation BenLand24+Rocket_Elevator_Foundation jorgechavarriaga+Rocket-Elevator-Foundation maguilar93+Rocket-Elevator-Foundation sebxroy+Rocket-Elevators-Foundation virtualutopia+Rocket-Elevator-Foundation FelixDallaire+Rocket-Elevator-Foundation"

cd students

### clone students' projects
for student in $STUDENTS
do
	student_name="$(cut -d'+' -f1 <<<${student})"
	ROOT_APP_NAME="$(cut -d'+' -f2 <<<${student})"
	echo "git cloning repo " $ROOT_APP_NAME " from student " $student_name
	mkdir -p $student_name
	cd $student_name
	### for initial cloning
	### COMMENT if already cloned
	git clone https://github.com/${student_name}/${ROOT_APP_NAME}.git
	### update last commit
	cd $ROOT_APP_NAME
	git stash
	git pull origin master
	cd ..
	cd ..

done

cd ..

### install tools and dependencies (mostly docker)
### COMMENT if everything already installed
./install_tools.sh

### creation of database servers
### COMMENT if database dockers are already up
export APP_NAME=review
tools/set_docker_compose.sh $APP_NAME
cd development
### start docker DB
docker-compose up -d
### WARNING
### wait for dockers to be up and running
### please adapt to your own situation, if 5 seconds is not enough
sleep 5
cd ..

### student's specific settings
for student in $STUDENTS
do
	student_name="$(cut -d'+' -f1 <<<${student})"
	ROOT_APP_NAME="$(cut -d'+' -f2 <<<${student})"
	APP_NAME=${ROOT_APP_NAME//-/_}

	echo "Setting student " $student_name " with project " $ROOT_APP_NAME " and app name " $APP_NAME

	### setting database.yml
	tools/set_database_config.sh $APP_NAME $ROOT_APP_NAME $student_name

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

	### for debug purposes
	export ZENDESK_URL=https://test.co

	cd students/$student_name/$ROOT_APP_NAME

		### reset to the ruby version you are running if needed
		# sed -i "s/ruby '2.5.0'/ruby '2.5.1'/g" Gemfile
		# sed -i "s/ruby '2.6.5'/ruby '2.5.1'/g" Gemfile

		### update gems
		bundle update
		bundle install

		### setup of database in Ruby app
		rake db:create
		rake db:seed
		rake db:migrate

		### install webpacker - should be unecessary
		# rails webpacker:install

	cd ../../..

done

# #######
# # for stopping the databases
# #######
# # cd development
# # ### stop docker DB
# # docker-compose down
# # cd ..

# #######
# # for uninstalling rails if needed
# #######
# # gem uninstall rails
# # gem uninstall railties
# # gem uninstall -i /usr/share/rubygems-integration/all rails
# # gem uninstall -i /usr/share/rubygems-integration/all railties