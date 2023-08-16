pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker à partir du Dockerfile
                    docker.build("linux-server-jenkins:${env.BUILD_NUMBER}", ".")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Exécuter le conteneur Docker à partir de l'image construite
                    docker.image("linux-server-jenkins:${env.BUILD_NUMBER}")
                        .run('-p 8080:80 -d --name mon-conteneur')
                }
            }
        }
    }
}
