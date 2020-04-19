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
  

## raspberry pi kernel build (model: pi 3 b+)
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
  