pipeline {
    agent any

    stages {
        stage('Build BAR') {
            steps {
                bat """
                    dir
                    ibmint package --input-path C:\\ConsultaProductos --output-bar-file C:\\ConsultaProductos\\bar\\ConsultaProductos.bar
                    dir
                """
            }
        }
        stage('VErificar BAR') {
            steps {
                 bat """
                    dir
                    cd C:\\ConsultaProductos\\bar 
                    dir                    
                """
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
