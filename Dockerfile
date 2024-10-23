# First stage: Build stage
FROM node:18-alpine AS build

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to install dependencies first (this helps cache npm install)
COPY package*.json ./

# Install only production dependencies
RUN npm install --production

# Copy the rest of the application source code
COPY . .

##################################################

# Second stage: Runtime stage 
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy only necessary files from the build stage
COPY --from=build /usr/src/app .

# Expose the application port (adjust this based on your app's port)
EXPOSE 3000

# Start the application by directly running the main entry file
CMD ["node", "server.js"]
