#!/usr/bin/env bash

# ----------------------------------
# Script Name: playondocker.sh
# Description: Create or update 'playondocker' container
# Author: Hygor Hailer
# Date: 02-05-2024
# Version: 1.0
# Usage: ./playondocker.sh
# ----------------------------------

# Path to the 'gamer' directory on the host
export PLAYER_DIR="YOUR_PATH"

# Function to display a loading animation
update() {
    dot="."
    for i in {1..4}
    do
        clear
        echo -e "\nUpdating$dot"
        sleep 1
        dot+="."
    done
    echo
}

# Function to check if a Docker image exists
check_image() {
    if [[ "$(docker images -q playondocker 2> /dev/null)" == "" ]]; then
        echo "Docker image 'playondocker' does not exist."
        read -p "Do you want to create it? (yes/no): " resp
        case $(echo $resp | tr '[:upper:]' '[:lower:]') in
            y|yes) build_new;;
            n|no) exit 0 ;;
            *) echo "Invalid option" && exit 0;;
        esac
    fi
}

# Function to check if a Docker container exists
check_container() {
    if [[ "$(docker ps -a | grep -w playondocker 2> /dev/null)" == "" ]]; then
        echo "Docker container 'playondocker' does not exist."
        read -p "Do you want to create it? (yes/no): " resp
        case $(echo $resp | tr '[:upper:]' '[:lower:]') in
            y|yes) create_container && exit 0 ;;
            n|no) exit 0 ;;
            *) echo "Invalid option" && exit 0;;
        esac
    fi
}

# Function to prompt the user for confirmation
confirm_execution() {
    clear
    echo -e "\nAre you sure you want to run the playondocker updater? (the current container and image will be deleted)"
    read -p "(yes/no): " resp

    case $(echo $resp | tr '[:upper:]' '[:lower:]') in
        y|yes) update;;
        n|no) exit 0 ;;
        *) echo "Invalid option" && exit 0;;
    esac
}

# Function to stop and remove the old container and image
cleanup_old() {
    echo -e "\nStopping and removing the old container and image"
    docker stop playondocker && docker rm playondocker && docker rmi playondocker || echo "Failed to remove old container and image"
    echo
}

# Function to build the new playondocker image
build_new() {
    echo "Building the new playondocker image"
    docker build -t playondocker . || { echo "Failed to build new image"; exit 1; }
    echo
}

# Function to create the playondocker container
create_container() {
    echo "Creating the playondocker container"
    xhost SI:localuser:$USER
    docker run -it --privileged --network=host --gpus all --device /dev/dri/card0:/dev/dri/card0 --env DISPLAY=$DISPLAY --volume=$HOME/.Xauthority:/root/.Xauthority:rw --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw -e PULSE_SERVER=unix:/run/user/1000/pulse/native -v /dev/snd:/dev/snd:rw -v /run/user/1000/pulse:/run/user/1000/pulse -v $PLAYER_DIR:/home/gamer:rw -v /dev/input:/dev/input -v /dev/bus/usb:/dev/bus/usb --privileged --name playondocker playondocker || { echo "Failed to create new container"; exit 1; }
}

# Function to check the status of the playondocker container
check_status() {
    echo ""
    if [[ $(docker ps -a | grep -w playondocker) ]];
    then 
        echo "Update successful!"
        docker ps -a | grep -w playondocker
    else
        echo "Update failed!"
        exit 1
    fi
}

# Main script execution
cd dockerfile/ || { echo "Failed to access Dockerfile directory"; exit 1; }
check_image
check_container
confirm_execution
cleanup_old
build_new
create_container
check_status

exit 0;
