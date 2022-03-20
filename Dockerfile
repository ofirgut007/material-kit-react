FROM node:latest AS frontend1
LABEL org.opencontainers.image.authors="ofirgut007@gmail.com"
ENV NODE_ENV=production
ENV PORT=8000
WORKDIR /app
COPY ["package.json", "package-lock.json*", "./"]
# install node modules and build assets
RUN npm install -g npm@8.5.5 && npm install --production
#ENV NODE_OPTIONS="--max-old-space-size=8192"
COPY . .
EXPOSE ${PORT}
CMD [ "npm", "run" , "build" ]
# Choose NGINX as our base Docker image
FROM nginx:alpine
# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html
RUN rm -rf *
# Copy static assets from frontend1 layer
COPY --from=frontend1 /app/dist .
COPY nginx.conf /etc/nginx/
#COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE ${PORT}
# Entry point when Docker container has started
ENTRYPOINT ["nginx", "-g", "daemon off;"]