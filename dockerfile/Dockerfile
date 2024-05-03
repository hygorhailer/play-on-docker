FROM archlinux:latest as playondocker
MAINTAINER Hygor Hailer

# Copy mirrorlist
COPY mirrorlist /etc/pacman.d/mirrorlist

# Enable multilib repository
RUN echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

# Initialize pacman keyring and upgrade all packages
RUN pacman-key --init && \
    pacman -Syu --noconfirm

# Install necessary packages
RUN pacman -S --noconfirm \
    archlinux-keyring \
    fftw \
    firefox \
    gtk2 \
    gtk3 \
    gtk4 \
    hwloc \
    lib32-flac \
    lib32-libasyncns \
    lib32-libogg \
    lib32-libpulse \
    lib32-libsndfile \
    lib32-libvorbis \
    lib32-libxtst \
    lib32-mesa \
    lib32-nvidia-utils \
    lib32-opus \
    lib32-vulkan-icd-loader \
    lib32-vulkan-intel \
    libtool \
    lutris \
    nvidia \
    nvidia-prime \
    nvidia-settings \
    nvidia-utils \
    openmpi \
    openpmix \
    p7zip \
    polkit \
    pulseaudio \
    pulseaudio-alsa \
    rtkit \
    sdl12-compat \
    steam \
    sudo \
    lib32-acl \
    lib32-fontconfig \
    lib32-freetype2 \
    lib32-gettext \
    lib32-glib2 \
    lib32-harfbuzz \
    lib32-libnl \
    lib32-libpcap \
    lib32-libpng \
    lib32-libxcursor \
    lib32-libxrandr \
    lib32-libxrender \
    lib32-pcre2 \
    lib32-util-linux \
    vim \
    wine 

# Create a new user 'gamer'
RUN useradd -m gamer

# Define user and group IDs
ENV UID=1000 GID=1000

# Configure 'gamer' user and permissions
RUN mkdir -p /home/gamer /run/user/$UID && \
    echo "gamer:x:$UID:$GID:gamer,,,:/home/gamer:/bin/bash" >> /etc/passwd && \
    echo "gamer:x:$UID:" >> /etc/group && \
    echo "gamer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/gamer && \
    chmod 0440 /etc/sudoers.d/gamer && \
    chown -R $UID:$GID /home/gamer /run/user && \
    usermod -a -G video,wheel gamer

# Switch to 'gamer' user
USER gamer
ENV USER=gamer

# Define volume for persistent data
VOLUME /home/gamer
