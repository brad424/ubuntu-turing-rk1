# build-image.sh

Creates bootable disk image from rootfs tarball.

## Usage
```bash
./scripts/build-image.sh <filename.rootfs.tar>
```

## Requirements
- Must run as root
- Requires `BOARD` environment variable
- Input must be a `.rootfs.tar` file

## Process
1. Creates empty disk image sized to rootfs + 2GB
2. Sets up loop device for disk operations
3. Creates partition table (GPT):
   - **Server**: 2 partitions (CIDATA boot + ext4 root)
   - **Desktop**: 1 partition (ext4 root)
4. Formats partitions and generates UUIDs
5. Extracts rootfs to root partition
6. Creates `/etc/fstab` entries
7. Writes U-Boot bootloader to disk
8. Runs board-specific build hooks
9. Updates U-Boot configuration
10. Compresses image to `.img.xz` with SHA256 checksum

## Output
- `images/<name>.img.xz` - Compressed disk image
- `images/<name>.img.xz.sha256` - Checksum file
