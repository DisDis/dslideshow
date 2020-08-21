#!/bin/sh
#flutter config --enable-windows-desktop
#flutter create .
#TODO https://github.com/flutter/flutter/issues/48707
#flutter build bundle --dart-define=linux_embedded=true

#dart ../autover/bin/main.dart -c autover.yaml -v build --apply true

flutter build bundle

