#!/bin/sh
export DSLIDESHOW_ROOT='/home/pi/dslideshow'
export DSLIDESHOW_EMBEDDED="true"

cd /opt/dslideshow
./scripts/screenOff.sh
./scripts/screenOn.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./
#Vulkan version without video
#./flutter-pi --release --vulkan ./
./flutter-pi --release ./


#debug
#./flutter-pi -d "192, 120"  ./
#release
#./flutter-pi -d "192, 120"  --release ./
#release
#./flutter-pi  --release ./

#while true
#do
#	echo "Press [CTRL+C] to stop.."
#	sleep 1
#        ./flutter-pi --release ./
#done

