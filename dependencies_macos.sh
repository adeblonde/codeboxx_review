#!/bin/bash

### install docker
tools/docker_install.sh

### install nodejs
brew install node || brew upgrade node

### install yarn
brew install yarn || brew upgrade yarn

# ### install ruby & ruby-dev
brew install ruby || brew upgrade ruby

### install sqlite libs
brew install sqlite3 || brew upgrade sqlite3

# ### install mysql libs
brew install mysql-client || brew upgrade mysql-client
brew install mysql|| brew upgrade mysql

# ### install postgres libs
brew install postgresql || brew upgrade postgresql

echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
export PATH="/usr/local/opt/ruby/bin:$PATH"