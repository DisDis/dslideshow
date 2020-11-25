#!/bin/sh
#./screenOn.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./

#debug mode
#./flutter-pi ./flutter_assets/

#release mode
#./flutter-pi -d "192, 120"  --release ./flutter_assets/
./flutter-pi  --release --no-text-input ./flutter_assets/

#Port Forwarding
#ssh -L 8998:localhost:36493 pi@192.168.1.223