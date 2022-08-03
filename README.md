# SonarQube for OpenShift
This repository contains a SonarQube image optimized for OpenShift that you can use to learn how Docker and OpenShift work, or even use it for actual code coverage in real projects. It uses PostgreSQL as the default DBMS, so if you'd like to use another database for persistence, feel free to make a pull request with a new Dockerfile set up for a different DBMS.

## Which versions are you using?
The version it uses is up to the developer. By default, project's `Dockerfile` is set to use `8.4.1.35646`, and `docker-compose.yaml` will use `9.4.0.54424`. If you'd like to use a different version, you can check [here](https://binaries.sonarsource.com/?prefix=Distribution/sonarqube/) which versions are available and just change the version tag in the compose file (it ovverides the default definition in the `Dockerfile`).

### Why are there different versions in the files?
Because this image will work for both containers on OpenShift or local Docker/Podman containers. If you'd like to use it locally with Compose, change the version in the compose file. If you're going to use and build the image for OpenShift, change the version in the Dockerfile or provide the argument with the proper version so it overrides the default value.

## What is this for?
Since there are no official ways of deploying SonarQube on OpenShift, I decided to create this project. Images are created from scratch using CentOS 8, and SonarQube is installed and set up. This will allow projects to be tested against bugs, code smells and security flaws on OpenShift. Note that this repo creates an image with the community version of SonarQube, meant for single developers only. For enterprise licenses, check their website. If you own a license, you can adapt this project's Dockerfile to deploy an image for you, but remember not to share the adapted image with anyone that is not part of your company.

## Do I actually need an OpenShift cluster for this?
No. Although this image was created with OpenShift in mind, you can run it locally using the `docker-compose.yaml` file I provided. It builds the image automatically and then runs a container using the image built and pulls the official PostgreSQL 10.13 image from Docker Hub to run with it. The local image will be built as `localhost/sonarqube:latest`. To change the tag, just modify it in the compose file.

## Running locally
### Requirements
* Docker (or Podman)

### Customization
You can change database name, user and password, as well the JDBC connection string, by altering some environment variables. These are also the default values used for docker-compose.

* `SONAR_JDBC_USERNAME`: remote database username. Default value is `sonarqube`.
* `SONAR_JDBC_PASSWORD`: remote database password. Default value is `sonarqube`.
* `SONAR_JDBC_URL`: remote database connection string. Default value is set to a PostgreSQL DB: `jdbc:postgresql://postgresql/sonarqube`. That means the database name is `sonarqube` and the hostname is `postgresql`.
* `SONAR_ELASTICSEARCH_DIR`: elasticsearch working directory. Default value is `/var/share/sonarqube/elasticsearch`.
* `SONAR_TEMP_DIR`: default temp dir. Default value is `/var/share/sonarqube/temp`.

### Step-by-step
```bash
# Clone the repo
git clone https://github.com/thaalesalves/sonarqube-openshift

# You can build sonarqube7 or sonarqube8, just change the directory you'll cd into
cd sonarqube-openshift

# Build the image - the containers will start automatically
docker-compose up

# OR (if you're running Podman)
podman-compose up

# Just wait until it starts. You will be able to access it at http://localhost:9000 with your browser
# Log in using "admin" as both username and password
```

## Running on OpenShift
### Requirements
* An OpenShift cluster (or a local installation of OKD)
* A user with permissions to create a project and an application
* The resources provided in this repo
* The IP (or DNS) of the cluster you'll be logging in to

### Step-by-step
```bash
# Note: these instructions are not validated yet. This is just a placeholder. I'm still working on the project.
# You can still use Docker to build and run the image though, without OpenShift.
# Just follow the other set of instructions and you'll be good to go.

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
