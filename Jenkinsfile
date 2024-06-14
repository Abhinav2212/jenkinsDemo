pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Abhinav2212/jenkinsDemo.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'yarn install'
            }
        }
        stage('Build') {
            steps {
                sh 'yarn build'
            }
        }
        stage('Test') {
            steps {
                sh 'yarn test'
            }
        }
        stage('Deploy') {
            steps {
                sh 'yarn deploy'
            }
        }
    }
}
