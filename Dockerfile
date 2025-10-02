FROM node:20-alpine
WORKDIR /app

# Install deps
COPY package*.json ./
RUN npm ci --omit=dev || npm install --omit=dev

# Copy source and build
COPY . .
RUN npm run build

# Static server
RUN npm install -g serve

# Cloud Run port
ENV PORT=8080
EXPOSE 8080

# Serve build output (supports CRA -> build/ or Vite -> dist/)
CMD ["sh", "-c", "if [ -d build ]; then serve -s build -l 8080; elif [ -d dist ]; then serve -s dist -l 8080; else echo 'No build/dist folder. Did npm run build succeed?'; exit 1; fi"]
