# Play On Docker
![Shell Script](https://img.shields.io/badge/-Shell_Script-000000?style=flat-square&logo=GNU-Bash&logoColor=white)
![Docker](https://img.shields.io/badge/-Docker-3776AB?style=flat-square&logo=Docker&logoColor=white)

# Overview

Play on Docker is a repository that contains configuration files for creating an Arch Linux container with Lutris and Wine installed. This allows you to run your games in an environment isolated from the host system.

## Note

This container has been tested on a host machine running Arch Linux with a GeForce GTX 1650 graphics card. While the configuration might work on other Linux distributions, hardware acceleration may not be available. We recommend using a host system with Arch Linux to ensure the best compatibility and performance.


## Prerequisites

- Docker installed on your machine.
- Arch Linux on the host machine (to avoid GPU drivers version issues).

## Getting Started

1. **Clone the repository**

    Use the following command to clone this repository:
    ```
    git clone https://github.com/hygorhailer/play-on-docker.git
    ```

2. **Build the Docker image**

    The `playondocker.sh` script is designed to streamline the process of creating the Docker image and container. It automates the build and run tasks, making it easier for you to start using the container.
    
    However, before running the script, it’s important that you set up the path of the directory on your host machine that will be used as the mounted directory in the container. You can do this by modifying the following line in the script:
   
    `export PLAYER_DIR="YOUR_PATH"`

    Replace *YOUR_PATH* with the path of the directory you wish to use.

    Additionally, if you want to customize the container creation command, you can do so by altering the create_container function in the script. This function contains the Docker command used to create the container, and you can modify it to suit your specific needs.

    Remember, the `playondocker.sh` script is just a tool to help you get started. If you prefer, you can simply navigate to the directory containing the Dockerfile and run the following command:
    ```
    docker build -t playondocker . 
    ```

## Updating the Container

The `playondocker.sh` script can be used to keep your container up-to-date, allowing it to keep pace with driver updates on the host system. It's important to note that all changes made within the container will be lost during this update process. However, the content within the mounted directory will be preserved.

## Contact

If you have any questions, feel free to reach out!
