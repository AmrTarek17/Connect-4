pipeline {
    agent { label 'ec2-slave' }

    environment {
        OLD_TAG="1.0"
        NEW_TAG="1.1"
        IMG_NAME="amrtarek6/connect4"
    }

    stages {
        stage('build') {
           steps {
                echo 'Building Docker image...'
                catchError {
                    sh "docker rmi -f ${IMG_NAME}:${OLD_TAG}"
                }                  
                sh "docker build -f src/Dockerfile -t ${IMG_NAME}:${NEW_TAG} ./src"
           }
       }
       
       stage('Push to Dockerhub'){
           steps {
               echo 'pushing to dockerhub repo...'
                withCredentials([usernamePassword(credentialsId: 'Docker_Hub', usernameVariable: 'USERNAME', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USERNAME --password-stdin'
                    sh "docker push ${IMG_NAME}:${NEW_TAG}"
                }
           }
       }

       stage('deploy') {
           steps {
               script {
                    echo 'deploying image on kubernetes cluster....'
                    sh "sudo chmod +x ./K8s/deployment.sh && ./K8s/deployment.sh"
                    sh "kubectl apply -f ./K8s"
                
                    
               }
            }

        }
       
    }
}