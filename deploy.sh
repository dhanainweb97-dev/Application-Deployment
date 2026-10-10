#!/bin/bash
set -e

echo "Starting production deployment..."

docker compose up -d --force-recreate --remove-orphans

echo "Production deployment completed successfully."
docker ps --filter name=application-deployment-prod
