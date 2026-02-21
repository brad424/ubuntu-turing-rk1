# config-image.sh

Configures rootfs with board-specific packages and settings before image creation.

## Usage
```bash
./scripts/config-image.sh
```

## Requirements
- Must run as root
- Requires `BOARD`, `SUITE`, and `FLAVOR` environment variables
- Requires built kernel and U-Boot packages (unless `LAUNCHPAD=Y`)

## Process
1. Validates required Debian packages exist:
   - U-Boot package
   - Linux image, headers, modules, buildinfo, rockchip-headers
2. Extracts prebuilt rootfs tarball
3. Sets up chroot environment with bind mounts:
   - `/dev`, `/dev/pts`, `/proc`, `/sys`
   - `/sys/kernel/security`, `/sys/fs/cgroup`
   - Temporary mounts for `/tmp`, `/var/lib/apt/lists`, `/var/cache/apt`
4. Updates packages in chroot
5. Runs board-specific config hook (if defined)
6. Installs U-Boot and kernel packages:
   - **Launchpad mode**: Installs from PPA
   - **Local mode**: Installs built .deb files and holds packages
7. Updates initramfs
8. Cleans up packages and unmounts chroot
9. Creates rootfs tarball
10. Calls `build-image.sh` to create disk image

## Output
- Configured rootfs passed to build-image.sh
- Final disk image in `images/` directory
