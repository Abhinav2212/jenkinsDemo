# Use the official Node.js image as the base image
FROM node:18-alpine

# Create and change to the app directory
WORKDIR /app

# Copy application dependency manifests to the container image
COPY package.json yarn.lock ./

# Install production dependencies
RUN yarn install --production

# Copy the local code to the container image
COPY . .

# Build the Next.js application
RUN yarn build

# Expose the port the app runs on
EXPOSE 3000

# Run the web service on container startup
CMD ["yarn", "start"]
