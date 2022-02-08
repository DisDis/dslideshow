#!/bin/sh
./screenOff.sh
./screenOn.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./

#debug
#./flutter-pi -d "192, 120"  --no-text-input ./flutter_assets/
#release
#./flutter-pi -d "192, 120"  --no-text-input --release ./flutter_assets/
#release
#./flutter-pi  --release --no-text-input ./flutter_assets/

while true
do
	echo "Press [CTRL+C] to stop.."
	sleep 1
        ./flutter-pi --release ./flutter_assets/
done
#valgrind --leak-check=full \
#         --track-origins=yes \
#         --verbose \
#         --log-file=valgrind-out.txt \
#  ./flutter-pi  --release --no-text-input ./flutter_assets/
