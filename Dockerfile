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

docker build -t dev222-app .
docker run -p 4000:3000 dev222-app
http://localhost:4000.

curl http://localhost:3000
curl http://localhost:4000

docker ps
docker logs <container_id_or_name>
aliyaberdalieva@Aliyas-MacBook-Pro Docker Project % curl http://localhost:3000

Hello, World!
    When you are evolving to your higher self, the road seems lonely.
    But you're simply shedding energies that no longer match the frequency of your destiny💞%                                                                                                        
aliyaberdalieva@Aliyas-MacBook-Pro Docker Project % curl http://localhost:4000

Hello, World!
    When you are evolving to your higher self, the road seems lonely.
    But you're simply shedding energies that no longer match the frequency of your destiny💞%   

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 471112852835.dkr.ecr.us-east-1.amazonaws.com    ( Authenticate Docker with ECR)
docker tag dev222-app:latest 471112852835.dkr.ecr.us-east-1.amazonaws.com/dev222-app:latest  (Tag Your Docker Image)
docker push 471112852835.dkr.ecr.us-east-1.amazonaws.com/dev222-app:latest  (Push the Docker Image to ECR)


