## docker build
~~~sh
cd docker
docker build -t pi_kernel:imx-1 .
~~~
  

## run container
~~~sh
cd docker
./run_container
or
docker run -it --volume="$PWD/build:/workdir/pi" --volume="$PWD/build:/workdir/build" pi_kernel:imx-1
~~~
  

## build kernel (model: pi 3 b+)
참고: https://www.raspberrypi.org/documentation/linux/kernel/building.md
  

 - download & configure cross compile toolchain
  
~~~sh
git clone https://github.com/raspberrypi/tools ~/tools  
echo PATH=\$PATH:~/tools/arm-bcm2708/arm-linux-gnueabihf/bin >> ~/.bashrc
source ~/.bashrc

for 32 bit os,
sudo apt install zlib1g-dev:amd64
~~~
  
 - download & configure kernel
  
~~~sh
git clone --depth=1 -b rpi-4.9.y https://github.com/raspberrypi/linux
cd linux
KERNEL=kernel7
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig
~~~

 - build
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs
  

## download firmware image using sdcard
raspberry pi는 sdcard로 firmware를 update할 수 있다.  
kernel build후 빌드왼 모듈들을 sdcard에 업데이트 해주는 방식으로
system image를 업데이트할 수 있다.  
sdcard로 업데이트를 하기위해서는 sdcard가 boot(fat32), rootfs(ext4) 파티션으로 구성되어있어야 한다.  
sdcard가 파티션이 나눠져있지 않다면, 먼저 아래링크를 통해서 os image를 sdcard에 설치해줘야 한다.  
https://www.raspberrypi.org/downloads/
  
~~~sh
# 아래 command로 sdcard 파티션을 확인한다.
$lsblk
sdb
   sdb1
   sdb2

$mkdir mnt
$mkdir mnt/fat32
$mkdir mnt/ext4
$sudo mount /dev/sdb6 mnt/fat32
$sudo mount /dev/sdb7 mnt/ext4

# 모듈들을 sdcard에 설치
$sudo env PATH=$PATH make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=mnt/ext4 modules_install

# dtb, kernel image 복사
sudo cp mnt/fat32/$KERNEL.img mnt/fat32/$KERNEL-backup.img
sudo cp arch/arm/boot/zImage mnt/fat32/$KERNEL.img
sudo cp arch/arm/boot/dts/*.dtb mnt/fat32/
sudo cp arch/arm/boot/dts/overlays/*.dtb* mnt/fat32/overlays/
sudo cp arch/arm/boot/dts/overlays/README mnt/fat32/overlays/
sudo umount mnt/fat32
sudo umount mnt/ext4
~~~