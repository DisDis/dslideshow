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

if [ -d "$DIR" ]; then
  echo "Folder '${DIR}' is exist"
  rm -r -f ./$DIR
fi

cp -r ./template_build_$PROFILE_ARC ./$DIR || error_exit "copy"

cd ../dslideshow_flutter
dart ../autover/bin/main.dart -c autover.yaml -v build --apply true || error_exit "version generation"
cd ../deb_factory

# Forward interruption to the supervisor, which owns all worker process groups.
PARALLEL_PID=
stop_parallel()
{
  trap '' INT TERM
  # $! also covers a signal between spawning the supervisor and saving its PID.
  WORKER_PID=${PARALLEL_PID:-${!:-}}
  if [ -n "$WORKER_PID" ]; then
    kill -TERM "$WORKER_PID" 2>/dev/null || :
    wait "$WORKER_PID" || :
  fi
}
trap 'stop_parallel; exit 130' INT
trap 'stop_parallel; exit 143' TERM
python3 ./run_parallel.py "../dslideshow_flutter/build_aot_$CPU_TYPE.sh" &
PARALLEL_PID=$!
PARALLEL_RESULT=0
wait "$PARALLEL_PID" || PARALLEL_RESULT=$?
trap - INT TERM
[ "$PARALLEL_RESULT" -eq 0 ] || error_exit "checks or application builds"

echo "--- Create DEB package 'DSlideshow' ---"
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

