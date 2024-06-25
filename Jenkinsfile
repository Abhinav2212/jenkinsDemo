pipeline {
    agent any

    stages {
        stage('Install Node.js via NVM') {
            steps {
                sh '''
                    # Install NVM if it is not already installed
                    if ! command -v nvm &> /dev/null
                    then
                        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
                    fi
                    
                    # Source NVM
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
                    
                    # Install and use the desired Node.js version
                    nvm install 20.3.1
                    nvm use 20.3.1
                    nvm alias default 20.3.1
                    
                    # Verify Node.js and NPM versions
                    node -v
                    npm -v
                '''
            }
        }
        
        stage('Check Tools') {
            
            steps {
                // Check if yarn is installed
                sh 'which yarn || { echo "yarn is not installed"; exit 1; }'
                sh 'yarn --version'
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
                sh '''
                    # Source NVM again in this stage
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
                    nvm use 20.3.1
                    
                    # Clear Yarn cache and install dependencies
                    yarn cache clean
                    yarn install
                '''
            }
        }

       
        stage('Build') {
            steps {
                sh '''
                    # Source NVM again in this stage
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
                    nvm use 20.3.1
                    
                    # Run the build command
                    yarn build
                '''
            }
        }
        stage('Install PM2 and Restart App') {
            steps {
                sh '''
                    # Ensure NVM and Node.js are sourced
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
                    nvm use 20.3.1
                    
                    # Install PM2 globally using Yarn
                    yarn global add pm2
                     # Add Yarn global binaries to PATH
                    export PATH="$(yarn global bin):$PATH"
                    
                    
                    # Verify PM2 installation
                    pm2 -v
                    
                    # Restart the application using PM2
                    pm2 restart ecosystem.config.js --env production
                '''
            }
        }
    }
}