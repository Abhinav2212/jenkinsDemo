pipeline {
    agent any
    
    stages {
    stage('Print User and Check Permissions') {
            steps {
                script {
                    sh 'whoami'
                    sh 'ls -ld /home/Desktop/New Folder'
                }
            }
        }
        stage('Check Docker') {
            steps {
                sh '''
                    # Check if Docker is installed
                    if command -v docker &> /dev/null
                    then
                        echo "Docker is installed at $(command -v docker)"
                    else
                        echo "Docker is not installed. Please install Docker and try again."
                        exit 1
                    fi

                    # Check if Docker daemon is running
                    if docker info > /dev/null 2>&1
                    then
                        echo "Docker daemon is running."
                    else
                        echo "Starting Docker daemon..."
                        sudo -S systemctl start docker
                        # Give it some time to start
                        sleep 5
                        if docker info > /dev/null 2>&1
                        then
                            echo "Docker daemon started successfully."
                        else
                            echo "Docker daemon is not running. Please start Docker and try again."
                            exit 1
                        fi
                    fi
                '''
            }
        }

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
