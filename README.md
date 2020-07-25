# SonarQube for OpenShift
This is basically a fork of [Bitnami's Docker image for SonarQube](https://github.com/bitnami/bitnami-docker-sonarqube), but adapted for OpenShift. It works basically the same way but is wrapped up in an OpenShift template so it can run in an OpenShift cluster. It also uses [Bitnami's PostgreSQL Docker image](https://github.com/bitnami/bitnami-docker-postgresql).

## Which Versions are you using?
Bitnami's repos have various versions for both PostgreSQL and SonarQube, but I chose to use PostgreSQL 10 and SonarQube 8 for this. If you'd like to practice creating your own template for OpenShift, you can use other versions from their repo, or even create images from scratch. This repo serves as reference for those who are practicing with OpenShift (as I am), or those who just need some code coverage tool for whatever they're doing.

## What makes these different from the original images?
I made some minor optimizations so the images have less layers to them. This makes the images lighter and therefore faster. Some important tags were also added so OpenShift recognizes ports to be exposed and tags for the services when they're created. User IDs were also provided, as well as changed to some environment variables.

## Do I actually need an OpenShift cluster for this?
Well, yes, but actually no. Since this OpenShift application will be based on Docker images, you can just download the repo and build the images and use them with Docker as you would other images. But then again, the whole purpose of this was to adapt the images for OpenShift. You might be better off just using Bitnami's original versions, that were created just for use with Docker. Those might be easier to handle if you want to keep it simple. Still, you can build these images and run them as regular Docker images. There's a docker-compose file that will start containers with these images (of course, you have to build them first) so you can do just that. 

## Why is every Dockerfile folder a git repo?
Because that's how OpenShift works. When using the Docker strategy to create an application, you need to provide a git repository containing the Dockerfile for the image. In this case, a local git repo will be provided so the application may work.

## How do you set it up?
First, you need an actual OpenShift cluster or a local MiniShift cluster running on your own machine. You need access to ```oc``` so you can process the template and create actual resources with it.

### Requirements
* An OpenShift cluster (or a MiniShift VM)
* Docker might be useful
* A user with permissions to create a project and an application
* The resources provided in this repo
* The IP (or DNS) of the cluster you'll be logging in to

### Step-by-step
1. Log in to OpenShift with your user and password.
```
oc login -u your_user https://openshiftaddress.com/
```

2. Create a new project for our resources
```
oc new-project sonarqube
```

3. Clone this repo
```
git clone https://github.com/thaalesalves/sonarqube-openshift
```

4. Run ```oc``` to process the template and create a resource file
```
oc process file.yaml > resources.yaml
```

5. Create the resources using the file that was just generated
```
oc create -f resources.yaml
```

(you can also generate the resource file and immediatelly create the resources by using ```oc process file.yaml | oc create -f -```. Note that this will use the output of ```oc process``` as a paratemer instead of creating an actual file)

6. Wait until everything has been built and deployed. You can track the process using ```oc logs```
```bash
# Track the build logs
oc logs -f bc/sonarqube
oc logs -f bc/postgresql

# Track the deploy logs
oc logs -f dc/sonarqube
oc logs -f dc/postgresql

# Track pod creation, until they're all running
watch -n 1 oc get pods
```