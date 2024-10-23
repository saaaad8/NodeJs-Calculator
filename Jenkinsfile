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
                    docker.build('saaddocker419/node-calc:latest')
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Use the Docker Hub credentials stored in Jenkins
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-jenkins') {
                        // Push the image to your Docker Hub repository
                        docker.image('saaddocker419/node-calc:latest').push()
                    }
                }
            }
        }

        stage('Run Docker Container Locally') {
            steps {
                script {
                    bat 'docker run -d -p 3000:3000 --name node-calculator-app-container saaddocker419/node-calc:latest'
                }
            }
        }
    }
}
