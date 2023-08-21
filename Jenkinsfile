pipeline {
    agent any

    stages {
        stage('Initial checkout') {
            steps {
                checkout scm
            }
        }
        stage('Clear existing devops cloned repo') {
            steps {
                script {
                    def result = sh(script: 'rm -rf /home/kevin/git/devops', returnStatus: true)

                    if (result == 0) {
                        echo "Directory deleted successfully."
                    } else {
                        echo "Directory deletion failed."
                        }
                    }
                }
            }
        stage('Clone devops repo') {
            steps {
                script {
                    // Clone repository
                    sh 'cd /home/kevin/git && git clone git@github.com:tkvy4/devops.git'
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
                    
                    // Build and run the container
                    sh "docker build -t ${loadedVariables.DOCKER_IMAGE} ."
                    sh "docker run -d -p 8081:80 ${loadedVariables.DOCKER_IMAGE}"
                    }
                }
            }
        stage('Exécution d\'Ansible') {
            steps {
                // Exécuter le script Ansible ici
                sh 'ansible-playbook -i /home/kevin/git/devops/inventory.yml /home/kevin/git/devops/jira-playbook.yml'
            }
        }
        }
}
