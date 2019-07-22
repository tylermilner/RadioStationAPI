#!/bin/bash

# Start up only the "db" container
docker-compose --file docker-compose-dev.yml up db
