# devops

Jenkinsfile is the script executed by Jenkins piepline
It will :
- load variables from variables.groovy
- use Dockerfile to build and run the Docker container

jira-playbook.yml is the main Ansible playbook for Jira installation
inventory.ini defines where to run the Ansible playbook

They both load variables from jira.yml
