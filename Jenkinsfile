pipeline {
    agent any
	
	

    stages {
	
	
        stage('Build BAR') {
            steps {
				script{
					readProp = readProperties file: 'parametros.properties'
				}
			    echo "This is runing on ${readProp['library']}"
				echo "This is runing on ${readProp['input-path']}"
				echo "This is runing on ${readProp['output-bar-file']}"
				echo "This is runing on ${readProp['verificar-bar']}"
				
                bat """
                    dir
                    cd C:\\Program Files\\IBM\\ACE\\12.0.5.0 & ace.cmd &  ibmint package --input-path ${readProp["input-path"]} --output-bar-file ${readProp["output-bar-file"]}
                    dir
                """
            }
        }
        stage('Verificar BAR') {
            steps {
                 bat """
                    dir
                    cd ${readProp["verificar-bar"]}
                    dir                    
                """
            }
        }
        stage('Valores Archivo propiedades') {
            steps {
                script{
					readProp = readProperties file: 'parametros.properties'
				}
                echo 'Deploying....'
				echo "This is runing on ${readProp['library']}"
				echo "This is runing on ${readProp['input-path']}"
				echo "This is runing on ${readProp['output-bar-file']}"
				echo "This is runing on ${readProp['verificar-bar']}"
            }
        }
    }
}
