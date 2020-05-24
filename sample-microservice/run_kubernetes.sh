#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath="wideblue/udacity-microservice"
 
# Step 2
# Run the Docker Hub container with kubernetes
kubectl run  udacity-app --image=$dockerpath --port 80 --restart Never

# Step 3:
# List kubernetes pods
kubectl get po -o wide

# Step 4:
# Forward the container port to a host
# note this would usually fail because the 
# udacity-app pod would not start yet
sleep 60
kubectl port-forward udacity-app 8000:80

# Standard way to expose service on host node,
# the exposed port number is set by cluster
# kubectl expose po udacity-app --type NodePort

# This would expose service to a specific port on the host 
# The range of valid ports is 30000-32767
# kubectl create service nodeport udacity-app-svc --tcp=80:80 \
# --node-port=30080 -o yaml --dry-run=client | kubectl set \
# selector --local -f - 'run=udacity-app' -o yaml | kubectl create -f -

