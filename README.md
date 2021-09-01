# Virtualization and Cloud Computing - Docker Application Deployment
# (Samanyu A Saji - M20CS013)

# Instructor: Dr. Sumit Kalra (Assistant Professor, Department of Computer Science & Engineering, Indian Institute of Technology, Jodhpur)

## Assessment 1: Question 2

### <u>**Description**</u> 
The overall work done for this assessment can be divided into the following parts -


<u>**Creation of a sample web application**</u>

A React.js based game was implemented for using as the sample web application. The game implemented was tic-tac-toe, a simple 2 player game, where a user wins when he is able to place 3 X(or O) marks in a horizontal, vertical or diagonal fashion in a 3 x 3 grid. Special mention to Bassir Jafarzadeh (https://github.com/basir), and to his [tic-tac-toe](https://github.com/basir/tic-tac-toe) repo, which was the base of this simple implementation.

<u>**Testing the application locally**</u>

After the implementation, it was to be made sure that the applicaton was in a working condition. So the application was tested locally first. It was verified that the application was working fine locally. 
![Running Locally](/public/local.png)


<u>**How to run the project locally**</u>
``` sh
# PREREQUISITES
# nodejs and npm
# To install them, run the following commands : (as per official documentation)
$ sudo apt-get update && sudo apt-get install -y curl
$ curl -fsSL https://deb.nodesource.com/
$ sudo apt-get install -y nodejs && sudo apt-get install -y npm
``` 
``` sh
# RUNNING THE WEB APP
# Clone the project
$ git clone https://github.com/Samanyu13/VCC_Assessment-1
$ cd VCC_Assessment-1
$ npm install
$ npm start
# The app will be functional in port 3000.
``` 

<u>**Creating the dockerfile**</u>

After making sure that the application works well locally, we move towards creating a docker container for hosting the same. Following steps explain this process.
- The obvious first step is to install docker. Since I use Ubuntu as my base OS, I followed [this](https://docs.docker.com/engine/install/ubuntu/) installation procedure.
- Next, I created a [dockerfile](/dockerfile) in the main directory. The dockerfile is the file that should contain all the necessary command line calls in order to assemble our corresponding image. The created dockerfile is shown below.
```sh
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

``` 
<u>**Explanation of the above Dockerfile**</u>

Since it was mentioned to create the container from scratch, we are making use of the latest Ubuntu base image. This is where we will be creating our server for the application.
Since it is a base image, we will have to install all the corresponding dependencies to run our application.
- First, we will get the latest Ubuntu base image for our container.
```sh
FROM ubuntu:latest
```
- Next, we create a directory, that is specifically meant to store all the corresponding code, and this will be set as the working directory of our application.
```sh
WORKDIR /usr/src/app
```
- Now, we copy all the files from our present working directory to the application directory.
```sh
COPY . ./
```
- Next, we need to make sure that all the dependencies to run the application are installed. Hence, we make use of the run command to install Node.js and npm.
```sh
RUN apt-get update && apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/
RUN apt-get install -y nodejs
RUN apt-get install -y npm
```
- To install dependencies of the application, we run the npm install command.
```sh
RUN npm install
```
- Now, we have to set the port number so that the app can use it. We use the EXPOSE instruction for this purpose.
```sh
EXPOSE 3000
```
- Finally, we need to use the CMD instruction to run the command defining the runtime. 
```sh
CMD ["npm", "start"]
```

<u>**Deploying the Application in Docker**</u>
Now, all the elements are set in place. The final step of this entire process is to create the container and run the app along with it.
- The first thing to do is to build the image. The is done with the help of the build instruction. It makes use of the dockerfile that is created and the set of files in its path. We can make use of the -t flag, which helps us to tag the image that we create.
```sh
docker build . -t samanyu13/node-web-app
```
- After the build finishes, we can proceed to run the image. This can be done with  the help of the run command. The flag, -d means that app will be running in the detached mode. The flag -p is used for redirecting a public port to a corresponding privte port in the container. 
```sh
docker run -p 3000:3000 -d samanyu13/node-web-app
```
- We will be able to see the list of containers present using the ps instruction. 
```sh
➜  VCC_Assessment-1 git:(main) ✗ docker ps -a
CONTAINER ID   IMAGE                    COMMAND       CREATED          STATUS                      PORTS                                       NAMES
c1923f4ac9c2   samanyu13/node-web-app   "npm start"   27 seconds ago   Up 26 seconds               0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   great_kilby
c2fcf608be1a   samanyu13/node-web-app   "npm start"   16 minutes ago   Exited (0) 6 minutes ago                                                relaxed_shirley
```
We can see that the fisr one in the list is up and running in port 3000. The output is shown below.
![Using Docker](/public/docker.png)

<u>**System Configuration**</u>
- OS: Ubuntu 20.04.3 LTS 
- Processor: AMD® Ryzen 7 4800HS with radeon graphics × 16 
- RAM: 15.1 GiB 3200MHz DDR4


<u>**Running webapp using Docker in your system**</u>
```sh
# Install docker referring to the official documentation. 
$ git clone https://github.com/Samanyu13/VCC_Assessment-1.git
$ cd VCC_Assessment-1
$ docker build . -t node-web-app 
$ docker run -it -p 3000:3000 node-web-app
# The web application can be accessed at http://0.0.0.0:3000/.
```

### <u>**Acknowledgements**</u>
- [Bassir Jafarzadeh](https://github.com/basir)
- [Dockerizing a Node.js web app - NodeJS Official Documentation](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/)
