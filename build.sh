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
  Debug|Release|RelWithDebInfo|MinSizeRel)
    ;;
  *)
    echo "Error: Invalid build type '${BUILD_TYPE}'. Allowed values are Debug, Release, RelWithDebInfo and MinSizeRel."
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

# Check if the container already exists; if so, delete it
if [ $(docker ps -a -q -f name=^/$CONTAINER_NAME$) ]; then
  docker rm $CONTAINER_NAME
fi

# Create a new container
docker run -d --name $CONTAINER_NAME $IMAGE_NAME

# Define output paths
BUILD_SOURCE_PATH=TrenchBroom/build/$BUILD_ENV/$BUILD_TYPE/$BUILD_TARGET
BUILD_DESTINATION_PATH=$BUILD_SOURCE_PATH

# Check if the folder exists, if so, delete it
rm -rf "./$BUILD_DESTINATION_PATH"

# Ensure local build directory exists, create it if it does not
mkdir -p ./$BUILD_DESTINATION_PATH

# Loop over each file and copy it
FILES_TO_COPY=(".")
for file in "${FILES_TO_COPY[@]}"; do
  docker cp "$CONTAINER_NAME:/$BUILD_SOURCE_PATH/$file" "./$BUILD_DESTINATION_PATH/$file"
done

# Stop and remove the container
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

echo "Building process of TrenchBroom (${BUILD_TARGET} - ${BUILD_ENV}) completed successfully!"
