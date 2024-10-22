# First stage: Build stage
FROM node:18-alpine AS build

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install production dependencies
RUN npm install --production

# Copy the entire source code to the build stage
COPY . .

##################################################

# Second stage: Distroless runtime stage
FROM gcr.io/distroless/nodejs:18

# Set working directory
WORKDIR /usr/src/app

# Copy only necessary files from build stage
COPY --from=build /usr/src/app .

# Expose the application port
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]
