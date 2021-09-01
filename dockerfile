FROM ubuntu:latest

WORKDIR /usr/src/app

COPY . ./

RUN apt-get update && apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN npm install

EXPOSE 3000
CMD ["npm", "start"]
