#!/bin/bash

# Exit script on error
set -e

# Clear the command prompt
clear

# Validate the build environment
BUILD_ENV=${1:-linux}
case "$BUILD_ENV" in
  linux)
    ;;
  *)
    echo "Error: Invalid build environment '${BUILD_ENV}'. Allowed value is linux."
    exit 1
    ;;
esac

# Default build type
BUILD_TYPE=${2:-Debug}
case "$BUILD_TYPE" in
  Debug|Release)
    ;;
  *)
    echo "Error: Invalid build type '${BUILD_TYPE}'. Allowed values are Debug and Release."
    exit 1
    ;;
esac

# Default build target
BUILD_TARGET=${3:-TrenchBroom}

# Define image and container names
IMAGE_NAME=$(echo "dockerized-trenchbroom-${BUILD_ENV}-${BUILD_TYPE}-${BUILD_TARGET}" | tr '[:upper:]' '[:lower:]')
CONTAINER_NAME="${IMAGE_NAME}-container"

# Build the Docker image
DOCKER_BUILDKIT=1 docker build -f ./Dockerfile.$BUILD_ENV -t $IMAGE_NAME --build-arg BUILD_ENV=$BUILD_ENV --build-arg BUILD_TYPE=$BUILD_TYPE --build-arg BUILD_TARGET=$BUILD_TARGET .

# Check if the container already exists
docker run -d --name $CONTAINER_NAME $IMAGE_NAME

# Define output path
BUILD_PATH=TrenchBroom/build/$BUILD_ENV/$BUILD_TYPE/$BUILD_TARGET

# Delete local app directory
rm -rf ./$BUILD_PATH

# Ensure local build directory exists, create it if it does not
mkdir -p ./$BUILD_PATH

# Copy files from the container to the host
docker cp $CONTAINER_NAME:/$BUILD_PATH/. ./$BUILD_PATH

# Stop and remove the container
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

echo "Building process of ${BUILD_TARGET} (${BUILD_ENV}) completed successfully!"
