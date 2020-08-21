export 'package:dslideshow_flutter/src/env/default.dart'
// Android & iOS
//  if (linux_embedded) 'package:dslideshow_flutter/src/env/linux.dart'
//  if (dart.library.io) 'package:dslideshow_flutter/src/env/android.dart';

//Enable for RaPi3/4
if (dart.library.io) 'package:dslideshow_flutter/src/env/linux.dart';

export 'package:dslideshow_backend/environment.dart';