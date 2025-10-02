FROM node:20-alpine
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci --omit=dev || npm install --omit=dev

# Copy source and build
COPY . .
RUN npm run build

# Install static server
RUN npm install -g serve

# Run server
ENV PORT=8080
EXPOSE 8080
CMD ["serve", "-s", "build", "-l", "8080"]
