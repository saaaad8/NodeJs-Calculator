pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'saaddocker419/node-calc:latest'  // Define the Docker image name
        DOCKER_HUB_CREDENTIALS = 'docker-jenkins'  // Docker Hub credentials in Jenkins
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/saaaad8/NodeJs-Calculator.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image with a tag
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login to Docker Hub and push the image
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${DOCKER_IMAGE}").push()
                    }
                }
            }
        }

        stage('Deploy on EC2') {
            steps {
                script {
                    echo "Deploying on EC2 using Docker Compose"
                    
                    // Ensure any previous containers are taken down
                    sh 'docker-compose down || true'  // Runs even if there are no existing containers

                    // Start services with Docker Compose
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up any unused Docker resources..."
            sh 'docker system prune -f || true'  // Clean up unused Docker resources
        }
        success {
            echo "Deployment successful!"
        }
        failure {
            echo "Deployment failed."
        }
    }
}
