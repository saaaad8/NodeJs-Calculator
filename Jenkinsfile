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

                    // Stop and remove any running container using the same port
                    echo "Stopping any containers using port ${hostPort}"
                    def existingPortContainer = sh(script: "docker ps -q --filter 'expose=${hostPort}'", returnStdout: true).trim()
                    if (existingPortContainer) {
                        echo "Stopping container using port ${hostPort}"
                        sh "docker stop ${existingPortContainer} || true"
                        sh "docker rm ${existingPortContainer} || true"
                    }

                    // Stop and remove any previous container with the same name
                    echo "Stopping any existing containers with name: ${containerName}"
                    def existingContainer = sh(script: "docker ps -q -f name=${containerName}", returnStdout: true).trim()
                    if (existingContainer) {
                        echo "Stopping and removing container: ${containerName}"
                        sh "docker stop ${existingContainer} || true"
                        sh "docker rm ${existingContainer} || true"
                    }

                    // Run the new container
                    echo "Starting new container: ${containerName} on port ${hostPort}"
                    sh "docker run -d --name ${containerName} -p ${hostPort}:${containerPort} saaddocker419/node-calc:latest"
                }
            }
        }
    }
}
