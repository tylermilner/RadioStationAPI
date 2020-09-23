#!/bin/bash

# Exit immediately if something fails
set -e

# Run database migrations
./Run migrate --yes
