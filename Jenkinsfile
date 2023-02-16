pipeline {
    agent { label 'ec2-slave' }

    environment {
        OLD_TAG="1.0"
        NEW_TAG="1.0"
        IMG_NAME="amrtarek6/connect4:1.0"
    }

    stages {
        stage('build') {
           steps {
                echo 'Building Docker image...'
                catchError {
                    sh "docker rmi -f ${IMG_NAME}:${OLD_TAG}"
                } 
                sh "cd src"                  
                sh "docker build -t ${IMG_NAME}:${NEW_TAG} ."
           }
       }
       
       stage('Push to Dockerhub'){
           steps {
               echo 'pushing to dockerhub repo...'
                withCredentials([usernamePassword(credentialsId: 'Docker-Hub', usernameVariable: 'USERNAME', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USERNAME --password-stdin'
                    sh "docker push ${IMG_NAME}:${NEW_TAG}"
                }
           }
       }

       stage('deploy') {
           steps {
               script {
                    echo 'deploying image on kubernetes cluster....'

                    sh "kubectl apply -f ./K8s"
                
                    
               }
            }

        }
       
    }
}