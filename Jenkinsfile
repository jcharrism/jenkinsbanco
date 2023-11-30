pipeline {
    agent any

    stages {
        stage('Build BAR') {
            steps {
                bat """
                    cd C:\\Program Files\\IBM\\ACE\\12.0.5.0
                    dir
                """
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
