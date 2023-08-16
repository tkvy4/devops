pipeline {
    agent any

    stages {
        stage('Load Variables') {
            steps {
                script {
                    // Charger les variables depuis autre_variables.groovy dans le même répertoire
                    def loadedVariables = load 'variables.groovy'

                    // Utiliser les variables chargées
                    echo "Docker image : ${loadedVariables.DOCKER_IMAGE}"
                    //echo "Encore une autre variable : ${loadedVariables.AUTRE_VARIABLE}"
                    echo "Path : /home/kevin/docker_container/${loadedVariables.DOCKER_IMAGE}"
                }
            }
        }
        stage ('Define variables') {
            steps {
                script {
                    def DOCKER_IMAGE = ${loadedVariables.DOCKER_IMAGE}"
                    //def autreVariable = ${loadedVariables.AUTRE_VARIABLE}"
                }
            }
        }
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Supprimer devops') {
            steps {
                script {
                    // Supprimez le repo devops Github
                    //sh 'rm -rf /home/kevin/git/devops'

                    def result = sh(script: 'rm -rf /home/kevin/git/devops', returnStatus: true)

                    if (result == 0) {
                        echo "Le répertoire a été supprimé avec succès."
                    } else {
                        echo "La suppression du répertoire a échoué."
                    }
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
                    def directoryExists = sh(script: '[ -d "/home/kevin/docker_container/${DOCKER_IMAGE}" ] && echo "true" || echo "false"', returnStdout: true).trim()

                    if (directoryExists == "true") {
                        echo "Le répertoire existe déjà. Continuer le build..."
                    } else {
                        echo "Le répertoire n'existe pas. Création..."
                        sh 'mkdir /home/kevin/docker_container/${DOCKER_IMAGE} && cd /home/kevin/docker_container/${DOCKER_IMAGE}'
                        echo "Répertoire crée."
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }
        stage('Run Docker Image') {
            steps {
                script {
                    sh 'docker run -d -p 8080:80 ${DOCKER_IMAGE}'
                }
            }
        }   
    }
}
