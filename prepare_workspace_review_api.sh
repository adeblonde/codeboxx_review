#!/bin/bash

### prepare list of students and projects
export STUDENTS="jorgechavarriaga+RestApiRocketElevators Amuriana+Todo-List-API maguilar93+Rocket_Elevators_Restful_API_Copie sebxroy+Rocket_Elevators_Rest_Api virtualutopia+Rocket-Elevator-Foundation-RESTapi"

cd students_api

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

## install c# tools
sudo apt install mono-complete
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo add-apt-repository universe
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt install dotnet-host dotnet-runtime-3.1 dotnet-sdk-3.1 -y

### compile c# code
cd students_api

for student in $STUDENTS
do
	student_name="$(cut -d'+' -f1 <<<${student})"
	ROOT_APP_NAME="$(cut -d'+' -f2 <<<${student})"
	echo "compiling " $ROOT_APP_NAME " from student " $student_name
	cd $student_name/$ROOT_APP_NAME
	# xbuild $(ls *.csproj)
	dotnet restore
	dotnet msbuild $(ls *.csproj)
	cd ../..

done

cd ..

### check if running
cd students_api

for student in $STUDENTS
do
	student_name="$(cut -d'+' -f1 <<<${student})"
	ROOT_APP_NAME="$(cut -d'+' -f2 <<<${student})"
	echo "compiling " $ROOT_APP_NAME " from student " $student_name
	cd $student_name/$ROOT_APP_NAME
	dotnet run
	cd ../..

done

cd ..