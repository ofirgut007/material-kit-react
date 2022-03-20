FROM node:latest AS frontend1
LABEL org.opencontainers.image.authors="ofirgut007@gmail.com"
RUN apt-get -y update && apt-get install -y python
ENV NODE_ENV=production
ENV PORT=8000
WORKDIR /app
COPY ["package.json", "package-lock.json*", "./"]
# install node modules and build assets
RUN npm install --production
# Copy all files from current directory to working dir in image
# Except the one defined in '.dockerignore'
COPY . .
EXPOSE ${PORT}
CMD [ "npm", "run" , "build" ]
# Choose NGINX as our base Docker image
FROM nginx:alpine

# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf *

# Copy static assets from frontend1 layer
COPY --from=frontend1 /app/dist .
COPY nginx.conf /etc/nginx/
#COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE ${PORT}

# Entry point when Docker container has started
ENTRYPOINT ["nginx", "-g", "daemon off;"]