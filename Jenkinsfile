pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Supprimer devops') {
            steps {
                script {
                    // Supprimez le repo devops Github
                    sh 'rm -rf /home/kevin/git/devops'
                    //def result = sh(script: "sudo rm -rf /home/kevin/git/devops", returnStatus: true)
                    //if (result != 0) {
                    //error("Erreur lors de la suppression de devops")
                    //}
                }
            }
        }
        stage('Get Dockerfile') {
            steps {
                script {
                    // Récupérez le Dockerfile
                    sh 'cd /home/kevin/git && git clone git@github.com:tkvy4/devops.git'
                }
            }
        }
        stage('Create path') {
            steps {
                script {
                    def directoryExists = sh(script: '[ -d "/home/kevin/docker_container/linux_server_jenkins" ] && echo "true" || echo "false"', returnStdout: true).trim()

                    if (directoryExists == "true") {
                        echo "Le répertoire existe déjà. Continuer le build..."
                    } else {
                        echo "Le répertoire n'existe pas. Création..."
                        sh 'mkdir /home/kevin/docker_container/linux_server_jenkins && cd /home/kevin/docker_container/linux_server_jenkins'
                        echo "Répertoire crée."
                    }
                }
            }
        }
        stage('Supprimer devops') {
            steps {
                script {
                    def result = sh(script: "udo docker build -t mon-image-docker .", returnStatus: true)
                    if (result != 0) {
                        error("Erreur lors de la construction de l'image")
                    }
                }
            }
        }
        stage('Run Docker Image') {
            steps {
                script {
                    def result = sh(script: "sudo docker run -d -p 8080:80 linux_server_jenkins", returnStatus: true)
                    if (result != 0) {
                    error("Erreur lors du run de l'image")
                    }
                }
            }
        }
    }
}
