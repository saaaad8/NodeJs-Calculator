# 1. Use an official Node.js runtime as the base image
FROM node:18-alpine

# 2. Set the working directory inside the container
WORKDIR /usr/src/app

# 3. Copy the package.json and package-lock.json to install dependencies
COPY package*.json ./

# 4. Install dependencies
RUN npm install --production

# 5. Copy the rest of the application source code to the working directory
COPY . .

# 6. Expose the port your app will run on (typically 3000 for Node.js apps)
EXPOSE 3000

# 7. Define the command to start the app
CMD [ "npm", "start" ]
