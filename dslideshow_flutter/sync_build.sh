#!/bin/sh
TARGETUSER=pi
TARGET=192.168.1.223
APP_NAME=dslideshow
./build_linux.sh && ./build_aot.sh
rsync --info=progress2 --recursive ./build/flutter_assets/ $TARGETUSER@$TARGET:/home/$TARGETUSER/workspace/$APP_NAME/flutter_assets