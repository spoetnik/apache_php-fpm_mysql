#!/bin/bash
set -e

# Get de vars from the .env-file
export $(egrep -v '^#' .env | xargs)

docker-compose down --volumes
docker rmi ${COMPOSE_PROJECT_NAME}_apache ${COMPOSE_PROJECT_NAME}_php ${COMPOSE_PROJECT_NAME}_mysql