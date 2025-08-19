# Base Node image
FROM node:14 as build

WORKDIR /app

# Install dependencies
COPY package.json .
RUN npm install

# Copy app files
COPY . .

# Build step (optional if React/Vue frontend, else skip)
# RUN npm run build

# --------------------
# Final Stage: Nginx
# --------------------
FROM nginx:alpine

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy built app / static files
COPY public/ /usr/share/nginx/html/

# Copy Node backend (optional if API needed)
COPY server.js /usr/share/nginx/html/server.js

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

