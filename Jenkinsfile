pipeline {
    agent any

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
                    def loadedVariables = load 'variables.groovy'

                    // Define container path directory
                    def path = "/home/kevin/docker_container/${loadedVariables.DOCKER_IMAGE}"

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
                    sh "docker stop ${loadedVariables.DOCKER_IMAGE} || true"

                    // Delete Docker container if existing
                    sh "docker rm -f ${loadedVariables.DOCKER_IMAGE} || true"
                    
                    // Build and run the container
                    sh "docker build -t ${loadedVariables.DOCKER_IMAGE} ."
                    sh "docker run -d --name ${loadedVariables.DOCKER_IMAGE} -p 8081:80 ${loadedVariables.DOCKER_IMAGE}"

                    }
                }
            }
        stage('Exécution d\'Ansible') {
            steps {
                script {
                    // Load variables from variables.groovy in Github repo
                    def loadedVariables = load 'variables.groovy'
 
                    // Edit inventory.ini
                    sh 'echo "" > /home/kevin/git/devops/inventory.ini'
                    sh "echo '[conteneurs]' >> /home/kevin/git/devops/inventory.ini"
                    sh "echo ${loadedVariables.DOCKER_IMAGE} ansible_connection=docker >> /home/kevin/git/devops/inventory.ini"
                
                    // Exécuter le script Ansible ici
                    sh 'ansible-playbook -i /home/kevin/git/devops/inventory.ini /home/kevin/git/devops/jira-playbook.yml'
                    }
              }
        }
}
