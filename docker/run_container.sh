#!/bin/sh
docker run -it --volume="$PWD/build:/workdir/pi" --volume="$PWD/build:/workdir/build" pi_kernel:imx-1
