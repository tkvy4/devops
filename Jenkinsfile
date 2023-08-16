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
                        // Supprimez le référentiel sur le serveur
                        sh 'ssh kevin@192.168.42.129 "rm -rf /home/kevin/git/devops"'
                        
                        // Clonez le référentiel sur le serveur
                        sh 'ssh kevin@192.168.42.129 "git clone https://github.com/tkvy4/devops.git /home/kevin/git/"'

                        // Créez le dossier
                        sh 'ssh kevin@192.168.42.129 "mkdir /home/kevin/docker_container/linux_server_jenkins/"'                        
                        
                        // Exécutez la commande Docker pour construire l'image
                        sh 'ssh kevin@192.168.42.129 "cd /home/kevin/git/devops && docker build -t linux-server-jenkins /home/kevin/docker_container/linux_server_jenkins/"'
                    }
                }
            }
        }
        // Ajoutez d'autres étapes si nécessaire
    }
}
