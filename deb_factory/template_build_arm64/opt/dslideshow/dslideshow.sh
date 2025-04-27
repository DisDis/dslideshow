#!/bin/sh
export DSLIDESHOW_ROOT='/home/pi/dslideshow'
export DSLIDESHOW_EMBEDDED="true"

cd /opt/dslideshow
./scripts/screenOff.sh
./scripts/screenOn.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./
./flutter-pi --release --vulkan ./flutter_assets/


#debug
#./flutter-pi -d "192, 120"  ./flutter_assets/
#release
#./flutter-pi -d "192, 120"  --release ./flutter_assets/
#release
#./flutter-pi  --release ./flutter_assets/

#while true
#do
#	echo "Press [CTRL+C] to stop.."
#	sleep 1
#        ./flutter-pi --release ./flutter_assets/
#done

