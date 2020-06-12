export 'package:system_metrics_widget/src/env/default.dart'
  if (linux_embedded) 'package:system_metrics_widget/src/env/linux.dart'
  if (dart.library.io) 'package:system_metrics_widget/src/env/android.dart';
//if (dart.library.io) 'package:system_metrics_widget/src/env/linux.dart';

export 'package:dslideshow_backend/environment.dart';