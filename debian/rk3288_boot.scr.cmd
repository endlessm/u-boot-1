echo ">>> Loding uEnv.txt <<<"
ext4load ${devtype} ${devnum}:${distro_bootpart} ${scriptaddr} ${prefix}/uEnv.txt

echo ">>> Importing environment <<<"
env import -t ${scriptaddr} ${filesize}

echo ">>> Getting rootfs UUID <<<"
fsuuid ${devtype} ${devnum}:${distro_bootpart} rootuuid

echo ">>> Setting bootargs <<<"
setenv bootargs root=UUID=${rootuuid} ${bootargs}

echo ">>> Booting <<<"
ext4load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} ${prefix}/${kernel_image}
ext4load ${devtype} ${devnum}:${distro_bootpart} ${ramdisk_addr_r} ${prefix}/${ramdisk_image}
bootm ${kernel_addr_r} ${ramdisk_addr_r}:${filesize}
