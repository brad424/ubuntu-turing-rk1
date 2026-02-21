# build-kernel.sh

Builds Linux kernel Debian packages for Rockchip boards.

## Usage
```bash
./scripts/build-kernel.sh
```

## Requirements
- Must run as root
- Requires `SUITE` environment variable

## Process
1. Sources suite configuration from `config/suites/${SUITE}.sh`
2. Clones/updates kernel repository from `KERNEL_REPO` at `KERNEL_BRANCH`
3. Configures cross-compilation for ARM64:
   - `CROSS_COMPILE=aarch64-linux-gnu-`
   - `CC=aarch64-linux-gnu-gcc`
4. Builds kernel using Debian rules:
   - `binary-headers` - Kernel headers package
   - `binary-rockchip` - Rockchip-specific kernel package
   - `do_mainline_build=true` - Mainline kernel build flag

## Output
Debian packages in `build/`:
- `linux-image-*.deb`
- `linux-headers-*.deb`
- `linux-modules-*.deb`
- `linux-buildinfo-*.deb`
- `linux-rockchip-headers-*.deb`
