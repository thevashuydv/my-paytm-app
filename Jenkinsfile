pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub'   // Jenkins credential ID
        DOCKER_IMAGE = "vashuyadav/paytm-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/thevashuydv/my-paytm-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE:latest .'
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "$DOCKERHUB_CREDENTIALS", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh """
                      echo "$PASS" | docker login -u "$USER" --password-stdin
                      docker push $DOCKER_IMAGE:latest
                    """
                }
            }
        }

        stage('Deploy Locally') {
            steps {
                script {
                    sh """
                      docker rm -f paytm-app || true
                      docker run -d --name paytm-app -p 80:80 $DOCKER_IMAGE:latest
                    """
                }
            }
        }
    }
}

