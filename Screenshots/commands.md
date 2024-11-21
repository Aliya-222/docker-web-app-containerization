dockerfile
# Use the official Node.js 16 image as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json files into the container
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application code into the container
COPY . .

# Expose the port that the application runs on
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]


brew install node
npm -v
npm init -y
app.js
const http = require('http');

const server = http.createServer((req, res) => {
  res.end(`Hello, World!
    When you are evolving to your higher self, the road seems lonely.
    But you're simply shedding energies that no longer match the frequency of your destiny💞`);
});

server.listen(3000, () => {
  console.log('Server is running on port 3000');
});

package.json
{
  "name": "sample-app",
  "version": "1.0.0",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "author": "",
  "license": "ISC",
  "keywords": [],
  "description": ""
}

docker build -t dev222-app .
docker run -p 3000:3000 dev222-app

dockerfile
# Stage 1: Build Stage
FROM node:16 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install production dependencies
RUN npm install --only=production

# Copy the application source code
COPY . .

# Stage 2: Runtime Stage
FROM node:16-slim

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=builder /app /app

# Expose the port the app will run on
EXPOSE 3000

# Define a health check to verify the app is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl --fail http://localhost:3000 || exit 1

# Command to start the application
CMD ["npm", "start"]

docker run -p 4000:3000 dev222-app
http://localhost:4000
