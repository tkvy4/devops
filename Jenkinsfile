pipeline {
    agent any

    stages {
        stage('Load Variables') {
            steps {
                script {                    
                    def githubApiUrl = 'https://api.github.com/repos/tkvy4/devops/contents/variables.groovy'
                    def githubToken = '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'

                    //def response = sh(script: "curl -H 'Authorization: Bearer ${githubToken}' ${githubApiUrl}", returnStdout: true).trim()
                    def response = sh(script: "curl -H 'Authorization: token ${githubToken}' ${githubApiUrl}", returnStdout: true).trim()
                    echo "Réponse de curl : ${response}"
                    
                    def content = readJSON text: response

                    def downloadUrl = content.download_url
                    def decodedContent = sh(script: "curl -s ${downloadUrl} | base64 -d", returnStdout: true).trim()

                    // Charger le contenu décodé du fichier variables.groovy
                    loadScript text: decodedContent

                    def variables = evaluate(new GroovyShell().parse(decodedContent))

                    // Définir les variables dans le contexte du pipeline
                    //env.DOCKER_IMAGE = variables.DOCKER_IMAGE
                    //env.AUTRE_VARIABLE = variables.AUTRE_VARIABLE
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
