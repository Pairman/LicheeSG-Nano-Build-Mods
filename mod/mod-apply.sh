#!/usr/bin/env bash

MOD_DIR=$(dirname "$(realpath "$BASH_SOURCE")")
SDK_DIR="$(realpath "$MOD_DIR/../LicheeSG-Nano-Build")"
if [ ! -d "$SDK_DIR" ]; then
    echo "SDK $SDK_DIR does not exist."
    exit 1
fi

# Apply configs
SDK_CONF="build/boards/sg200x/sg2002_licheervnano_sd/sg2002_licheervnano_sd_defconfig"
KERNEL_CONF="build/boards/sg200x/sg2002_licheervnano_sd/linux/sg2002_licheervnano_sd_defconfig"

mv -v "$SDK_DIR/$SDK_CONF" "$SDK_DIR/$SDK_CONF.bak"
mv -v "$SDK_DIR/$KERNEL_CONF" "$SDK_DIR/$KERNEL_CONF.bak"

cp -v "$MOD_DIR/$SDK_CONF" "$SDK_DIR/$SDK_CONF"
cp -v "$MOD_DIR/$KERNEL_CONF" "$SDK_DIR/$KERNEL_CONF"
cp -v "$MOD_DIR/$KERNEL_CONF" "$SDK_DIR/linux_5.10/arch/riscv/configs/"

# Apply patches
apply_patches() {
    local patches_dir="$1"
    local target_dir="$2"
    pushd "$target_dir"
    for patch_file in "$patches_dir"/*.patch; do
        echo "Applying patch '$patch_file'"
        patch -Np1 -i "$patch_file"
        if [ $? -ne 0 ]; then
            echo "Failed to apply patch: $patch_file"
            popd
            return 1
        fi
    done
    popd
    return 0
}

apply_patches "$MOD_DIR/patches/build/" "$SDK_DIR"
apply_patches "$MOD_DIR/patches/linux_5.10/" "$SDK_DIR/linux_5.10/"
apply_patches "$MOD_DIR/patches/osdrv/" "$SDK_DIR"
