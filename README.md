<p align="center">
  <img src="https://github.com/TrenchBroom/TrenchBroom/raw/master/app/resources/graphics/images/AppIcon.png" alt="TrenchBroom Logo" height="200">
</p>

<h1 align="center">Dockerized 🐋 TrenchBroom</h1>

This repository contains the [TrenchBroom](https://github.com/TrenchBroom/TrenchBroom) source code set up for Docker. TrenchBroom is a level editor for multiple games.

[Docker](https://www.docker.com) is used here to simplify building the application. With Docker, developers can compile and build the application without manually installing all dependencies.

> **Important**
>
> Currently, this setup is only compatible with Linux environments.

## Structure of the Project

The project utilizes a `TrenchBroom` directory, which is a Git clone of the TrenchBroom source. When the `build-<env>.sh` script is run, it generates a `build` directory (ignored by Git) where the compiled files are stored under the specified target sub-directory.

```text
.
├── build/
│   └── <target-name>/
│       └── ...
├── TrenchBroom/
│   └── ...
├── .gitignore
├── build-linux.sh
├── Dockerfile
├── LICENSE
└── README.md
```

## Getting Started

Ensure you have [Docker Engine](https://docs.docker.com/engine/) installed and operational. An alternative user-friendly interface for managing Docker elements is [Docker Desktop](https://docs.docker.com/desktop/).

### How to Use

1. Clone this repository:

   ```bash
   git clone https://github.com/jonathanlinat/dockerized-trenchbroom.git
   ```

2. Navigate to the cloned directory:

   ```bash
   cd <path/to/dockerized-trenchbroom-directory>/
   ```

3. Clone the official TrenchBroom source code or a fork into this project:

   ```bash
   git clone --recursive https://github.com/TrenchBroom/TrenchBroom.git
   ```

   > **Note**: To clone a specific branch, append `-b <branchname>` to the command.

   You, now, must have a directory named `TrenchBroom`, as shown in the structure of the project.

4. Compile the application:

   Open your terminal and execute the following, replacing `<target-name>` with `TrenchBroom` or your desired target (like `GenerateManual`):

   ```bash
   ./build-linux.sh <target-name>
   ```
   This will initiate the Docker-based build process. The resulting binary will be placed in `build/<target-name>/`.

With these steps, you can easily compile TrenchBroom using Docker, ensuring a consistent and streamlined build process.

## License

**Dockerized TrenchBroom** is [MIT licensed](LICENSE).
