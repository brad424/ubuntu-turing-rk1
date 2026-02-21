# build-rootfs.sh

Builds Ubuntu rootfs using live-build and livecd-rootfs.

## Usage
```bash
./scripts/build-rootfs.sh
```

## Requirements
- Must run as root
- Requires `SUITE` and `FLAVOR` environment variables

## Process
1. Checks for existing rootfs tarball, exits if found
2. Clones custom livecd-rootfs fork from Joshua-Riek
3. Builds and installs custom livecd-rootfs package
4. Configures live-build for ARM64:
   - Bootstrap with QEMU static
   - Ubuntu ports mirror
   - Rockchip kernel flavor
5. Sets up PPA pinning for Rockchip packages (jammy/noble)
6. Configures snap packages (snapd, core22, lxd)
7. Installs flavor-specific packages:
   - **Desktop**: ubuntu-desktop-rockchip, oem-config-gtk, ubiquity
   - **Server**: ubuntu-server-rockchip
8. Builds rootfs with `lb build`
9. Creates compressed tarball with xattrs

## Output
- `build/ubuntu-${RELASE_VERSION}-preinstalled-${FLAVOR}-arm64.rootfs.tar.xz`
