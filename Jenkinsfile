pipeline {
    agent any


    environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub_id')
	}

	
	  tools
    {
       maven "m3"
    }
 stages {
	 stage('Execute Maven') {
           steps {
             
                sh 'mvn package'
          }
    }
        

  stage('Docker Build and Tag') {
           steps {
              
                sh 'docker build -t brandani/mywebapp_boxfuser:latest .' 
               
          }
    }

    stage('Login') {

        steps {
            sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        }
    }

    stage('Push') {

        steps {
            sh 'docker push brandani/mywebapp_boxfuser:latest'
        }
    }


 stage('Run Docker container on remote hosts') {
             
            steps {
                sh "docker -H ssh://root@172.31.3.13 run -d -p 8060:8080 brandani/mywebapp_boxfuser"
 
            }
        }

	}

	post {
		always {
			sh 'docker logout'
		}
	}

}