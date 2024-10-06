# Node.js Calculator App

This project is a simple Node.js calculator application that performs basic arithmetic operations. The application is containerized using Docker, and it is deployed on an AWS EC2 instance using a CI/CD pipeline set up with Jenkins. The pipeline automates code updates, builds a Docker image, pushes the image to Docker Hub, and deploys the latest version to the EC2 instance.

## Features

- Basic arithmetic operations (addition, subtraction, multiplication, and division)
- Dockerized application for easy deployment
- Jenkins CI/CD pipeline for automated deployment
- Hosted on AWS EC2

## Tech Stack

- **Node.js**: JavaScript runtime used to build the calculator app
- **Express.js**: Framework for building the web server
- **Docker**: Containerization platform for building and running the app in isolated environments
- **Jenkins**: Continuous Integration and Continuous Deployment (CI/CD) automation server
- **AWS EC2**: Virtual server used to host the application
- **GitHub**: Source code management and version control

## Project Setup

To run this project locally or deploy it to an AWS EC2 instance, follow the steps below:

### Prerequisites

- [Node.js](https://nodejs.org/) installed on your local machine
- [Docker](https://www.docker.com/) installed
- [Git](https://git-scm.com/) installed
- An AWS account with an EC2 instance
- Jenkins installed on your EC2 instance (can also act as the application server)

### 1. Clone the Repository

```bash
git clone https://github.com/saaaad8/NodeJs-Calculator.git
cd NodeJs-Calculator
```

### 2. Install Dependencies

Install the necessary dependencies for the Node.js application:

```bash
npm install
```

### 3. Run the Application Locally

To run the app on your local machine:

```bash
npm start
```

Visit `http://localhost:3000` to interact with the calculator app.

### 4. Dockerize the Application

Create a Docker image for the application:

```bash
docker build -t node-calculator-app .
```

Run the Docker container:

```bash
docker run -d -p 3000:3000 node-calculator-app
```

### 5. CI/CD Pipeline Setup

The project is set up with a Jenkins pipeline for automated deployment. The following stages are defined in the pipeline:

- **Clone Repository**: Clones the Node.js calculator code from GitHub.
- **Build Docker Image**: Builds the Docker image for the application.
- **Push Docker Image**: Pushes the built image to Docker Hub.
- **Deploy on EC2**: Stops the existing Docker container (if running) and starts a new one using the latest image.

#### Jenkinsfile

Here's the `Jenkinsfile` used in the project:

```groovy
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
                    docker.build('saaddocker419/node-calc:latest')
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-jenkins') {
                        docker.image('saaddocker419/node-calc:latest').push()
                    }
                }
            }
        }

        stage('Deploy on EC2') {
            steps {
                script {
                    def containerName = 'node-calculator-app-container'
                    def containerPort = '3000'
                    def hostPort = '3000'

                    echo "Stopping any containers using port ${hostPort}"
                    def existingPortContainer = sh(script: "docker ps -q --filter 'expose=${hostPort}'", returnStdout: true).trim()
                    if (existingPortContainer) {
                        sh "docker stop ${existingPortContainer}"
                        sh "docker rm ${existingPortContainer}"
                    }

                    echo "Stopping and removing container: ${containerName}"
                    def existingContainer = sh(script: "docker ps -q -f name=${containerName}", returnStdout: true).trim()
                    if (existingContainer) {
                        sh "docker stop ${existingContainer}"
                        sh "docker rm ${existingContainer}"
                    }

                    sh "docker run -d --name ${containerName} -p ${hostPort}:${containerPort} saaddocker419/node-calc:latest"
                }
            }
        }
    }
}
```

### 6. Accessing the Application

After deployment, the application can be accessed at the EC2 instance's public IP on port `3000`.

```bash
http://<EC2-PUBLIC-IP>:3000
```

## Docker Hub

The Docker image for this project is available on Docker Hub:

[saaddocker419/node-calc](https://hub.docker.com/r/saaddocker419/node-calc)

## Future Improvements

- Add more arithmetic operations and scientific functions
- Implement unit tests for the calculator
- Use Nginx as a reverse proxy for better scalability

## License

This project is licensed under the MIT License.

---
