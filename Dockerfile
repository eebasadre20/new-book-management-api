FROM node:18.17.0-alpine
WORKDIR /app
COPY . .
RUN yarn install


EXPOSE 3000FROM node:18.17.0-alpine
WORKDIR /app
COPY . .
RUN yarn install


EXPOSE 3000