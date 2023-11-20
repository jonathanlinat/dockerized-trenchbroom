<p align="center">
  <img src="https://github.com/TrenchBroom/TrenchBroom/raw/master/app/resources/graphics/images/AppIcon.png" alt="TrenchBroom Logo" height="200">
</p>

<h1 align="center">Dockerized 🐋 TrenchBroom</h1>

This repository contains the [TrenchBroom](https://github.com/TrenchBroom/TrenchBroom) source code set up for Docker. TrenchBroom is a level editor for multiple games.

[Docker](https://www.docker.com) is used here to simplify building the application. With Docker, developers can compile and build the application without manually installing all dependencies.

> ⚠️ **Disclaimer**: This setup is currently only compatible with Linux environments. Support for Windows and macOS is planned for the near future.

## Structure of the Project

The project utilizes a `TrenchBroom` directory, which is a Git clone of the TrenchBroom source. When the `build.sh` script is run, it compiles the content of the `TrenchBroom` directory.

```text
.
├── TrenchBroom/
│   └── build/
│       └── <environment>/
│           └── <type>/
│               └── <target>/
│                   └── ...
├── .gitignore
├── build.sh
├── Dockerfile.linux
├── LICENSE
└── README.md
```

## Getting Started

Ensure you have [Docker Engine](https://docs.docker.com/engine/) installed and operational. An alternative user-friendly interface for managing Docker elements is [Docker Desktop](https://docs.docker.com/desktop/).

> ⚠️ **Technical Note**: For an optimized building experience, it may be necessary to adjust your Docker resource allocations, including CPU, Memory, and Disk Space. Increasing these limits in Docker settings can significantly enhance performance, especially for resource-intensive tasks, and avoid failing building processes.

### How to Use

1. Clone this repository:

   ```bash
   git clone https://github.com/jonathanlinat/dockerized-trenchbroom.git
   ```

2. Navigate to the cloned directory:

   ```bash
   cd dockerized-trenchbroom
   ```

3. Clone the official TrenchBroom source code or a fork into this project:

   ```bash
   git clone --recursive https://github.com/TrenchBroom/TrenchBroom.git
   ```

   > **Note**: To clone a specific branch, append `-b <branchname>` to the command.

   After this step, you should have a directory named `TrenchBroom`, as shown in the project structure above.

4. Compile the application:

   Open your terminal and execute the following, optionally replacing:

   - `<environment>` with `linux`
   - `<type>` with `Debug` or your desired type (like `Release`, `RelWithDebInfo` or `MinSizeRel`)
   - `<target>` with `TrenchBroom` or your desired target (like `GenerateManual`)

   ```bash
   ./build.sh <environment> <type> <target>
   ```

   This will initiate the Docker-based build process. The resulting binary will be placed in `TrenchBroom/build/<environment>/<type>/<target>/`.

With these steps, you can easily compile TrenchBroom using Docker, ensuring a consistent and streamlined build process.

## License

**Dockerized 🐋 TrenchBroom** is [MIT licensed](LICENSE).
