pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/saaaad8/NodeJs-Calculator.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Tag the image with your Docker Hub username and repository name
                    docker.build('saddocker419/node-calc:latest')
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Use the Docker Hub credentials stored in Jenkins
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-jenkins') {
                        // Push the image to your Docker Hub repository
                        docker.image('saddocker419/node-calc:latest').push()
                    }
                }
            }
        }

        stage('Deploy on EC2') {
            steps {
                // Stop any running containers using the previous image
                sh 'docker stop $(docker ps -q --filter ancestor=saddocker419/node-calc:latest) || true'
                // Run the new container on port 3000
                sh 'docker run -d -p 3000:3000 saddocker419/node-calc:latest'
            }
        }
    }
}
