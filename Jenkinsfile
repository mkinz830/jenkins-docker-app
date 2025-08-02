pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = 'mkinz830/flask-app-docker'
        DOCKER_IMAGE_TAG  = '2'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/mkinz830/jenkins-docker-app.git', branch: 'master'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
                }
            }
        }
        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                sh "docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
            }
        }
    }
    post {
        always {
            echo 'Cleaning up Docker images'
            sh "docker rmi ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} || true"
        }
    }
}