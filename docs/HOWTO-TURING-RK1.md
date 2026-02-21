# Building Ubuntu Image for Turing RK1

Complete guide for building Ubuntu images for the Turing RK1 board.

## Prerequisites

### System Requirements
- Ubuntu 22.04 or 24.04 host system
- Root access
- 50GB+ free disk space
- 8GB+ RAM recommended

### Install Dependencies
```bash
sudo apt-get update
sudo apt-get install -y build-essential gcc-aarch64-linux-gnu bison \
  flex libssl-dev bc device-tree-compiler dosfstools mtools parted \
  debootstrap qemu-user-static git wget xz-utils
```

## Quick Start

### Build Complete Image
```bash
sudo ./build.sh --board=turing-rk1 --suite=noble --flavor=desktop
```

### Build Options
- **Suite**: `jammy` (22.04 LTS) or `noble` (24.04 LTS)
- **Flavor**: `server` or `desktop`

## Step-by-Step Build

### 1. Build Kernel Only
```bash
sudo ./build.sh --board=turing-rk1 --suite=noble --kernel-only
```
Output: `build/linux-*.deb` packages

### 2. Build U-Boot Only
```bash
sudo ./build.sh --board=turing-rk1 --uboot-only
```
Output: `build/u-boot-turing-rk1_*.deb`

### 3. Build Rootfs Only
```bash
sudo ./build.sh --suite=noble --flavor=desktop --rootfs-only
```
Output: `build/ubuntu-*-preinstalled-desktop-arm64.rootfs.tar.xz`

### 4. Build Complete Image
```bash
sudo ./build.sh --board=turing-rk1 --suite=noble --flavor=desktop
```
Output: `images/ubuntu-*-turing-rk1.img.xz`

## Board-Specific Configuration

The Turing RK1 configuration (`config/boards/turing-rk1.sh`) includes:
- **SoC**: Rockchip RK3588
- **CPU**: ARM Cortex A76/A55
- **U-Boot**: u-boot-turing-rk3588 package
- **Console**: UART9 @ 115200 baud (jammy/noble), UART0 (oracular)
- **GPU**: Mali G610 with Panfork Mesa drivers
- **Camera**: Rockchip RKAIQ engine support

## Using Launchpad Packages

To use pre-built packages from Launchpad PPA instead of building locally:
```bash
sudo ./build.sh --board=turing-rk1 --suite=noble --flavor=desktop --launchpad
```

This skips kernel and U-Boot compilation, using packages from:
- ppa:jjriek/rockchip
- ppa:jjriek/rockchip-multimedia

## Clean Build

Remove all build artifacts:
```bash
sudo ./build.sh --clean
```

## Flashing the Image

### Extract and Flash
```bash
xz -d images/ubuntu-*-turing-rk1.img.xz
sudo dd if=images/ubuntu-*-turing-rk1.img of=/dev/sdX bs=4M status=progress
sync
```

Replace `/dev/sdX` with your SD card device.

### Verify Checksum
```bash
sha256sum -c images/ubuntu-*-turing-rk1.img.xz.sha256
```

## First Boot

### Server
- Login via HDMI/serial/SSH
- Username: `ubuntu`
- Password: `ubuntu`

### Desktop
- Connect via HDMI
- Follow setup wizard

## Troubleshooting

### Build Fails
- Check logs in `build/logs/build-*.log`
- Ensure sufficient disk space
- Verify all dependencies installed

### Kernel Build Issues
- Clean build: `sudo ./build.sh --clean`
- Check suite configuration in `config/suites/`

### U-Boot Build Issues
- Verify board configuration in `config/boards/turing-rk1.sh`
- Check upstream sources in `packages/u-boot-turing-rk3588/debian/upstream`

### Image Won't Boot
- Verify SD card integrity
- Check power supply (5V/3A minimum)
- Confirm correct UART console settings
- Try re-flashing with verified checksum

## Advanced Usage

### Custom Kernel Config
Edit kernel configuration before building:
```bash
cd build/linux-rockchip
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- menuconfig
```

### Modify Rootfs
Edit `scripts/build-rootfs.sh` to add packages to `config/package-lists/my.list.chroot`

### Board-Specific Hooks
Modify `config/boards/turing-rk1.sh` functions:
- `config_image_hook__turing-rk1()` - Customize rootfs during config
- `build_image_hook__turing-rk1()` - Customize during image creation

## Build Artifacts

```
build/
├── linux-image-*.deb              # Kernel image
├── linux-headers-*.deb            # Kernel headers
├── linux-modules-*.deb            # Kernel modules
├── u-boot-turing-rk1_*.deb        # U-Boot bootloader
├── ubuntu-*-arm64.rootfs.tar.xz   # Base rootfs
└── logs/                          # Build logs

images/
├── ubuntu-*-turing-rk1.img.xz     # Compressed disk image
└── ubuntu-*-turing-rk1.img.xz.sha256  # Checksum
```

## Resources

- Project: https://github.com/Joshua-Riek/ubuntu-rockchip
- Downloads: https://joshua-riek.github.io/ubuntu-rockchip-download/
- Turing RK1: https://turingpi.com/product/turing-rk1/
