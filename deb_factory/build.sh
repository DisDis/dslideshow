#!/bin/sh
set -eu

cd -- "$(dirname -- "$0")"

error_exit()
{
    echo "Error: $1" >&2
    exit 1
}

PROFILE_ARC=arm64
DIR="dslideshow_$PROFILE_ARC"
CPU_TYPE=pi4
DEST=$DIR/opt/dslideshow/
SOURCE_BIN=./source_$PROFILE_ARC

# Keep versions and the previous staging directory intact if tests fail.
./run_tests.sh || error_exit "pre-build tests"

if [ -d "$DIR" ]; then
  echo "Folder '${DIR}' is exist"
  rm -r -f ./$DIR
fi

cp -r ./template_build_$PROFILE_ARC ./$DIR || error_exit "copy"

cd ../dslideshow_flutter
dart ../autover/bin/main.dart -c autover.yaml -v build --apply true || error_exit "version generation"
echo "--- Build 'DSlideshow' ---"
./build_aot_$CPU_TYPE.sh || error_exit "DSlideshow AOT '$CPU_TYPE'"

echo "--- Build 'config_app' ---"
cd ../config_app
./build_web.sh || error_exit "Config app"

echo "--- Create DEB package 'DSlideshow' ---"
cd ../deb_factory
cp -r ../dslideshow_flutter/build/flutter-pi/${CPU_TYPE}-64/* $DEST/ || error_exit "copy flutter_assets"
cp -f $SOURCE_BIN/flutter-pi/flutter-pi $DEST/ || error_exit "copy flutter-pi"
cp -r ../config_app/build/web $DEST/ || error_exit "copy config_app web"

# remove templates
rm $DEST/version.template

cd ./$DIR
md5deep -r -l opt > DEBIAN/md5sums || error_exit "md5deep"
cd ..

dpkg-deb -Zxz --build --root-owner-group ./$DIR || error_exit "Deb"

VERSION=`cat $DEST/version`
mv ./$DIR.deb ./dslideshow-$VERSION-$PROFILE_ARC-$CPU_TYPE.deb || error_exit "move"
echo "Last version dslideshow-$VERSION-$PROFILE_ARC-$CPU_TYPE.deb"

