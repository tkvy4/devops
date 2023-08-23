# devops

Jenkinsfile is the script executed by Jenkins pipeline
It will :
- build and run the container with the help of deploy-playbook.yml
- install the packages and services in the container with the help of jira-playbook.yml

Dockerfile is used to configure and run the container (OS version, packages to install at the creation, ports to expose, etc)
jira-playbook.yml is the main Ansible playbook for Jira installation

Variables are loaded from jira.yml, this should be the only file to update
