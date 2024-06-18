pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'nextjs-app:latest'
        CONTAINER_NAME = 'nextjs_container'
    }
    stages {
        stage('Verify Docker') {
    steps {
        script {
            // Example: Check if a file exists
            if (fileExists('filename.txt')) {
                echo 'File exists!'
            } else {
                error 'File does not exist!'
            }
        }
    }
}
        stage('Checkout') {
            steps {
                script {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/main']],
                        userRemoteConfigs: [[
                            url: 'https://github.com/Abhinav2212/jenkinsDemo.git',
                            credentialsId: "${env.GITHUB_CREDENTIALS_ID}"
                        ]]
                    ])
                }
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
                    def container = sh(script: "docker ps -q -f name=${env.CONTAINER_NAME}", returnStdout: true).trim()
                    if (container) {
                        sh "docker stop ${env.CONTAINER_NAME}"
                        sh "docker rm ${env.CONTAINER_NAME}"
                    }
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
