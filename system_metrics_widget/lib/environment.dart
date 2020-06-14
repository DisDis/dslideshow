export 'package:system_metrics_widget/src/environment/default.dart'
  if (linux_embedded) 'package:system_metrics_widget/src/environment/linux.dart'
  if (dart.library.io) 'package:system_metrics_widget/src/environment/android.dart';

export 'package:dslideshow_backend/environment.dart';