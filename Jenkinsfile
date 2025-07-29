pipeline {
    agent any

    environment {
        IMAGE_NAME = 'mkinz830/flask-app-docker'
    }

    stages {
        stage('Clone Repo') {
            steps {
                echo 'Cloning code...'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing image to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $IMAGE_NAME'
                }
            }
        }

        stage('Cleanup') {
            steps {
                echo 'Cleaning up...'
                sh 'docker rmi $IMAGE_NAME'
            }
        }
    }
}
