# Environment State (proof of concept)

The purpose of this repository is to represent current state of apps (versions, configs, etc.) in all environments.

# Setup with GoCD

GoCD uses this repository in "Config Repository" setting to continously monitor changes and sync pipelines definitions using "\*\*/\*.gocd.yaml" filter pattern. By doing so we can quickly make changes to the pipelines, add new ones (for testing) or revert changes when needed. We can also restore GoCD state in case of failures quickly using this repo.

Pipelines are also grouped by **app name** and **environment** so one can quickly find in GoCD's UI what versions of a given app is deployed in all environments and also find all apps that reached production environment stage.

# Pipelines definition

Pipelines are configured to also monitor this repository with proper filters so they get automatically triggered (by GoCD polling mechanism) when something changes.

I.e. when changing, adding or removing a file under ```app1/``` folder only single pipeline for a specific environment of application ```app1``` will be triggered. Which environment pipeline will be triggered is defined by one of the following file name patterns:
- 'app1/\<environment\>.*'
- 'app1/\<environment\>-*'
- 'app1/\<environment\>_*'
- 'app1/\<environment\>/*'

# TODO

- Automate adding new apps by using a templates from "_templates" subdirectory.
- Change pipelines so they do something useful (helm release) instead of echo.
- Declare other materials for apps (ECR repo, docker image tag, git repo with the apps source code)
