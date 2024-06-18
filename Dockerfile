# Use the official Node.js image as the base image
FROM node:20.3.1

# Install required tools
# Add Yarn GPG key and repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
    RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
    
    # Install Yarn v1.22.19
    RUN apt-get update && apt-get install -y yarn=1.22.19-1
    
    # Verify Yarn installation
    RUN yarn --version

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and yarn.lock
COPY package.json yarn.lock ./

# Install dependencies using Yarn
RUN yarn install

# Copy the rest of the application code
COPY . .

# Build the Next.js project
RUN yarn build

# Install PM2 globally
RUN yarn global add pm2

# Expose port 3000
EXPOSE 3000

# Start the Next.js application using PM2 and ecosystem file
CMD ["pm2-runtime", "start", "ecosystem.config.js", "--env", "production"]