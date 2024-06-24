pipeline {
    agent any
    stages {
        stage('Yarn install') {
            steps {
                // Execute your install script
                sh "npm install -g yarn"
                sh 'yarn install'
            }
        }
        stage('Build') {
            steps {
                    sh 'yarn build'
                    //./mvnw package -Dquarkus.package.type=uber-jar
            }
        }
        stage('Run') {
            steps {
                    sh 'pm2 restart ecosystem.config.js --  env_production'
            }
        }
    }
}