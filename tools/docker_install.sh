#!/bin/bash

### Docker installation script

OS=$(uname)
echo "OS is " $OS

if [[ $OS == "Linux" ]]
then
	echo "Running Ubuntu version of docker installation"
	### Ubuntu / WSL

	### update package repository
	sudo apt update

	### remove older versions of docker if needed
	sudo apt remove docker docker-engine docker.io -y

	### install containerd
	sudo apt install containerd -y

	### install docker
	sudo apt install docker.io -y

	### start docker
	sudo systemctl unmask docker
	sudo systemctl start docker

	### enable to be run at startup
	sudo systemctl enable docker
else
	echo "Running MacOS version of docker installation"
	### MacOS
	brew install bash-completion
	brew cask install docker
fi

### check docker version
export DOCKER_VERSION=$(docker --version)
echo "installed Docker version is"$DOCKER_VERSION

