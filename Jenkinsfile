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
                    // Define variables
                    def containerName = 'node-calculator-app-container'
                    def containerPort = '3000'
                    def hostPort = '3000'

                    // Run the new container directly
                    echo "Starting new container: ${containerName} on port ${hostPort}"
                    sh "docker run -d --name ${containerName} -p ${hostPort}:${containerPort} saaddocker419/node-calc:latest"
                }
            }
        }
    }
}
