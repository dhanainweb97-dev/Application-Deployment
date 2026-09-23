#!/bin/bash

IMAGE_NAME="dhanainweb97/application-deployment"
IMAGE_TAG="latest"

echo "Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"

docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

echo "Docker image build completed successfully."