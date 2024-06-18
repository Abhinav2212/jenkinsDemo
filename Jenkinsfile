pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'nextjs-app:latest'
        CONTAINER_NAME = 'nextjs_container'
    }
    
    stages {
        stage("Restore Yarn packages") {
            steps {
                // Writes lock-file to cache based on the GIT_COMMIT hash
                writeFile file: "next-lock.cache", text: "$GIT_COMMIT"
     
                cache(caches: [
                    arbitraryFileCache(
                        path: "node_modules",
                        includes: "**/*",
                        cacheValidityDecidingFile: "package.json"
                    )
                ]) {
                    sh "yarn install"
                }
            }
        }
        
        stage("Build") {
            steps {
                // Writes lock-file to cache based on the GIT_COMMIT hash
                writeFile file: "next-lock.cache", text: "$GIT_COMMIT"
     
                cache(caches: [
                    arbitraryFileCache(
                        path: ".next/cache",
                        includes: "**/*",
                        cacheValidityDecidingFile: "next-lock.cache"
                    )
                ]) {
                    // aka `next build`
                    sh "yarn build"
                }
            }
        }
        
        stage("Build Docker Image") {
            steps {
                script {
                    docker.build("${env.DOCKER_IMAGE}")
                }
            }
        }
        
        stage("Run Docker Container") {
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
