# build-u-boot.sh

Builds U-Boot bootloader Debian package for specific board.

## Usage
```bash
./scripts/build-u-boot.sh
```

## Requirements
- Must run as root
- Requires `UBOOT_PACKAGE` environment variable

## Process
1. Checks if U-Boot package directory exists
2. If not, sources upstream configuration from `packages/${UBOOT_PACKAGE}/debian/upstream`
3. Clones U-Boot repository at specified branch and commit
4. Copies Debian packaging files from `packages/${UBOOT_PACKAGE}/debian/`
5. Determines build targets:
   - Primary: `UBOOT_RULES_TARGET`
   - Additional: `UBOOT_RULES_TARGET_EXTRA` (if set)
6. Builds U-Boot package using `dpkg-buildpackage`:
   - Architecture from `debian/arch`
   - No-clean build (`-nc`)
   - Binary-only (`-b`)
7. Cleans up build metadata files

## Output
- `build/u-boot-${BOARD}_*.deb`
