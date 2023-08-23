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
        stage('Create the container') {
            steps {
                script {
                    // Build and run Docker container : container-playbook.yml
                    sh 'ansible-playbook container-playbook.yml'
                    // Create inventory.ini
                    sh 'ansible-playbook /home/kevin/git/devops/create-inventory-playbook.yml'
                    // Install packages in Docker container : packages-playbook.yml
                    sh 'ansible-playbook -i /home/kevin/git/devops/inventory.ini /home/kevin/git/devops/packages-playbook.yml'
                }
            }
        }
        stage('Install Jira') {
            steps {
                script {
                    // Create inventory.ini
                    sh 'ansible-playbook /home/kevin/git/devops/create-inventory-playbook.yml'
                    // Execute Ansible playbook : packages-playbook.yml
                    sh 'ansible-playbook -i /home/kevin/git/devops/inventory.ini /home/kevin/git/devops/jira-install.yml'
                    }
            }
        }
    }
}
