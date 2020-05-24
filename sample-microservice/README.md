[![wideblue](https://circleci.com/gh/wideblue/udacity-devops-microservices-proj.svg?style=svg)](https://app.circleci.com/pipelines/github/wideblue/udacity-devops-microservices-proj)

#  Demonstration Machine Learning Microservice API

This is a project for Udacity Cloud Devops nanodegree that demonstrates simple python microservice  that serves predictions of housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. The microservice is built with pre-trained, `sklearn` model (`model_data`) that has been trained with data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). The project was set up to tests my ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. The tasks that needed to be done are listed in [Project instructions](./Project-instrutions.md). The project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

## Running the microservice

### Local setup

Python 3 needs to be installed on your system. The use of python virtualenv is suggested. To create and activate a new environment, named .devops with Python 3 run:
```
python3 -m venv ~/.devops
source ~/.devops/bin/activate
```
Install dependencies: 
```
make install
```
Run the service on port 8000:
```
python app.py 8000
```

### Run in Docker 

There is a convenience script that builds a Docker image from `Dockerfile` and creates a container that listens on port 8000:
```
./run_docker.sh
```
`upload_docker.sh` is a convenience script that tags and pushes Docker image to registry. In order to do that first set the `dockerpath` variable to `<Your Docker ID>/<Image-name>` in the script and then run it 
```
./upload_docker.sh
```

### Run on Kubernetes 

The `kubectl` CLI needs to be installed and configured on the system. There is a convenience script `run_kubernetes.sh` that creates a kubernetes pod based on the Docker image. If you want to use your own image push it first to the registry with `upload_docker.sh` and also set the `dockerpath` variable to `<Your Docker ID>/<Image-name>` in both scripts.  The script also forwards pod port 80 to port 8000 on local machine:
```
./run_kubernetes.sh
```
If the script returns an error because the pod hasn't started yet, just wait for the pod to start and run `kubectl port-forward udacity-app 8000:80` again.

### Make predictions

Script that sends default set of parameters to the microservice API endpoint is run:
```
./make_prediction.sh
```
To get prediction for different kind of housing change parameters in the script and rerun the script.

### Development use of CI/CD
In the root of this repository is configuration directory `.circleci` for Circle CI pipeline. 


