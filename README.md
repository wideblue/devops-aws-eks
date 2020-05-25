# Udacity devops capstone project

## Scope 
In this project I will demonstrate automated provisioning of cloud infrastructure (AWS EKS cluster) for the needs of running devops pipelines with Jenkins and for production environment of simple microservice.  Also the provisioned Jenkins will automate CI/CD pipeline that will deploy simple microservice (nginx server) to the provisioned AWS EKS cluster. The focus of the project is not on the microservice but on automation and on infrastructure as a code. Everything, except setting up the pipeline where we pass GitHub token to Jenkins and save credentials of DockerHub in Jenkins, is automated. 

### Used tools

- AWS CloudFormation for provisioning of VPC, subnets, ...
- [eksctl](https://eksctl.io/) for provisioning an EKS cluster on existing VPC
- Helm for installation of Jenkins chart inside EKS cluster
- Ansible for glueing provisioning tasks together 
- EKS kubernetes as base platform for running everything in automated way   
- Jenkins for CI/CD pipeline
- Nginx as demo microservice

### Infrastructure

In the [Infractructure](./Infrastructure) is an ansible playbook that provisions whole infrastructure. The playbook should provision VPC with 3 public subnets in 3 availability zones. Then it should create EKS cluster on those subnets and install Jenkins in `jenkins` namespace inside the cluster. 
The configuration of the cluster on public subnets is to lower running cost, but if security is more important than the configuration can be changed to include private subnets. (This can be achieved either by changing [VPC template](https://docs.aws.amazon.com/eks/latest/userguide/create-public-private-vpc.html) or using eksctl without existing VPC)

Run:
```
cd Infrastructure
ansible-playbook -i inventory.ini main.yaml
```
##### Requirements
Your system needs to have installed aws CLI (and configured with aws access), python3 package [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html) (and its dependencies), [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) and [Helm](https://helm.sh/docs/intro/install/).

NOTE: I first tried to create EKS cluster without eksctl, only with cloudformation templates, but I failed. For now I'm keeping failed templates in [EKS-cloudformation-FAILED](./EKS-cloudformation-FAILED)folder.

### Pipeline

The whole Jenkins CI/CD pipeline is run inside kubernetes (EKS). Stages are:
- Lint: linting HTML files with tidy tool
- Docker Build: build docker image for microservice (wideblue/udacity-microservice)
- Docker push: push the built image to [DockerHub](https://hub.docker.com/repository/docker/wideblue/udacity-microservice)
- Kubernetes Deploy: deploying the microservice as a `Deployment` kubernetes object and exposing it as a service type LoadBalancer as defined in [sample-app/deploy-manifest.yaml](./sample-app/deploy-manifest.yaml) manifest.

The microservice rolling update gets executed when new microservice image gets build with a new tag (,set as git commit SHA) and manifest `deploy-manifest.yaml` with updated image tag is `apply`-ed to kubernetes cluster.   

### TODO:
- [x] Infra cloudformation code (EKS Kubernetes)
- [x] Jenkins setup with Helm
- [x] Pipeline configuration
