#!/bin/bash
set -e

IMAGE_NAME="${1:-dhanainweb97/dev:latest}"

docker build -t "$IMAGE_NAME" .
