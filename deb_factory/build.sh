#!/bin/sh
PROFILE_ARC=arm64
DIR="dslideshow_$PROFILE_ARC"
CPU_TYPE=pi4
DEST=$DIR/opt/dslideshow/
SOURCE_BIN=./source_$PROFILE_ARC
if [ -d "$DIR" ]; then
  echo "Folder '${DIR}' is exist"
  rm -r -f ./$DIR
fi

error_exit()
{
    echo "Error: $1"
    exit 1
}


cp -r ./template_build_$PROFILE_ARC ./$DIR || error_exit "copy"

cd ../dslideshow_flutter
dart ../autover/bin/main.dart -c autover.yaml -v build --apply true
./build_aot_$CPU_TYPE.sh || error_exit "DSlideshow AOT '$CPU_TYPE'"
#cd ../config_app
#./build_web.sh || error_exit "Config app"
cd ../deb_factory

cp $SOURCE_BIN/flutter-pi/flutter-pi $DEST/ || error_exit "copy"
cp -r ../dslideshow_flutter/build/flutter_assets $DEST/ || error_exit "copy"
cp -r ../config_app/build/web $DEST/ || error_exit "copy"

# remove templates
rm $DEST/version.template

cd ./$DIR
md5deep -r opt > DEBIAN/md5sums || error_exit "md5deep"
cd ..

dpkg-deb -Zxz --build --root-owner-group ./$DIR || error_exit "Deb"

VERSION=`cat $DEST/version`
mv ./$DIR.deb ./dslideshow-$VERSION-$PROFILE_ARC-$CPU_TYPE.deb || error_exit "move"
echo "Last version dslideshow-$VERSION-$PROFILE_ARC-$CPU_TYPE.deb"

