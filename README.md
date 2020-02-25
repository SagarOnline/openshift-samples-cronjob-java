# Cronjob Sample in Openshift

This sample runs a Java application as CronJob inside in Openshift Container

### Prerequisites

In order to run this sample in Openshift Container, you need following softwares on your local

* Openshift Client
* Git Client

### Getting Started
Follow this steps to run this application

* Clone this repository in your local
* Open a new command prompt and login to openshift cluster
* Run below command . Please replace text <schopade-in> with the openshift project in which you need to create a cronjob.
	```
	oc policy add-role-to-user system:image-puller system:serviceaccount:<schopade-in>:default --namespace=bslicommon --rolebinding-name=allow-schopade-in-pods-to-pull-image-from-bslicommon
	```
* Run below command to create a BuildConfig which generates the docker image of the maven based Java application

  	```
  	oc apply -f ./openshift-s2i-build.yaml
  	oc start-build cronjob-s2i-image-build
  	``` 
  
* Previous step should build a docker image. Run below command to get the complete name of the image (with docker registry)
```
oc get is cronjob-sample
```  

* Note the Docker Repo of image. it should be something like 'docker-registry.default.svc:5000/schopade-in/cronjob-sample'

* Run below command to create a cronjob from this image. Please replace the image name with the one you got in last step
```
oc run cronjob-sample --image=docker-registry.default.svc:5000/schopade-in/cronjob-sample:latest --schedule='*/1 * * * *' --restart=OnFailure --
```