pipeline {
    agent any

    stages {
        stage('Load Variables') {
            steps {
                script {
                    // Charger les variables depuis autre_variables.groovy dans le même répertoire
                    def loadedVariables = load 'variables.groovy'

                    // Utiliser les variables chargées
                    echo "Une autre variable : ${loadedVariables.DOCKER_IMAGE}"
                    echo "Encore une autre variable : ${loadedVariables.AUTRE_VARIABLE}"
                }
            }
        }
        
    }
}
