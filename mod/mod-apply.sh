pushd ..

SDK_CONF="build/boards/sg200x/sg2002_licheervnano_sd/sg2002_licheervnano_sd_defconfig"
KERNEL_CONF="build/boards/sg200x/sg2002_licheervnano_sd/linux/sg2002_licheervnano_sd_defconfig"

mv -v "$SDK_CONF" "$SDK_CONF.bak"
mv -v "$KERNEL_CONF" "$KERNEL_CONF.bak"

cp -v "mod/$SDK_CONF" "$SDK_CONF"
cp -v "mod/$KERNEL_CONF" "$KERNEL_CONF"
cp -v "mod/$KERNEL_CONF" "linux_5.10/arch/riscv/configs/"

pushd "build"
patch -Np1 -i "../mod/patches/build/0000-genimage-enlarge-boot-partition.patch"
popd

pushd "linux_5.10/"
patch -Np1 -i "../mod/patches/linux_5.10/0001-clear-patches.patch"
patch -Np1 -i "../mod/patches/linux_5.10/0000-init-Kconfig-enable-O3-for-all-arches.patch"
popd

pushd "osdrv"
patch -Np1 -i "../mod/patches/osdrv/0000-fix-cvivcdrv-vpuapi-init.patch"
popd

popd
