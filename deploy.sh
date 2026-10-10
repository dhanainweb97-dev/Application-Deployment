#!/bin/bash
set -e

echo "Starting application deployment..."

docker compose up -d --force-recreate --remove-orphans

echo "Application deployment completed successfully."
docker ps --filter name=application-deployment
