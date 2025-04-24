#!/bin/bash

# Change directory to the folder
cd /opt/workshops/workshop_manager/
# Stash any local changes
git stash
# Checkout main branch if not already on it
git checkout main
# Pull any changes
git pull
# Stop and remove containers
docker-compose stop
echo "Restarting Docker containers"
docker-compose up -d
