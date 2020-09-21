### STAGE 1: Build ###
FROM node:14.8.0-alpine AS builder
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --prod

### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
COPY --from=builder /usr/src/app/dist/angular-docker /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
