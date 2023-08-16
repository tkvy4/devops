pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Connectez-vous au serveur via SSH
                    sshagent(['367bb491-c059-43d1-a437-f8e4f22f7e28']) {
                        // Clonez le référentiel sur le serveur
                        sh 'ssh kevin@192.168.42.129 "git clone https://github.com/tkvy4/devops.git /home/kevin/git/"'
                        
                        // Exécutez la commande Docker pour construire l'image
                        sh 'ssh kevin@192.168.42.129 "cd /home/kevin/git/devops && docker build -t linux-server-jenkins ."'
                    }
                }
            }
        }
        // Ajoutez d'autres étapes si nécessaire
    }
}
