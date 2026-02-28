sudo apt update
sudo apt install qemu-user-static binfmt-support debootstrap

export TARGET_DIR=./ubuntu-resolute-arm64
mkdir -p $TARGET_DIR

# Stage 1: Download packages
sudo debootstrap --arch=arm64 --foreign --variant=minbase resolute $TARGET_DIR http://ports.ubuntu.com/ubuntu-ports/
sudo cp /usr/bin/qemu-aarch64-static $TARGET_DIR/usr/bin/
# Complete the bootstrap process inside the architecture
sudo chroot $TARGET_DIR /debootstrap/debootstrap --second-stage

# Mount as usual
sudo mount -t proc /proc $TARGET_DIR/proc
sudo mount -o bind /dev $TARGET_DIR/dev

# Enter the ARM64 world
sudo chroot $TARGET_DIR /bin/bash

# Verify you are on arm64:
uname -m 
# Should output: aarch64