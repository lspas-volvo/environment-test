# Environment State (proof of concept)

The purpose of this repository is to represent current state of apps (versions, configs, etc.) in all environments.

# Setup with GoCD

GoCD uses this repository in "Config Repository" setting to continously monitor changes and sync pipelines definitions using "\*\*/\*.gocd.yaml" filter pattern. By doing so we can quickly make changes to the pipelines, add new ones (for testing) or revert changes when needed. We can also restore GoCD state in case of failures quickly using this repo.

# TODO

- Automate adding new apps by using a templates from "_templates" subdirectory.
- Change pipelines so they do something useful (helm release) instead of echo.
- Declare other materials for apps (ECR repo, docker image tag, git repo with the apps source code)
