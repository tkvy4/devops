pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Get Dockerfile') {
            steps {
                script {
                    // Récupérez le Dockerfile
                    sh 'echo admin | cd /home/kevin/git && sudo -S rm -rf devops && git clone git@github.com:tkvy4/devops.git'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker à partir du Dockerfile
                    sh 'cd /home/kevin/docker_container and mkdir linux_server_jenkins && cd linux_server_jenkins && sudo docker build -t mon-image-docker .'
                }
            }
        }
        stage('Run Docker Image') {
            steps {
                script {
                    // Construire l'image Docker à partir du Dockerfile
                    sh 'sudo docker run -d -p 8080:80 linux_server_jenkins'
                }
            }
        }
    }
}
