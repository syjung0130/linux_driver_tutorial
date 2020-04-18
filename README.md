## docker build
cd docker  
docker build -t pi_kernel:imx-1 .  
  
## run container
cd docker  
./run_container  
or  
docker run -it --volume="$PWD/build:/workdir/pi" --volume="$PWD/build:/workdir/build" pi_kernel:imx-1  
  
## raspberry pi kernel build  
참고: https://www.raspberrypi.org/documentation/linux/kernel/building.md
git clone --depth=1 -b rpi-4.9.y https://github.com/raspberrypi/linux  
  
git clone https://github.com/raspberrypi/tools ~/tools  
echo PATH=\$PATH:~/tools/arm-bcm2708/arm-linux-gnueabihf/bin >> ~/.bashrc  
source ~/.bashrc  
or  
export PATH=~/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin:$PATH  
  
export TOOLCHAIN=~/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/  
export CROSS_COMPILE=arm-linux-gnueabihf-
export ARCH=arm

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig


cd linux/
