pushd ..

SDK_CONF=build/boards/sg200x/sg2002_licheervnano_sd/sg2002_licheervnano_sd_defconfig
KERNEL_CONF=build/boards/sg200x/sg2002_licheervnano_sd/linux/sg2002_licheervnano_sd_defconfig

mv -v "$SDK_CONF" "$SDK_CONF.bak"
mv -v "$KERNEL_CONF" "$KERNEL_CONF.bak"

cp -v "mod/$SDK_CONF" "$SDK_CONF"
cp -v "mod/$KERNEL_CONF" "$KERNEL_CONF"

popd

