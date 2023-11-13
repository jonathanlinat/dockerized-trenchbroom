#!/bin/bash

# Exit script on error
set -e

# Clear the command prompt
clear

# Default build target
BUILD_TARGET=${1:-TrenchBroom}

# Convert build target to lowercase
BUILD_TARGET_LOWER=$(echo "$BUILD_TARGET" | tr '[:upper:]' '[:lower:]')

# Define image and container names
IMAGE_NAME="dockerized-trenchbroom-debug-${BUILD_TARGET_LOWER}"
CONTAINER_NAME="${IMAGE_NAME}-container-$(date +%Y%m%d%H%M%S)"

# Build the Docker image
DOCKER_BUILDKIT=1 docker build -t $IMAGE_NAME --build-arg BUILD_TARGET=$BUILD_TARGET .

# Run the container
docker run -d --name $CONTAINER_NAME $IMAGE_NAME

# Delete local app directory
rm -rf build/$BUILD_TARGET/

# Ensure local build directory exists, create it if it does not
mkdir -p build/$BUILD_TARGET/

# Copy files from the container to the host
docker cp $CONTAINER_NAME:/TrenchBroom/build/app/. build/$BUILD_TARGET/

# Stop and remove the container
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

echo "Building process of ${BUILD_TARGET} completed successfully!"
