
# Web Application Containerization Project with Docker

This project involves containerizing a sample Node.js application using Docker, setting up a multi-stage build to optimize image size, and adding a health check for reliability. The project has been tested successfully with Amazon Elastic Container Registry (ECR).

---

## Project Structure

```
.
├── app.js            # Node.js application source code
├── package.json      # Node.js package configuration
├── Dockerfile        # Dockerfile for containerizing the application
├── README1.md         # Documentation
```

---

## Application Overview

The Node.js application is a basic HTTP server responding with a motivational message. It runs on port 3000 and displays the message:

```
Hello, World!
When you are evolving to your higher self, the road seems lonely.
But you're simply shedding energies that no longer match the frequency of your destiny💞
```

---

## Dockerfile Overview

### Multi-Stage Build

The Dockerfile uses a two-stage build process:
1. **Builder Stage**: Installs application dependencies.
2. **Runtime Stage**: Uses a minimal base image to reduce final image size.

### Dockerfile Content

```dockerfile
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
```

---

## Running Locally

### Step 1: Install Dependencies

If Node.js is not installed, install it using Homebrew:
```bash
brew install node
```

Verify the installation:
```bash
node -v
npm -v
```

### Step 2: Build and Run the Container

1. Build the Docker image:
   ```bash
   docker build -t dev222-app .
   ```

2. Run the container and map ports:
   ```bash
   docker run -p 4000:3000 dev222-app
   ```

3. Access the application in your browser at [http://localhost:4000](http://localhost:4000).

### Step 3: Check Logs

To view logs:
```bash
docker logs <container-id>
```

### Step 4: Verify Health Check

Check the container's health status:
```bash
docker inspect --format='{{json .State.Health}}' <container-id>
```

---

## Pushing to Amazon ECR

### Step 1: Authenticate Docker to ECR
```bash
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
```

### Step 2: Tag and Push the Image
1. Tag the image:
   ```bash
   docker tag dev222-app:latest <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/dev222-app:latest
   ```

2. Push the image to ECR:
   ```bash
   docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/dev222-app:latest
   ```

The image can now be viewed in the AWS ECR Console.

---

## Troubleshooting

### Common Issues and Commands
1. **Build Failures**: 
   - Ensure `package.json` and `app.js` are correctly structured.
   - Commands:
     ```bash
     ls -l
     ```

2. **Port Conflicts**: 
   - Stop conflicting containers.
   - Commands:
     ```bash
     docker ps
     docker stop <container-id>
     ```

3. **Health Check Failures**:
   - Debug with:
     ```bash
     curl http://localhost:3000
     docker logs <container-id>
     ```

---

## Results

### Application Test Results

The app was successfully tested on ports `3000` and `4000`. The message displayed was:

```
Hello, World!
When you are evolving to your higher self, the road seems lonely.
But you're simply shedding energies that no longer match the frequency of your destiny💞
```

### Amazon ECR Results

The Docker image was pushed to ECR and verified in the repository. Screenshots are attached for reference.

---

## Attached Files

1. `app.js` [Source Code](sandbox:/mnt/data/app.js)
2. `package.json` [Configuration](sandbox:/mnt/data/package.json)
3. **Screenshots**:
   - Localhost Results (`3000` and `4000`).
   - ECR Image Details.

---

## License

This project is open-source under the MIT License.
