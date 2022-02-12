#!/bin/sh
./scripts/screenOff.sh
./scripts/screenOn.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./

#debug
#./flutter-pi -d "192, 120"  ./flutter_assets/
#release
#./flutter-pi -d "192, 120"  --release ./flutter_assets/
#release
#./flutter-pi  --release ./flutter_assets/

while true
do
	echo "Press [CTRL+C] to stop.."
	sleep 1
        ./flutter-pi -d "192, 120"  --release ./flutter_assets/
done

