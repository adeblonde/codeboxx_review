#!/bin/bash

export APP_NAME=$1
export ROOT_APP_NAME=$2
export student_name=$3

### backup of database.yml
mv students/$student_name/$ROOT_APP_NAME/config/database.yml students/$student_name/$ROOT_APP_NAME/config/database.bkp
### setting database.yaml
cp databases_config/database.yml students/$student_name/$ROOT_APP_NAME/config/database.yml

### adapt sed for Kernel (MacOS doesn't have GNU sed)
sed_cmd="sed -i"
OS=$(uname)
echo "OS is " $OS
if [[ $OS != "Linux" ]]
then
    echo "not a Linux kernel"
    sed -i ' ' "s#APP_NAME#$APP_NAME#g" students/$student_name/$ROOT_APP_NAME/config/database.yml
else
    sed -i "s#APP_NAME#$APP_NAME#g" students/$student_name/$ROOT_APP_NAME/config/database.yml
fi