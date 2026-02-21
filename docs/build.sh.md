# build.sh

Main build orchestration script for Ubuntu Rockchip images.

## Usage
```bash
./build.sh --board=<board> --suite=<suite> --flavor=<flavor> [options]
```

## Required Arguments
- `-b, --board` - Target board (e.g., turing-rk1, orangepi-5)
- `-s, --suite` - Ubuntu suite (jammy, noble, oracular, plucky, resolute)
- `-f, --flavor` - Ubuntu flavor (server, desktop)

## Optional Arguments
- `-h, --help` - Show help message
- `-c, --clean` - Clean build directory
- `-ko, --kernel-only` - Compile kernel only
- `-uo, --uboot-only` - Compile U-Boot only
- `-ro, --rootfs-only` - Build rootfs only
- `-l, --launchpad` - Use kernel/U-Boot from Launchpad repo
- `-v, --verbose` - Enable verbose output

## Behavior
- Must run as root
- Sources board, suite, and flavor configs from `config/` directory
- Builds kernel and U-Boot if not found (unless `--launchpad` specified)
- Creates rootfs and disk image
- Logs output to `build/logs/build-<timestamp>.log`
