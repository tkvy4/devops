pipeline {
    agent any

    stages {
        stage('Load Variables') {
            steps {
                script {
                    // Charger les variables depuis autre_variables.groovy dans le même répertoire
                    def loadedVariables = load 'devops/variables.groovy'

                    // Utiliser les variables chargées
                    echo "Une autre variable : ${loadedVariables.DOCKER_IMAGE}"
                    echo "Encore une autre variable : ${loadedVariables.ENCORE_AUTRE_VARIABLE}"
                }
            }
        }
        
    }
}
