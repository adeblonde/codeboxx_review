### Common commands to run for git 

#########
# Startup
#########

### Go on master branch
git checkout master

### Create a dev branch
git branch dev

### Go on dev branch
git checkout dev

### Creation of a new branch for a new dev and a new feature
git branch dev_NAME_FEATURE

### Go on your branch, start coding
git checkout dev_NAME_FEATURE

#########
# You are writing on your branch : run comands at each commit
#########

### commit
git commit

### push
git push -u origin dev_NAME_FEATURE

#########
# Feature finished : merge your branch on the dev branch
#########

### fetch
git fetch

### rebase to dev, in order to collect all developments pushed to dev since your branch creation or your last rebase
git rebase dev

### switch to dev branch
git checkout dev

### get last version of dev branch
git pull origin dev

### merge from task branch
git merge dev_NAME_FEATURE --no-ff

### push back the merged dev branch
git push origin dev

### remove branch locally
git branch -d dev_NAME_FEATURE

### push deletion of branch on the server
git push origin :dev_NAME_FEATURE

### ensure to remove all untracked objects from deleted branches
git prune

#########
# Project version finished : merge dev branch on master branch
# WARNING : be sure to have merged all dev_NAME_FEATURE branches on the dev branch,
# and to have deleted them. Otherwise you will have some problems when deleting the dev branch
#########

### fetch
git fetch

### move to dev branch
git checkout dev

### rebase to dev, in order to collect all developments pushed to dev since your branch creation or your last rebase
git rebase master

### switch to dev branch
git checkout master

### get last version of dev branch
git pull origin master

### merge from task branch
git merge dev --no-ff

### push back the merged dev branch
git push origin master

### remove branch locally
git branch -d dev

### push deletion of branch on the server
git push origin :dev

### ensure to remove all untracked objects from deleted branches
git prune