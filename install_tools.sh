#!/bin/bash

### install dependencies
OS=$(uname)
echo "OS is " $OS
if [[ $OS != "Linux" ]]
then
    echo "not a Linux kernel"
    ./dependencies_macos.sh
    export PATH="/usr/local/opt/ruby/bin:$PATH"
else
	echo "Ubuntu"
	./dependencies_ubuntu.sh
fi

export RUBY_VERSION=$(ruby -e 'puts RUBY_VERSION[/\d+\.\d+/]').0

### set Ruby in the PATH
export PATH=~/.gem/ruby/$RUBY_VERSION/bin:$PATH

### install rails
gem install --user-install rails

### check tools availability
echo "ruby version is "$RUBY_VERSION

export DOCKER_VERSION=$(docker --version)
echo "installed Docker version is"$DOCKER_VERSION

export NODE_VERSION=$(node -v)
echo "nodejs version is "$NODE_VERSION

export SQLITE_VERSION=$(sqlite3 --version)
echo "sqlite version is "$SQLITE_VERSION

export RAILS_VERSION=$(rails --version 2> /dev/null)
echo "rails version is "$RAILS_VERSION

### install good version of bundler
gem install --user-install bundler:1.17.3

## install sqlite v3 gem
gem install --user-install sqlite3

### install mysql gem
gem install --user-install mysql2 -v 0.5.3

### install pg gem
gem install --user-install pg -v '1.2.3'