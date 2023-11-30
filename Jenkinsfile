pipeline {
    agent any

    stages {
        stage('Build BAR') {
            steps {
                bat """
                    dir
                    cd C:\\Program Files\\IBM\\ACE\\12.0.5.0 & ace.cmd &  ibmint package --input-path C:\\ConsultaProductos --output-bar-file C:\\ConsultaProductos\\bar\\ConsultaProductos.bar
                    dir
                """
            }
        }
        stage('Verificar BAR') {
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
