FROM node:20-alpine
WORKDIR /app

# Copy dependency files and install everything (including devDependencies)
COPY package*.json ./
RUN npm install

# Copy source code and build
COPY . .
RUN npm run build

# Install static file server
RUN npm install -g serve

# Set port
ENV PORT=8080
EXPOSE 8080

# Serve the Vite build output (dist folder)
CMD ["serve", "-s", "dist", "-l", "8080"]
