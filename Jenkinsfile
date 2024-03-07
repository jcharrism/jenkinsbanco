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
                    mkdir bar
		    docker build -t ace --build-arg DOWNLOAD_URL=https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/integration/12.0.4.0-ACE-LINUX64-DEVELOPER.tar.gz --file ./Dockerfile .
                    docker run -d --name acebar -p 7600:7600 -p 7800:7800 -e LICENSE=accept ace:latest
		    docker container ls
                    docker exec -u 0 acebar  whoami
		    docker exec acebar bash -c "cd /home/aceuser/build ; ls "
      		    docker exec -t acebar bash  -c "cd home/aceuser ; . /opt/ibm/ace-12/server/bin/mqsiprofile ; ibmint package --input-path /home/aceuser/build --output-bar-file /home/aceuser/bar/CuentasCOMAPI.bar --trace ibmint-trace.txt "
		    docker exec acebar bash -c "cd /home/aceuser/bar ; ls "
      		    docker cp acebar:/home/aceuser/bar/CuentasCOMAPI.bar ./bar
     		    docker stop acebar
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
