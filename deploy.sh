#!/bin/bash

echo "Starting application deployment..."

docker compose down

docker compose up -d

echo "Application deployment completed successfully."

docker ps