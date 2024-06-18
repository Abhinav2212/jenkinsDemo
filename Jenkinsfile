pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'nextjs-app:latest'
        CONTAINER_NAME = 'nextjs_container'
        GITHUB_CREDENTIALS_ID = 'github-token' 
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Abhinav2212/jenkinsDemo.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}")
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove the previous container if it exists
                    def container = sh(script: "docker ps -q -f name=${env.CONTAINER_NAME}", returnStdout: true).trim()
                    if (container) {
                        sh "docker stop ${env.CONTAINER_NAME}"
                        sh "docker rm ${env.CONTAINER_NAME}"
                    }

                    // Run the new container
                    sh "docker run -d -p 3000:3000 --name ${env.CONTAINER_NAME} ${env.DOCKER_IMAGE}"
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
