# SonarQube for OpenShift
This is repository contains SonarQube images optimized for OpenShift, so you can use to learn how Docker and OpenShift works, or even use it for actual code coverage in real projects. It uses PostgreSQL as the default DBMS, so if you'd like to use another database for persistence, feel free to make a pull request with a new Dockerfile set up for another DBMS. 

## Which Versions are you using?
As of July 2020, the latest versions of SonarQube are its LTS (7.9.3) and the latest version (8.4.1). This repo contains a Dockerfile for both, and it might be updated in the future when new versions of SonarQube are released. 

## What is this for?
Since there are no official ways of deploying SonarQube on OpenShift, I decided to create this project, that creates an image from scratch using CentOS 8 and installs SonarQube. This will allow projects to be tested against bugs, code smells and security flaws on OpenShift. Note that this repo creates an image with the community version of SonarQube, so checkout their licenses before using this with enterprise code. If you have a license for SonarQube, you can use my Dockerfile to create private images for your company to run on OpenShift. Just don't share these private images with anyone (well, I don't think I have to say this, but...).

## Do I actually need an OpenShift cluster for this?
No. Although these images were created with OpenShift in mind, you can run them locally using the ```docker-compose.yaml``` file I provided for each image, that starts a container with one of the images in this repo and pulls the official PostgreSQL 10.13 image from Docker Hub to run with it. 

## Why is every Dockerfile folder a git repo?
Because that's how OpenShift works. When using the Docker strategy to create an application, you need to provide a git repository containing the Dockerfile for the image. In this case, a local git repo will be provided so the application may work.

## Running locally with Docker
### Requirements
* Docker

### Step-by-step
```bash
# Clone the repo
git clone https://github.com/thaalesalves/sonarqube-openshift

# You can build sonarqube7 or sonarqube8, just change the directory you'll cd into
cd sonarqube-openshift/Docker/sonarqube7

# Build the image - change the tag based on which version you chose ealier
docker build -t openshift-sonarqube:7 .

# Start the containers
docker-compose up

# Just wait until it starts. You will be able to access it at http://localhost:9000 with your browser
# Log in using "admin" as both username and password
```

## Running on an OpenShift (or Minishift) cluster
### Requirements
* An OpenShift cluster (or a MiniShift VM)
* A user with permissions to create a project and an application
* The resources provided in this repo
* The IP (or DNS) of the cluster you'll be logging in to
  
### Step-by-step
```bash
# Note: these instructions are not validated yet. This is just a placeholder. I'm still working on the project. You can still use Docker to build and run the image though, without OpenShift. Just follow the other set of instructions and you'll be good to go.
git clone https://github.com/thaalesalves/sonarqube-openshift
oc login -u your_user https://openshiftaddress.com/
oc new-project sonarqube
oc process file.yaml | oc create -f -
oc logs -f bc/sonarqube
oc logs -f bc/postgresql
oc logs -f dc/sonarqube
oc logs -f dc/postgresql
watch -n 1 oc get pods
```