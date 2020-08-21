export 'package:dslideshow_backend/src/env/default.dart'

// Android & iOS
//if (linux_embedded) 'package:dslideshow_backend/src/env/linux.dart'
//if (dart.library.io) 'package:dslideshow_backend/src/env/android.dart';

//Enable for RaPi3/4
if (dart.library.io) 'package:dslideshow_backend/src/env/linux.dart';