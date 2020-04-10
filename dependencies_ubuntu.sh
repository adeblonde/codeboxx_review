#!/bin/bash

### install docker
tools/docker_install.sh

### install nodejs
sudo apt install curl -y
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt install -y nodejs

### install yarn
sudo apt install yarn -y

### install ruby & ruby-dev
sudo apt install ruby -y
sudo apt install ruby`ruby -e 'puts RUBY_VERSION[/\d+\.\d+/]'`-dev -y

### install sqlite libs
sudo apt install sqlite3 -y
sudo apt install libsqlite3-dev -y

### install mysql libs
sudo apt install libmysqlclient-dev -y

### install postgres libs
sudo apt install libpq-dev -y