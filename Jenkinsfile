pipeline {
    agent any
    stages {
        stage('Yarn install') {
            steps {
                script {
                    // Execute your install script
                    sh 'yarn install'
                    
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Execute your build script
                    sh 'yarn build'
                    //./mvnw package -Dquarkus.package.type=uber-jar

                }
            }
        }
        stage('Run') {
            steps {
                // Run docker-compose up
                script {
                    sh 'pm2 restart ecosystem.config.js --  env_production'
                }
            }
        }
    }
}