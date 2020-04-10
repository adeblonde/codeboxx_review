#!/bin/bash

### prepare list of students and projects
export STUDENTS="jorgechavarriaga+RestApiRocketElevators Amuriana+Todo-List-API maguilar93+Rocket_Elevators_Restful_API_Copie sebxroy+Rocket_Elevators_Rest_Api"

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