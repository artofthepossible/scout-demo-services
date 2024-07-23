#FROM alpine:3.14@sha256:eb3e4e175ba6d212ba1d6e04fc0782916c08e1c9d7b45892e9796141b1d379ae

#better image
#FROM node:slim
FROM FROM alpine:3.17

ENV BLUEBIRD_WARNINGS=0 \
  NODE_ENV=production \
  NODE_NO_WARNINGS=1 \
  NPM_CONFIG_LOGLEVEL=warn \
  SUPPRESS_NO_CONFIG_WARNING=true

RUN apk add --no-cache \
  nodejs

# Create app directory
WORKDIR /app

COPY package.json ./


RUN  apk add --no-cache npm \
 && npm i --no-optional \
 && npm cache clean --force \
 && apk del npm  


COPY . /app

# Run the application as a non-root user.
# Create a new user "appuser" and switch to it
RUN adduser -D appuser
USER appuser


# Expose port and define command
EXPOSE 8080

CMD ["node","/app/app.js"]



