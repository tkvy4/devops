pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'jira_jenkins'
    }

    stages {
        stage('Initial checkout') {
            steps {
                checkout scm
            }
        }
            stage('Get files from Github') {
            steps {
                script {
                    // Delete existing data and clone again
                    def result = sh(script: 'rm -rf /home/kevin/git/devops', returnStatus: true)

                    if (result == 0) {
                        echo "Deleting devops...Success."
                        sh 'cd /home/kevin/git && git clone git@github.com:tkvy4/devops.git'
                        echo "Cloning into 'devops'...Success."
                    } else {
                        echo "Deleting...Fail."
                        }
                    }
                }
            }
        stage('Build and run the container') {
            steps {
                script {
                    // Load variables from variables.groovy in Github repo
                    //def loadedVariables = load 'variables.groovy'

                    // Define container path directory
                    def path = "/home/kevin/docker_container/${env.DOCKER_IMAGE_NAME}"

                    // Check if the directory exists
                    def directoryExists = sh(script: "[ -d ${path} ] && echo 'true' || echo 'false'", returnStdout: true).trim()

                    if (directoryExists == "true") {
                        echo "Directory already exists, continue build..."
                        sh "cd ${path}"
                    } else {
                        echo "Directory doesn't exist, creating..."
                        sh "mkdir ${path} && cd ${path}"
                        echo "Directory created."
                    }

                    // Copy Dockerfile from repo
                    sh "cp /home/kevin/git/devops/Dockerfile ${path}/"
                    
                    // Stop Docker container if running
                    sh "docker stop ${env.DOCKER_IMAGE_NAME} || true"

                    // Delete Docker container if existing
                    sh "docker rm -f ${env.DOCKER_IMAGE_NAME} || true"
                    
                    // Build and run the container
                    sh "docker build -t ${env.DOCKER_IMAGE_NAME} ."
                    sh "docker run -d --name ${env.DOCKER_IMAGE_NAME} -p 8081:80 ${env.DOCKER_IMAGE_NAME}"

                    }
                }
            }
        stage('Exécution d\'Ansible') {
            steps {
                script {
                    // Load variables from variables.groovy in Github repo
                    //def loadedVariables = load 'variables.groovy'
 
                    // Edit inventory.ini
                    sh 'echo "" > /home/kevin/git/devops/inventory.ini'
                    sh "echo '[conteneurs]' >> /home/kevin/git/devops/inventory.ini"
                    sh "echo ${env.DOCKER_IMAGE_NAME} ansible_connection=docker >> /home/kevin/git/devops/inventory.ini"
                
                    // Exécuter le script Ansible ici
                    sh 'ansible-playbook -i /home/kevin/git/devops/inventory.ini /home/kevin/git/devops/jira-playbook.yml'
                    }
            }
        }
    }
}
