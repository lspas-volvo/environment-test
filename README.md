# Environments as code (proof of concept)

The purpose of this repository is to represent current state of apps (versions, configs, etc.) in all environments.

The main concept is to store the state in a single place (for all environments) and perform releases and promotions using ```git```. This methodology is often referred to as ```GitOps```.

In our PoC we used GoCD as a CD platform that continously monitors this repository and updates all environments to always reflect the state stored in this repository for all registered applications. This also includes adding apps to and removing apps from any environment.

# Setup with GoCD

Our proof of concept uses one central installation of GoCD that manages all environments.

GoCD uses this repository in "Config Repository" setting to continously monitor changes and sync pipelines definitions using ```**/*.gocd.yaml``` filter pattern. By doing so we can quickly make changes to the pipelines, add new ones (for testing) or revert changes when needed. We can also restore GoCD state in case of failures quickly using this repo.

Pipelines are also grouped by ```app name``` and ```environment``` so one can quickly find in GoCD's UI what versions of a given app is deployed in all environments and also find all apps that reached production environment stage.

# Environments definition

Environments are defined in ```environments.gocd.yaml```. One can define environment variables specific for a given environment that will be made available to all pipelines bound to a given environment (i.e. for making helm releases one could specify kube context ID).

These variables can be overriden inside pipeline definitions if needed.

Adding new environments requires adding an entry in ```environments.gocd.yaml``` file and creating pipeline definition files for all apps targeted for that environment.

# Pipelines definition

Also pipelines are configured to monitor (by polling) this repository for changes at paths specific for a given environment and app.

I.e. when changing, adding or removing a file under ```app1/``` folder only a single pipeline for a specific environment of the application ```app1``` will be triggered. Which environment pipeline will be triggered is determined by one of the following file name patterns:
- ```app1/<environment>.*```
- ```app1/<environment>-*```
- ```app1/<environment>_*```
- ```app1/<environment>/*```

# TODO

- Automate adding new apps by using a templates from ```_templates/``` subdirectory.
- Change pipelines so they do something useful (helm release) instead of echo.
- Declare other materials for apps (ECR repo, docker image tag, git repo with the apps source code).
- Add notifications mechanism so dev teams get notified when GoCD pipeline is completed (with success or failure).
