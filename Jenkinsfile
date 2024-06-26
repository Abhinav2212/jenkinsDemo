pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def appName = "nextjs-app"
                    def imageTag = "${appName}:latest"

                    sh '''
                        # Build Docker image
                        docker build -t ${imageTag} .
                    '''
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    def appName = "nextjs-app"
                    def imageTag = "${appName}:latest"
                    def containerName = "nextjs-container"

                    sh '''
                        # Stop and remove any existing container
                        docker stop ${containerName} || true
                        docker rm ${containerName} || true

                        # Run Docker container
                        docker run -d --name ${containerName} -p 3000:3000 ${imageTag}
                    '''
                }
            }
        }
    }
}
