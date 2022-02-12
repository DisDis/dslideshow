#!/bin/sh
FLUTTER_PATH=~/bin/flutter
OUTPUT_KERNEL_DILL=./build/kernel_snapshot.dill
OUTPUT_KERNEL_D=./build/kernel_snapshot.d
OUTPUT_SO=./build/flutter_assets/app.so
APPLICATION_ENTRY_POINT=package:dslideshow_flutter/main.dart
BUILD_PROFILE=release_64
ENGINE_BINARIES=.

echo "----------- README -----------"
echo "Instruction: https://github.com/ardera/flutter-pi/tree/engine-binaries"
echo "git clone --depth 1 --branch engine-binaries https://github.com/ardera/flutter-pi.git flutter_engine_binaries"

echo "------------------------"

CMD="$FLUTTER_PATH/bin/cache/dart-sdk/bin/dart \
  $FLUTTER_PATH/bin/cache/dart-sdk/bin/snapshots/frontend_server.dart.snapshot \
  --sdk-root $FLUTTER_PATH/bin/cache/artifacts/engine/common/flutter_patched_sdk_product \
  --target=flutter \
  --aot \
  --tfa \
  -Ddart.vm.product=true \
  --packages .packages \
  --output-dill $OUTPUT_KERNEL_DILL \
  --verbose \
  --depfile $OUTPUT_KERNEL_D \
  $APPLICATION_ENTRY_POINT"

echo "------------------------"
echo "$CMD"
eval $CMD

#  --lazy-async-stacks \
# 32bit
#CMD="$ENGINE_BINARIES/gen_snapshot_linux_x64_$BUILD_PROFILE \
#  --deterministic \
#  --snapshot_kind=app-aot-elf \
#  --elf=$OUTPUT_SO \
#  --strip \
#  --sim_use_hardfp \
#  $OUTPUT_KERNEL_DILL"

# 64bit
CMD="$ENGINE_BINARIES/gen_snapshot_linux_x64_$BUILD_PROFILE \
  --deterministic \
  --snapshot_kind=app-aot-elf \
  --elf=$OUTPUT_SO \
  --strip \
  $OUTPUT_KERNEL_DILL"

echo "$CMD"
eval $CMD

echo "Output: $OUTPUT_SO"
