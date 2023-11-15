#!/bin/bash

# Exit script on error
set -e

# Clear the command prompt
clear

# Validate the build environment
BUILD_ENV=${1:-linux}
case "$BUILD_ENV" in
  linux|macos|windows)
    ;;
  *)
    echo "Error: Invalid build environment '${BUILD_ENV}'. Allowed value is linux, macos and windows."
    exit 1
    ;;
esac

# Default build target
BUILD_TARGET=${2:-TrenchBroom}
BUILD_TARGET_LOWER=$(echo "$BUILD_TARGET" | tr '[:upper:]' '[:lower:]')

# Define image and container names
IMAGE_NAME="dockerized-trenchbroom-${BUILD_ENV}-debug-${BUILD_TARGET_LOWER}"
CONTAINER_NAME="${IMAGE_NAME}-container"

# Build the Docker image
DOCKER_BUILDKIT=1 docker build -f ./Dockerfile.$BUILD_ENV -t $IMAGE_NAME --build-arg BUILD_TARGET=$BUILD_TARGET .

# Check if the container already exists
if [ $(docker ps -a -q -f name=^${CONTAINER_NAME}$) ]; then
  # Container exists, just start it
  docker start $CONTAINER_NAME
else
  # Container does not exist, run it
  docker run -d --name $CONTAINER_NAME $IMAGE_NAME
fi

# Define output path
BUILD_PATH=TrenchBroom/build/

# Delete local app directory
rm -rf ./$BUILD_PATH

# Ensure local build directory exists, create it if it does not
mkdir -p ./$BUILD_PATH

# Copy files from the container to the host
docker cp $CONTAINER_NAME:/$BUILD_PATH. ./$BUILD_PATH

# Stop and remove the container
docker stop $CONTAINER_NAME

echo "Building process of ${BUILD_TARGET} (${BUILD_ENV}) completed successfully!"
