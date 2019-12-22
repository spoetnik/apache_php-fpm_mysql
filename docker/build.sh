set -e

# Get de vars from the .env-file
export $(egrep -v '^#' .env | xargs)

if ! [[ -d ../logs/apache ]]; then
    mkdir -p ../logs/apache
fi
 
if ! [[ -d ../logs/mysql ]]; then
    mkdir -p ../logs/mysql
fi
 
if ! [[ -d ../logs/php ]]; then
    mkdir -p ../logs/php
fi
 
if ! [[ -d ../database ]]; then
    mkdir ../database
fi
 
docker-compose up -d --build
 
docker exec ${COMPOSE_PROJECT_NAME}_apache chown -R root:${WEB_GROUP} ${APACHE_ROOT_DIR}/logs
docker exec ${COMPOSE_PROJECT_NAME}_php chown -R root:${WEB_GROUP} ${PHP_ROOT_DIR}/logs