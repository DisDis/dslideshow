#!/bin/sh
PROFILE_ARC=arm64
DIR="dslideshow_$PROFILE_ARC"
DEST=$DIR/opt/dslideshow/
SOURCE_BIN=./source_$PROFILE_ARC
if [ -d "$DIR" ]; then
  echo "Folder '${DIR}' is exist"
  rm -r -f ./$DIR
fi

cp -r ./template_build_$PROFILE_ARC ./$DIR

cd ../dslideshow_flutter
dart ../autover/bin/main.dart -c autover.yaml -v build --apply true
./build_aot.sh
cd ../deb_factory

cp $SOURCE_BIN/engine-binaries/icudtl.dat $DEST/
cp $SOURCE_BIN/engine-binaries/libflutter_engine.so.release $DEST/
cp $SOURCE_BIN/engine-binaries/engine.version $DEST/
cp $SOURCE_BIN/engine-binaries/dart-sdk.version $DEST/

cp $SOURCE_BIN/proxy_gpiod/libproxy_gpiod.so $DEST/
cp $SOURCE_BIN/flutter-pi/flutter-pi $DEST/
cp -r ../dslideshow_flutter/build/flutter_assets $DEST/

# remove templates
rm $DEST/version.template

# Scripts
cp ../scripts/dslideshow.sh $DEST/
cp -r ../scripts $DEST/

cd ./$DIR
md5deep -r opt > DEBIAN/md5sums
cd ..


dpkg-deb -Zxz --build --root-owner-group ./$DIR

VERSION=`cat $DEST/version`
mv ./$DIR.deb ./dslideshow-$VERSION-$PROFILE_ARC.deb
echo "Last version dslideshow-$VERSION-$PROFILE_ARC.deb"

