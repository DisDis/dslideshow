#!/bin/sh
TARGETUSER=pi
TARGET=192.168.50.174
APP_NAME=dslideshow
./build_linux.sh && ./build_aot.sh
rsync --info=progress2 --recursive ./build/flutter_assets/ $TARGETUSER@$TARGET:/home/$TARGETUSER/workspace/$APP_NAME/flutter_assets
