# Use a lighter base image
FROM debian:bookworm-slim as builder

# Define build target for configuration
ARG BUILD_TARGET=TrenchBroom

# Install dependencies in a single layer and clean up after
RUN apt-get update && apt-get install -y \
  build-essential cmake curl freeglut3-dev gcc git libassimp-dev \
  libfreeimage-dev libfreetype6-dev libglew-dev libgl1-mesa-dev \
  libglm-dev libglu1-mesa-dev libqt5svg5-dev libtinyxml2-dev libxi-dev \
  libxrandr-dev libxxf86vm-dev mesa-common-dev ninja-build pandoc \
  p7zip-full pkg-config qtbase5-dev tar unzip xvfb zip \
  && rm -rf /var/lib/apt/lists/*

# Clone the local TrenchBroom directory and switch to it
COPY TrenchBroom/ /TrenchBroom
WORKDIR /TrenchBroom

# Create a build directory and switch to it
RUN mkdir -p build
WORKDIR /TrenchBroom/build

# Build TrenchBroom
RUN cmake -GNinja .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_PREFIX_PATH="cmake/packages" -DTB_ENABLE_CCACHE=1 \
  && cmake --build . --target ${BUILD_TARGET}
