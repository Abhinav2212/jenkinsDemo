pipeline {
    agent any

    stages {
         stage('Check Tools') {
            steps {
                // Check if yarn is installed
                sh 'which yarn || { echo "yarn is not installed"; exit 1; }'
                sh 'yarn --version'
                sh 'nvm ls'
                sh 'node -v'
            }
        }
        stage('Yarn install') {
            steps {
                 // Debugging script
                sh 'printenv'
                sh 'pwd'
                sh 'ls -la'
                // Install yarn globally if not already installed
                // sh 'npm install -g yarn || { echo "Failed to install yarn"; exit 1; }'

                // Verify yarn installation
                sh 'yarn --version || { echo "Yarn installation failed"; exit 1; }'

                // Execute yarn install
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