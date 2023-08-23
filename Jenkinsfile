pipeline {
    agent any

    environment {
        // Update the Docker image name depending on what you need (e.g jira_jenkins, confluence_jenkins, etc)
        DOCKER_IMAGE_NAME = 'jira_jenkins'
    }

    stages {
        stage('Initial checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build and run the container') {
            steps {
                script {
                    // Execute Ansible playbook : deploy-playbook.yml
                    sh 'ansible-playbook /home/kevin/git/devops/deploy-playbook.yml'
                }
            }
        }
        stage('Install required packages and services') {
            steps {
                script {
                    // Create inventory.ini
                    sh 'ansible-playbook /home/kevin/git/devops/create-inventory-playbook.yml'
                    // Execute Ansible playbook : jira-playbook.yml
                    sh 'ansible-playbook -i /home/kevin/git/devops/inventory.ini /home/kevin/git/devops/jira-playbook.yml'
                    }
            }
        }
    }
}
